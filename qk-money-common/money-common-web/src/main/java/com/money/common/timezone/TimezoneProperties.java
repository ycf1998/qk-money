package com.money.common.timezone;

import cn.hutool.core.date.DatePattern;
import lombok.Data;

/**
 * @author : money
 * @version : 1.0.0
 * @description : 时区属性
 * @createTime : 2022-05-02 11:44:01
 */
@Data
public class TimezoneProperties {

    /**
     * 默认时区
     */
    private String defaultTimezone = "GMT+08:00";

    /**
     * 日期格式
     */
    private String dateFormat = DatePattern.NORM_DATETIME_PATTERN;

}
