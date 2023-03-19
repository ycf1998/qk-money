package com.money.controller;

import com.money.mail.domian.MailRequest;
import com.money.mail.interceptor.PostmanInterceptor;
import com.money.mail.service.MailService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.nio.file.Paths;

/**
 * @author : money
 * @version : 1.0.0
 * @description : 邮件演示控制器
 * @createTime : 2022-05-14 10:07:58
 */
@RestController
@RequestMapping("/demo/mail")
@RequiredArgsConstructor
public class MailDemoController {

    private final MailService mailService;

    @GetMapping
    public void sendMail(String to) {
        // curl "http://localhost:9000/qk-money/demo/mail?to=你的邮箱"

        MailRequest mailRequest = new MailRequest(to, "邮件测试", "<h1>你好，玛卡巴卡！你好，无锡底细</h1>")
                // 内容解析为html
                .setHtml(true)
                // 添加拦截器
                .addPostmanInterceptor(new PostmanInterceptor() {
                    @Override
                    public void beforeSending(MailRequest mailRequest) {
                        System.out.println("发送邮件前");
                    }

                    @Override
                    public void sendSucceeded(MailRequest mailRequest) {
                        System.out.println("邮件发送成功");
                    }

                    @Override
                    public void sendFailed(MailRequest mailRequest, Exception e) {
                        System.out.println("邮件发送失败");
                    }
                })
                // 添加附件
                .addAttachment("附件1", Paths.get("D://money.jpg").toFile());
        mailService.send(mailRequest);
    }

}
