package com.money.controller;

import com.alibaba.fastjson2.JSONObject;
import com.money.oss.OSSDelegate;
import com.money.oss.core.FileNameStrategy;
import com.money.oss.core.FolderPath;
import com.money.oss.local.LocalOSS;
import com.money.oss.local.LocalOSSConfig;
import com.money.oss.qiniu.QiniuOSS;
import com.money.oss.qiniu.QiniuOSSConfig;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author : money
 * @version : 1.0.0
 * @description : 对象存储服务演示控制器
 * @createTime : 2022-07-02 21:41:19
 */
@RestController
@RequestMapping("/demo/oss")
@RequiredArgsConstructor
public class OssDemoController {

    /**
     * 使用OSS包装器
     */
    private final OSSDelegate<LocalOSS> localOSS;
    /**
     * 配置类使用中不用引入，只是为了告诉里面的配置是干啥的
     */
    private final LocalOSSConfig localOSSConfig;

    /**
     * 测试七牛云需要填写好配置文件并且添加七牛云依赖哦
     */
    @Autowired(required = false)
    private OSSDelegate<QiniuOSS> qiniuOSS;
    @Autowired(required = false)
    private QiniuOSSConfig qiniuOSSConfig;

    /**
     * 本地上传（content-type 以multipart/form-data的方式）
     *
     * @param file 文件
     * @return {@link String}
     */
    @PostMapping("/local/upload")
    public String localUpload(@RequestParam("file") MultipartFile file) {
        // 上传
        FolderPath folderPath = FolderPath.builder().cd("oss").build();
        String upload = localOSS.upload(file, folderPath, FileNameStrategy.TIMESTAMP);
        // 文件在哪
        String where = localOSSConfig.getBucket() + folderPath.getFolderPath();
        System.out.println("文件将会上传到" + where);
        // 怎么取
        String projectPath = "http://localhost:9000/qk-money";
        String mapUrl = localOSSConfig.getResourceHandler().substring(0, localOSSConfig.getResourceHandler().lastIndexOf("/") + 1);
        String downloadUri = projectPath + mapUrl + upload;
        System.out.println("下载路径就是后端项目路径加指定的映射路径在加原本上传返回的路径（正常这个存数据库的）" + downloadUri);
        return downloadUri;
    }

    @Data
    static class MyForm {

        private String name;

        private MultipartFile file;

        // ...
    }

    /**
     * 跟随表单上传（content-type 以multipart/form-data的方式）
     * </p>
     * 前端就常见的FormData对象填充提交
     *
     * @param data 数据
     * @return {@link String}
     */
    @PostMapping("/local/uploadWithForm")
    public String localUpload(MyForm data) {
        System.out.println(data.name);
        return localUpload(data.file);
    }

    /**
     * JSON数据混合上传（content-type 以multipart/mixed的方式）
     * </p>
     * 前端数据填充例子：
     * const formData = new FormData()
     * let data = {}
     * formData.append('data', new Blob([JSON.stringify(data)], {
     * type: 'application/json'
     * }))
     * formData.append('file', file)
     *
     * @param file 文件
     * @param data 数据（演示就不创建对象了）
     * @return {@link String}
     */
    @PostMapping("/local/uploadWithJson")
    public String localUpload(@RequestPart("data") JSONObject data,
                              @RequestPart(required = false) MultipartFile file) {
        System.out.println(data);
        return localUpload(file);
    }

    /**
     * 七牛云上传（content-type 以multipart/form-data的方式）
     *
     * @param file 文件
     * @return {@link String}
     */
    @PostMapping("/qiniu/upload")
    public String qiniuUpload(@RequestParam("file") MultipartFile file) {
        // 上传
        FolderPath folderPath = FolderPath.builder().cd("oss").build();
        String upload = qiniuOSS.upload(file, folderPath, FileNameStrategy.TIMESTAMP);
        // 文件(七牛云有空间概念即Bucket)
        System.out.println("文件将会上传到" + qiniuOSSConfig.getBucket() + "空间下的文件夹" + folderPath.getFolderPath());
        // 怎么取 （包装器所包装的服务可能有自己一些特殊的方法）
        String downloadUri = qiniuOSS.getProvider().getDownloadUrl(upload);
        System.out.println("七牛云服务有提供API获取下载路径" + downloadUri);
        return downloadUri;
    }
}
