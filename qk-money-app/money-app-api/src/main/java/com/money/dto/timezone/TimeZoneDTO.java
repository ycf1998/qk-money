package com.money.dto.timezone;

import com.money.web.timezone.annotation.TZParam;
import lombok.Data;

import java.time.LocalDateTime;


/**
 * 时区DTO
 *
 * @author : money
 * @since : 1.0.0
 */
@Data
public class TimeZoneDTO {

    @TZParam
    private String dateTime;

    @TZParam
    private LocalDateTime localDateTime;

}
