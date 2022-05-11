package com.money.common;

import com.money.common.i18n.I18nProperties;
import com.money.common.i18n.I18nSupport;
import com.money.common.timezone.TimezoneProperties;
import lombok.Data;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * @author : money
 * @version : 1.0.0
 * @description : 通用web属性
 * @createTime : 2022-05-02 11:39:18
 */
@Data
@ConfigurationProperties("money.web")
public class CommonWebProperties implements InitializingBean {

    /**
     * 全局响应处理器
     */
    private boolean responseHandler = true;

    /**
     * 全局异常处理器
     */
    private boolean exceptionHandler = true;

    /**
     * 全局请求日志切面
     */
    private boolean webLogAspect = true;

    /**
     * 国际化
     */
    private I18nProperties i18n = new I18nProperties();

    /**
     * 时区
     */
    private TimezoneProperties timezone = new TimezoneProperties();

    @Override
    public void afterPropertiesSet() {
        // 多语言
        if (i18n.isEnabled()) {
            I18nSupport.enableI18n(i18n);
        }
    }
}
