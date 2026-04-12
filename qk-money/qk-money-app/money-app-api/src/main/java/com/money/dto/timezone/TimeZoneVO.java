package com.money.dto.timezone;

import com.money.web.timezone.annotation.TZParam;
import lombok.Data;

import java.time.LocalDateTime;


/**
 * 时间区域 VO
 *
 * @author : money
 * @since : 1.0.0
 */
@Data
public class TimeZoneVO {

    @TZParam
    private String dateTime;

    @TZParam
    private LocalDateTime localDateTime;
}
