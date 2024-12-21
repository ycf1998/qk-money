package com.money.dto.timezone;

import com.money.web.timezone.annotation.TZParam;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * @author : money
 * @version : 1.0.0
 * @description : 时区dto
 * @createTime : 2022-05-13 22:23:50
 */
@Data
public class TimeZoneDTO {

    @TZParam
    private String dateTime;

    @TZParam
    private LocalDateTime localDateTime;

}
