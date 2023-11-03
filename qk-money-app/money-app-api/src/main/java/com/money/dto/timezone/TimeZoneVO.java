package com.money.dto.timezone;

import com.money.common.timezone.annotation.TZParam;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * @author : money
 * @version : 1.0.0
 * @description : 时间区VO
 * @createTime : 2022-05-13 22:23:53
 */
@Data
public class TimeZoneVO {

    @TZParam
    private String dateTime;

    @TZParam
    private LocalDateTime localDateTime;
}
