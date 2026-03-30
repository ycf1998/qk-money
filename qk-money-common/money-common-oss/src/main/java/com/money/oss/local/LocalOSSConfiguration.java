package com.money.oss.local;

import com.money.oss.OSSDelegate;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 本地 OSS 配置
 *
 * @author : money
 * @since : 1.0.0
 */
@EnableConfigurationProperties(LocalOSSConfig.class)
@Configuration(proxyBeanMethods = false)
public class LocalOSSConfiguration {

    @Bean
    public OSSDelegate<LocalOSS> localOSS(LocalOSSConfig config) {
        return new OSSDelegate<>(new LocalOSS(config));
    }

    @Bean
    public ResourceMappingConfig resourceMappingConfig(LocalOSSConfig config) {
        return new ResourceMappingConfig(config);
    }

}
