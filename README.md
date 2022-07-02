# 简介

​	`QK-MONEY`一个基于Spring Boot2.5.4、Spring Security、MybatisPlus3.5 并提供如实现RBAC、JWT的权限认证解决方案、多租户等可拆卸模块化功能组件，采用前端后端分离（Vue-Element-Admin）的后台管理系统。

- JDK8语法、使用较新的技术栈，注重代码规范
- 自由拆卸组装功能，不强依赖Redis
- 尽可能低水平、低耦合高内聚
- 客制化配置

# 版本依赖

| 依赖         | 版本   |
| ------------ | ------ |
| JDK          | 1.8    |
| Maven        | 3.8.1  |
| Spring Boot  | 2.5.4  |
| Mybatis-plus | 3.5.0  |
| JJWT         | 0.11.2 |
| Hutool       | 5.7.9  |
| Jackson      | 2.12.4 |
| Spring Doc   | 1.5.11 |
| Qiniu        | 7.7.0  |

- 本项目的模块版本声明都在根目录下的`POM.xml`，称为**主POM**
- 第三方依赖版本声明都在`qk-money-parent`包下的`POM.xml`，称为**清单POM**

# 功能清单

- [x] 通用web功能配置（响应、异常处理、访问日志）
- [x] 基于RBAC模型和JWT的权限认证解决方案
    - [x] 与前端配套的系统管理（用户管理、角色管理、权限管理、字典管理、租户管理）
- [x] 多租户（基于表字段）
- [x] 缓存模块
    - [x] Hutool Cache
    - [ ] Caffeine
    - [x] Redis（支持Spring Cache）
- [x] 对象存储OSS
    - [x] 本地
    - [x] 七牛云
- [x] 国际化（多语言、多时区）
- [x] 接口文档（OpenAPI3）
- [x] 发送邮件
- [x] 代码生成器
- [x] 日志（logback），链路追踪
    - [x] 日志本地化
    - [x] MDC
- [x] ~~系统监控（Spring Boot Admin）~~

# 工程结构

