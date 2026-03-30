# money-common-oss - 对象存储模块

## 概述

对象存储模块提供文件上传、下载和删除功能，支持**本地存储**和**七牛云存储**两种方式。

**设计优势**：
- **委托模式**：通过 `OSSDelegate<T>` 统一调用不同存储服务，使用方式一致
- **灵活切换**：支持本地存储和七牛云存储，可同时使用
- **统一接口**：`OSSInterface` 提供统一的上传、删除操作
- **路径构建器**：`FolderPath` 链式构建文件夹路径
- **文件名策略**：`FileNameStrategy` 支持多种命名方式

## 依赖

```xml
<!-- 对象存储模块 -->
<dependency>
    <groupId>com.money</groupId>
    <artifactId>money-common-oss</artifactId>
</dependency>

<!-- 七牛云存储（若使用七牛云需引入） -->
<dependency>
    <groupId>com.qiniu</groupId>
    <artifactId>qiniu-java-sdk</artifactId>
</dependency>
```

## 使用方式

### 基本使用

注入 `OSSDelegate` 使用：

```java
// 本地存储
@Autowired
@Qualifier("localOSSDelegate")
private OSSDelegate<LocalOSS> localOSSDelegate;

// 七牛云存储
@Autowired
@Qualifier("qiniuOSSDelegate")
private OSSDelegate<QiniuOSS> qiniuOSSDelegate;
```

### 文件上传

```java
@PostMapping("/upload")
public R<String> upload(@RequestParam("file") MultipartFile file) {
    // 默认上传（使用时间戳文件名）
    String uri = localOSSDelegate.upload(file);
    return R.success(uri);
}
```

### 指定文件夹和文件名策略

```java
@PostMapping("/upload/avatar")
public R<String> uploadAvatar(@RequestParam("file") MultipartFile file) {
    // 上传到 avatar 文件夹，使用 UUID 文件名
    FolderPath folderPath = FolderPath.builder()
            .addPath("avatar")
            .build();
    String uri = localOSSDelegate.upload(file, folderPath, FileNameStrategy.UUID);
    return R.success(uri);
}
```

### 文件删除

```java
public void deleteFile(String uri) {
    localOSSDelegate.delete(uri);
}
```

## 配置说明

在 `application-money.yml` 中配置：

```yaml
money:
  oss:
    # 本地存储
    local:
      # 目标空间（存储根目录）
      bucket: F:/qk-money/
      # 资源处理器（访问路径映射）
      resource-handler: /assets/**
    # 七牛云存储
    qiniu:
      # 访问密钥
      access-key: your-access-key
      # 秘密密钥
      secret-key: your-secret-key
      # 访问域名
      domain: your-domain.com
      # 目标空间（Bucket）
      bucket: your-bucket
      # 区域
      region: huanan
      # 上传令牌过期时间（秒）
      token-expire: 3600
```

## 核心类说明

| 类名/接口 | 说明 |
|-----------|------|
| `OSSDelegate<T>` | 对象存储服务委托类，提供统一的上传、删除接口 |
| `OSSInterface` | 存储服务接口（本地存储和七牛云存储的共同接口） |
| `LocalOSS` | 本地存储实现 |
| `QiniuOSS` | 七牛云存储实现 |
| `FolderPath` | 文件夹路径构建器（链式调用） |
| `FileNameStrategy` | 文件名策略（函数式接口） |

### 文件名策略

内置策略：

| 策略 | 说明 | 示例 |
|------|------|------|
| `TIMESTAMP` | 时间戳命名 | `1672531200000.jpg` |
| `UUID` | UUID 命名 | `550e8400-e29b-41d4-a716-446655440000.jpg` |
| `RAW` | 原始文件名 | `original.jpg` |

也支持自定义策略（实现 `FileNameStrategy` 接口）。

### 路径构建器

```java
// 链式构建路径
FolderPath folderPath = FolderPath.builder()
        .addPath("users")
        .addPath(userId.toString())
        .addPath("avatars")
        .build();
// 结果：users/123/avatars/
```

## 注意事项

1. **本地存储路径**：确保 `local.bucket` 配置的路径存在且有写权限
2. **资源映射**：本地存储需配置 `local.resource-handler` 映射，使上传的文件可访问
3. **七牛云密钥**：妥善保管访问密钥，不要提交到代码仓库
4. **文件大小限制**：需在 Spring Boot 中配置文件上传大小限制

```yaml
spring:
  servlet:
    multipart:
      max-file-size: 10MB
      max-request-size: 10MB
```

## 相关链接

- [Spring MVC 文件上传](https://docs.spring.io/spring-framework/docs/current/reference/html/web.html#mvc-multipart)
- [七牛云对象存储文档](https://developer.qiniu.com/kodo)
