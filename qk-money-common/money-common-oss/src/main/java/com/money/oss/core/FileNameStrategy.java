package com.money.oss.core;

import cn.hutool.core.util.RandomUtil;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.Instant;
import java.util.function.BiFunction;

/**
 * @author : money
 * @version : 1.0.0
 * @description : 文件名称策略
 * @createTime : 2022-01-01 16:47:44
 */
@AllArgsConstructor
@Getter
public enum FileNameStrategy {
    /**
     * 原始
     */
    ORIGINAL((rawName, fileType) -> rawName + "." + fileType),
    /**
     * 时间戳：高并发且业务简单的情况下时间戳会相同，应选择其他策略
     */
    TIMESTAMP((rawName, fileType) -> getTimestamp() + "." + fileType),
    /**
     * 时间戳 + 3位随机字符
     */
    TIMESTAMP_H((rawName, fileType) -> getTimestamp() + RandomUtil.randomString(3) + "." + fileType),
    /**
     * 原始与时间戳
     */
    ORIGINAL_WITH_TIMESTAMP((rawName, fileType) -> rawName + getTimestamp() + "." + fileType);

    /**
     * 策略
     */
    private final BiFunction<String, String, String> strategy;

    /**
     * 应用生成文件名
     *
     * @param rawName  原始名字
     * @param fileType 文件类型
     * @return {@link String}
     */
    public String apply(String rawName, String fileType) {
        return getStrategy().apply(rawName, fileType);
    }

    private static String getTimestamp() {
        return String.valueOf(Instant.now().toEpochMilli());
    }
}