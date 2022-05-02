package com.money.common;


import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @author : money
 * @version : 1.0.0
 * @description : web配置
 * @createTime : 2021-09-11 10:01:34
 */
@Configuration
@EnableConfigurationProperties(CommonWebProperties.class)
public class CommonWebConfiguration {

}
