# QWEN.md - Qk-MONEY 项目上下文指南

## 项目概述

**Qk-MONEY** 是一个基于 Spring Boot 2.7 的后台快速开发框架，采用组件化设计，支持前后端分离架构。项目以"钱/麦尼"命名，主要定位为收银系统后台框架。

### 核心技术栈

| 技术 | 版本 | 说明 |
|------|------|------|
| JDK | 1.8+ | Java 运行环境 |
| Spring Boot | 2.7.18 | 核心框架 |
| MyBatis-Plus | 3.5.7 | ORM 框架 |
| Spring Security | 内置 | 安全认证 |
| JJWT | 0.11.5 | JWT 令牌 |
| Hutool | 5.8.34 | 工具集 |
| XXL-JOB | 2.3.1 | 分布式任务调度 |
| MySQL | 8.0+ | 数据库 |
| Redis | - | 缓存（可选） |
| 七牛云 | 7.13.1 | 对象存储（可选） |

### 工程结构

```
qk-money/
├── qk-money-parent/          # BOM 依赖清单，管理第三方依赖版本
├── qk-money-common/          # 通用模块集合
│   ├── money-common-web/     # Web 核心：全局响应/异常处理、日志链路、多语言/时区
│   ├── money-common-mybatis/ # MyBatis 扩展：分页、代码生成器
│   ├── money-common-cache/   # 缓存：Hutool Cache / Redis
│   ├── money-common-oss/     # 对象存储：本地 / 七牛云
│   ├── money-common-mail/    # 邮件发送
│   ├── money-common-schedule/# 定时任务：XXL-JOB 集成
│   └── money-common-swagger/ # 接口文档：OpenAPI 3
├── qk-money-security/        # 安全模块：JWT + RBAC 认证授权
├── qk-money-tenant/          # 多租户模块：基于 MyBatis-Plus 表字段隔离
├── qk-money-app/             # 应用模块（主要开发模块）
│   ├── money-app-api/        # API 层：Entity、DTO、VO、常量枚举
│   ├── money-app-biz/        # 业务层：Controller、Service、Mapper（启动类所在）
│   └── money-app-system/     # 系统管理：预设的权限管理系统
└── xxl-job-admin/            # XXL-JOB 调度中心
```

## 构建与运行

### 环境要求

- JDK 1.8+
- Maven 3.8.1+
- MySQL 8.0+（或 MySQL 5.7+，需调整字符集）
- Redis（可选，用于缓存和 Token 策略）

### 快速启动

1. **克隆项目**
   ```bash
   git clone https://github.com/ycf1998/qk-money
   cd qk-money
   ```

2. **创建并初始化数据库**
   ```bash
   mysql -u root -p < qk_money.sql
   ```
   或使用图形化工具（Navicat 等）导入 `qk_money.sql`

3. **配置数据库连接**
   
   编辑 `qk-money-app/money-app-biz/src/main/resources/application-dev.yml`：
   ```yaml
   spring:
     datasource:
       url: jdbc:mysql://127.0.0.1:3306/qk_money?...
       username: root
       password: your_password
   ```

4. **启动应用**
   
   运行主类：`com.money.QkMoneyApplication`
   
   或使用 Maven：
   ```bash
   mvn spring-boot:run -pl qk-money-app/money-app-biz
   ```

5. **访问接口文档**
   
   默认地址：`http://localhost:9000/qk-money/swagger-ui.html`

### 构建打包

```bash
mvn clean package -DskipTests
```

打包位置：`qk-money-app/money-app-biz/target/`

## 开发指南

### 模块依赖关系

```
qk-money-app (应用层)
    ├── qk-money-security (安全认证)
    ├── qk-money-tenant (多租户)
    └── qk-money-common/* (通用模块)
```

### 典型开发流程（二次开发）

1. **创建数据库表**
   ```sql
   CREATE TABLE `demo` (
     `id` bigint UNSIGNED NOT NULL,
     `name` varchar(255) NOT NULL COMMENT '名称',
     `create_by` varchar(32) NOT NULL,
     `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
     `update_by` varchar(32) NOT NULL,
     `update_time` datetime NOT NULL,
     `tenant_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '租户 id',
     PRIMARY KEY (`id`)
   );
   ```
   - 基础字段：`id`, `create_by`, `create_time`, `update_by`, `update_time`
   - 可选字段：`tenant_id`（需要多租户隔离时添加）

2. **运行代码生成器**
   
   执行 `money-common-mybatis` 模块下的 `MybatisPlusGenerator` 类，生成 CRUD 代码。

3. **补充业务逻辑**
   
   在生成的代码基础上，于 `money-app-biz` 模块中补充具体业务逻辑。

### 核心功能使用

#### 1. 安全认证（qk-money-security）

配置 `RbacSecurityConfig` 提供用户详情加载：