| 模块                                                         | 描述                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `qk-money-parent`[📃!](./qk-money-parent/README.md)           | 👉父模块：BOM，依赖版本清单，其他模块都不能写具体版本号，需要新增的依赖要先在这声明版本信息 |
| `qk-money-app`                                               | 👉应用模块：**主要开发的模块**                                |
| `qk-money-app`/`money-app-api`                               | 应用api模块：放常量枚举、异常、Entity、DTO、VO等实体类       |
| `qk-money-app`/`money-app-biz`                               | 应用业务模块：放Controller、Service、Mapper等，**启动类所在** |
| `qk-money-app`/`money-app-system`                            | 应用系统模块：提供和前端配套的基于RBAC模型和JWT的权限认证、数据字典等系统管理功能，biz模块默认会引入 |
| `qk-money-common`                                            | 👉通用模块：                                                  |
| ~~`qk-money-common`/`money-common-core`~~                    | ~~（整合进common-web）通用核心模块：核心的常量枚举、通用异常和工具类（工具类能用[Hutool](https://www.hutool.cn/docs/#/)就不要重复造轮子）等。~~ |
| `qk-money-common`/`money-common-web`[📃!](./qk-money-common/money-common-web/README.md) | 通用web模块：**建议至少引入的模块**。<br />提供默认全局的响应返回、异常处理、请求日志切面、日志链路追踪、多语言、多时区等功能，减少项目的基础构建和规范。 |
| `qk-money-common`/`money-common-mybatis`                     | Mybatis模块：使用的是`Mybatis-Plus`，默认已配置分页插件、审计字段默认值填充（需继承`BaseEntity`）和**代码生成器**。 |
| `qk-money-common/money-common-cache`                         | 缓存模块：支持本地缓存和分布式缓存`Redis`                    |
| `qk-money-common/money-common-mail`[📃](./qk-money-common/money-common-mail/README.md) | 邮件模块：提供邮件发送功能                                   |
| `qk-money-common`/`money-common-oss`[📃](./qk-money-common/money-common-oss/README.md)` | OSS对象存储模块：提供本地文件OSS和七牛云OSS                  |
| `qk-money-common/money-common-swagger`[📃](./qk-money-common/money-common-swagger/README.md) | 接口文档模块：提供Open API 3（Swagger）                      |
| `qk-money-security`                                          | 👉安全模块：使用Spring Security框架，基于RBAC模型和JWT赋予认证授权能力 |
| `qk-money-tenant`                                            | 👉多租户模块：基于`Mybatis Plus`多租户插件实现多租户功能。    |

> 点击📃查看对应模块文档，带 ! 的开发前建议先看.

# 快速使用手册

## 主要开发模块`qk-money-app`

主要是在`qk-money-app`下进行开发，如工程结构介绍，启动类就在`money-app-biz`，所以二开的相关代码都将写在这里。

> qk-money-app -- 父项目
>
>   ├─money-app-api -- api模块
>
>   ├─money-app-biz -- 业务模块（引入api和system）
>
>   ├─money-app-system -- 权限管理系统模块

## 安全模块`qk-money-security`

赋予基于token认证、RBAC权限模型的认证授权管理能力。

1. 引入依赖

   ~~~xml
   <!-- 安全模块 -->
   <dependency>
       <groupId>com.money</groupId>
       <artifactId>qk-money-security</artifactId>
   </dependency>
   ~~~

2. 注入`RbacSecurityConfig`配置类

   这个配置类仅需实现一个返回`RbacUser`的方法，入参是安全模块解析token获取的username。所以你要做的就是通过用户名把`RbacUser`需要的信息如角色标识和权限标识填充好，这样安全模块就可以帮你完成认证和鉴权。

   ~~~java
   @Configuration(proxyBeanMethods = false)
   @RequiredArgsConstructor
   public class SecurityConfig {
   
       private final SysUserService sysUserService;
   
       @Bean
       public RbacSecurityConfig rbacSecurityConfig() {
           return username -> {
               SysUser sysUser = Optional
                       .ofNullable(sysUserService.getByUsername(username))
                       .orElseThrow(() -> new UsernameNotFoundException("用户名或密码错误"));
               List<SysRole> roles = sysUserService.getRoles(sysUser.getId());
               List<String> roleCodeList = roles
                       .stream().map(SysRole::getRoleCode).collect(Collectors.toList());
               List<String> permissions = sysUserService.getPermissions(sysUser.getId())
                       .stream().map(SysPermission::getPermission).collect(Collectors.toList());
               // 返回装填的rbac user
               RbacUser rbacUser = new RbacUser();
               rbacUser.setUserId(sysUser.getId());
               rbacUser.setUsername(sysUser.getUsername());
               rbacUser.setPassword(sysUser.getPassword());
               rbacUser.setEnabled(sysUser.getEnabled());
               rbacUser.setRoles(roleCodeList);
               rbacUser.setPermissions(permissions);
               return rbacUser;
           };
       }
   }
   ~~~

3. 颁发token，用于认证

   ```java
   // 注入
   private final SecurityTokenSupport securityTokenSupport;
   // 生成token
   securityTokenSupport.generateToken(username)
   ```

4. 权限判断 `@PreAuthorize("@rbac.hasPermission('user:add')")`

   安全模块会比较`RbacUser`里的**角色标识和权限标识**是否包含controller注解上的标识（包含其中一个就行），都不包含则为无权限。

   ~~~java
   @Operation(summary = "添加用户", tags = {"sysUser"})
   @PostMapping
   @PreAuthorize("@rbac.hasPermission('ADMIN','user:add')")
   public void addSysUser(@Validated(ValidGroup.Save.class) @RequestBody SysUserDTO sysUserDTO) {
       sysRoleService.checkLevelByRoleId(SecurityGuard.getRbacUser().getUserId(), sysUserDTO.getRoles());
       sysUserService.add(sysUserDTO);
   }
   ~~~

相关配置：

~~~yml
money:
 # 安全
  security:
    # token配置
    token:
      # token请求头名称
      header: Authorization
      # 令牌类型：完整token："{tokenType} {accessToken}"
      token-type: Bearer
      # 密钥
      secret: money
      # access token过期时间 ms，默认8小时
      ttl: 28800000
      # refresh token过期时间 ms，默认30天
      refresh-ttl: 2592000000
      # 策略：jwt（自动过期，默认）、redis
      strategy: jwt
      # 缓存键名
      cache-key: "security:token:"
    # 忽略的url
    ignore:
      get:
        - /tenants/byCode
        - /auth/refreshToken
      post:
        - /auth/login
        - /auth/logout
      pattern:
        - /error/**
        - /actuator/**
        - /swagger**/**
        - /webjars/**
        - /v3/**
        - /assets/**
        - /test/**
~~~

## 系统管理模块`money-app-system`

​		系统管理模块包含用户管理、角色管理、权限管理、数据字典管理、租户管理，一套完整的权限管理后台系统。它就是安全模块的一个实现。Biz默认会引入，你也可以拆掉，选择自己实现。

引入依赖即可

~~~xml
<!-- 系统模块 -->
<dependency>
    <groupId>com.money</groupId>
    <artifactId>money-app-system</artifactId>
</dependency>
~~~

## 多租户模块`qk-money-tenant`

赋予基于表字段的多租户隔离数据能力。（使用的是Mybatis plus的多租户插件）

- 为要区分租户的表添加字段`tenant_id`
- 所有sql和mybatis plus操作不需要显示的写租户条件过滤，无感介入！

引入依赖

~~~xml
<!-- 多租户模块 -->
<dependency>
    <groupId>com.money</groupId>
    <artifactId>qk-money-tenant</artifactId>
</dependency>
~~~

相关配置：

~~~yml
money:
  # 多租户
  tenant:
    # 开关
    enabled: false
    # 请求头
    header: Y-tenant
    # 忽略的表
    ignore-table:
      - sys_tenant
~~~

# 配置总览

`qk-money-app/money-app-biz/resources/application-money.yml`

~~~yml
spring:
  config:
    # 引入对象存储的配置
    import: oss.properties
money:
  web:
    # 全局响应处理器
    response-handler: true
    # 全局异常处理器
    exception-handler: true
    # 全局请求日志切面
    web-log-aspect: true
  # 多租户
  tenant:
    # 开关
    enabled: false
    # 请求头
    header: Y-tenant
    # 忽略的表
    ignore-table:
      - 
  # 缓存
  cache:
    # 本地缓存
    local:
      # 提供者 hutool（默认）、caffeine
      provider: hutool
      # 过期时间：ms，0代表永不过期
      ttl: 86400000
      # hutool-cache参数
      hutool:
        # 失效策略：LRU（默认）、LFU、FIFO、TIMED、WEAK
        strategy: LRU
        # 容量
        capacity: 102400
    # redis 缓存
    redis:
      # 开关，默认关闭
      enabled: false
      # 过期时间：ms，主要用于@Cacheable相关注解的过期时间
      ttl: 86400000
  # 安全
  security:
    # token配置
    token:
      # token请求头名称
      header: Authorization
      # 令牌类型：完整token："{tokenType} {accessToken}"
      token-type: Bearer
      # 密钥
      secret: money
      # access token过期时间 ms，默认8小时
      ttl: 28800000
      # refresh token过期时间 ms，默认30天
      refresh-ttl: 2592000000
      # 策略：jwt（自动过期，默认）、redis
      strategy: jwt
      # 缓存键名
      cache-key: "security:token:"
    # 忽略的url
    ignore:
      get:
        - /tenants/byCode
        - /auth/refreshToken
      post:
        - /auth/login
        - /auth/logout
      pattern:
        - /error/**
        - /actuator/**
        - /swagger**/**
        - /webjars/**
        - /v3/**
        - /assets/**
        - /test/**
  # 邮件服务
  mail:
    host: smtp.qq.com # 邮箱服务器
    username: 374648769@qq.com
    password:  # 授权码（得去邮箱获取）
    properties:
      mail:
        smtp:
          auth: true # 使用
          starttls: # 使用 SSL 安全协议，必须配置如下
            enable: true
            required: true
    port: 465  # 端口
    protocol: smtps # 协议
    default-encoding: utf-8
    fromAlias: 麦尼 # 发件人别名
~~~

