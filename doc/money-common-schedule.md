# money-common-schedule - 定时任务模块

## 概述

定时任务模块集成 XXL-JOB 分布式任务调度框架，提供定时任务功能。模块通过配置类自动装配 XXL-JOB 执行器。

**设计优势**：
- **开箱即用**：自动配置 XXL-JOB 执行器，无需手动初始化
- **配置集中**：通过 `XxlJobProperties` 统一管理配置
- **注解支持**：支持 `@XxlJob`、`@XxlJobParam` 等注解

## 依赖

```xml
<!-- 定时任务模块 -->
<dependency>
    <groupId>com.money</groupId>
    <artifactId>money-common-schedule</artifactId>
</dependency>
```

## 使用方式

### 1. 调度中心（xxl-job-admin）

调度中心为独立工程 `xxl-job-admin`：

1. 执行 `xxl-job-admin/doc/db/tables_xxl_job.sql` 初始化数据库
2. 配置调度中心地址、访问令牌等
3. 启动调度中心，访问管理面板

### 2. 执行器（业务工程）

#### 配置

```yaml
xxl:
  job:
    access-token: MONEY  # 调度中心访问令牌
    admin:
      address: http://127.0.0.1:8000/xxl-job-admin  # 调度中心地址
    executor:
      app-name: ${spring.application.name}  # 执行器名称
      port: 0  # 执行器端口（0 表示自动获取）
      log-path: log/xxl-job/jobhandler
      log-retention-days: 30
```

#### 开发任务 Handler

```java
@XxlJob("demoJobHandler")
public void demoJobHandler() throws Exception {
    log.info("定时任务执行了");
}
```

#### 分片广播任务

```java
@XxlJob("shardingJobHandler")
public void shardingJobHandler() throws Exception {
    int shardIndex = XxlJobHelper.getShardIndex();
    int shardTotal = XxlJobHelper.getShardTotal();
    log.info("分片参数：当前第 {} 片，总共 {} 片", shardIndex, shardTotal);
}
```

### 3. 配置任务

1. 登录调度中心管理面板
2. 进入 **执行器管理**，新建执行器（appName 需与配置一致）
3. 进入 **任务管理**，新建任务：
   - 选择执行器
   - 配置 JobHandler（与 `@XxlJob` 值一致）
   - 配置 Cron 表达式
   - 选择运行模式（BEAN）

## 配置说明

### Cron 表达式示例

| Cron 表达式 | 说明 |
|------------|------|
| `0 0 12 * * ?` | 每天 12 点执行 |
| `0 0/30 9-17 * * ?` | 工作日 9-17 点每 30 分钟执行 |
| `0 0 2 ? * MON` | 每周一凌晨 2 点执行 |

### 路由策略

| 策略 | 说明 |
|------|------|
| 第一个/最后一个 | 固定选择节点 |
| 轮询 | 按顺序轮询 |
| 随机 | 随机选择 |
| 一致性 HASH | 相同参数路由到同一节点 |
| 分片广播 | 广播所有节点执行分片任务 |

## 核心类说明

| 类名 | 说明 |
|------|------|
| `XxlJobConfiguration` | 自动配置类，注册 `XxlJobSpringExecutor` |
| `XxlJobProperties` | 配置属性类（admin、executor、accessToken） |

## 常用注解

| 注解 | 说明 |
|------|------|
| `@XxlJob` | 定义任务 Handler |
| `@XxlJobParam` | 任务参数 |
| `@XxlJobInit` / `@XxlJobStart` / `@XxlJobEnd` | 任务生命周期 |

## 注意事项

1. **执行器名称**：确保 `app-name` 与调度中心配置的执行器一致
2. **访问令牌**：执行器和调度中心的 `access-token` 必须一致
3. **网络连通**：执行器需能访问调度中心，调度中心需能回调执行器
4. **任务幂等**：分布式环境下需保证任务幂等性

## 相关链接

- [XXL-JOB 官方文档](https://www.xuxueli.com/xxl-job/)
- [XXL-JOB GitHub](https://github.com/xuxueli/xxl-job)