```java
@Bean
public RbacSecurityConfig rbacSecurityConfig() {
    return username -> {
        // 从数据库加载用户信息
        SysUser user = userService.getByUsername(username);
        // 构建 RbacUser 对象
        RbacUser rbacUser = new RbacUser();
        rbacUser.setUserId(user.getId());
        rbacUser.setUsername(user.getUsername());
        rbacUser.setPassword(user.getPassword());
        rbacUser.setEnabled(user.getEnabled());
        rbacUser.setRoles(roleCodeList);
        rbacUser.setPermissions(permissions);
        return rbacUser;
    };
}
```

**获取当前用户信息：**
```java
// 方式 1：通过上下文
RbacUser user = SecurityGuard.getRbacUser();

// 方式 2：通过注解
public void method(@CurrentUser RbacUser user) { }
public void method(@CurrentUser Long userId) { }
```

**权限控制注解：**
```java
@PreAuthorize("hasAuthority('system:user:add')")
@PreAuthorize("hasRole('ADMIN')")
```

#### 2. 多租户（qk-money-tenant）

配置 `application-money.yml`：
```yaml
money:
  tenant:
    enabled: true
    header: Y-tenant
    default-tenant-id: "0"
    ignore-table:
      - sys_tenant
      - sys_dict
```

获取当前租户 ID：
```java
Long tenantId = TenantContextHolder.getTenant();
```

#### 3. 全局响应与异常处理（money-common-web）

- 返回值自动包装为 `R<T>` 格式：`{code: 200, data: T, message: "操作成功"}`
- 抛出 `BaseException` 由全局异常处理器统一处理
- 忽略全局响应处理：使用 `@IgnoreGlobalResponse` 注解

#### 4. 缓存模块（money-common-cache）

支持本地缓存（Hutool/Caffeine）和 Redis：
```yaml
money:
  cache:
    local:
      provider: hutool  # 或 caffeine
    redis:
      enabled: false
      ttl: 86400000
```

#### 5. 对象存储（money-common-oss）

配置 `oss.properties`：
```properties
# 本地存储
local.bucket = F:/qk-money/
local.resource-handler = /assets/**

# 七牛云
qiniu.access-key = ...
qiniu.secret-key = ...
qiniu.bucket = qk-money
```

### 配置总览

主要配置文件位置：`qk-money-app/money-app-biz/src/main/resources/`

| 文件 | 说明 |
|------|------|
| `application.yml` | 主配置：端口、上下文路径、Swagger |
| `application-dev.yml` | 开发环境配置：数据库、Redis、XXL-JOB |
| `application-money.yml` | 框架客制化配置：安全、租户、缓存、邮件等 |
| `oss.properties` | 对象存储配置 |
| `logback-spring.xml` | 日志配置 |

### 常用工具类

| 工具类 | 说明 |
|--------|------|
| `BeanMapUtil` | 对象属性复制（基于 Hutool） |
| `IpUtil` | IP 地址获取与地理位置 |
| `WebUtil` | Web 上下文获取（Request/Response） |
| `ValidationUtil` | 手动参数校验 |
| `PageUtil` | 分页数据转换（MyBatis-Plus Page → PageVO） |
| `I18nSupport` | 多语言支持 |
| `SecurityTokenSupport` | Token 生成/验证/刷新 |
| `PasswordEncoder` | 密码加密 |

### 请求上下文

通过 `WebRequestContextHolder` 获取：
```java
WebRequestContextHolder.getContext().getRequestId();  // 请求 ID（日志链路追踪）
WebRequestContextHolder.getContext().getLang();        // 语言环境
WebRequestContextHolder.getContext().getTimezone();    // 时区
```

## 测试实践

- 使用 `@SpringBootTest` 进行集成测试
- 使用 `@WebMvcTest` 进行 Controller 层测试
- 使用 `@MockBean` 模拟依赖服务

## 代码规范

- 遵循阿里巴巴 Java 开发手册
- 使用 Lombok 简化代码（`@Data`, `@Builder`, `@NoArgsConstructor` 等）
- 实体类继承 `BaseEntity` 获得审计字段
- 业务异常抛出 `BaseException` 或其子类
- Controller 返回值无需手动包装 `R<T>`（全局响应处理自动包装）

## 常见问题

### 数据库字符集
MySQL 5.7 及以下版本需将 `utf8mb4` 替换为 `utf8`，`utf8mb4_general_ci` 替换为 `utf8_general_ci`。

### Token 策略
- `jwt`（默认）：自动过期，无法手动失效
- `redis`：可手动失效 Token，需启用 Redis

### 日志路径
日志默认输出到项目根目录 `log/` 文件夹：
- `service.log` - 服务日志
- `error.log` - 错误日志
- `access.log` - 请求访问日志

## 相关项目

- 前端配套：[Qk-MONEY UI](https://github.com/ycf1998/qk-money-ui)
- 应用案例：[麦尼收银系统](https://github.com/ycf1998/money-pos)

## 文档资源

详细模块文档位于 `doc/` 目录：
- [qk-money-parent.md](./doc/qk-money-parent.md) - BOM 依赖清单
- [qk-money-security.md](./doc/qk-money-security.md) - 安全模块
- [qk-money-tenant.md](./doc/qk-money-tenant.md) - 多租户模块
- [money-common-web.md](./doc/money-common-web.md) - Web 核心模块
- 其他模块文档...
