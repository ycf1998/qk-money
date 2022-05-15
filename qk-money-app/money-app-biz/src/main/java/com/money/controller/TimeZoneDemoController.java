package com.money.controller;
import com.money.common.timezone.annotation.TZParam;
import com.money.common.timezone.annotation.TZProcess;
import com.money.common.timezone.annotation.TZRep;
import com.money.web.timezone.TimeZoneDTO;
import com.money.web.timezone.TimeZoneVO;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author : money
 * @version : 1.0.0
 * @description : 时区演示控制器
 * @createTime : 2022-05-13 22:28:16
 */
@TZProcess
@RestController
@RequestMapping("/test/timeZone")
public class TimeZoneDemoController {

    @TZRep
    @PostMapping
    public TimeZoneVO test1(@TZParam TimeZoneDTO dto) {
        // 例子请求 curl "http://localhost:9000/qk-money/test/timeZone" -H "Content-Type: application/x-www-form-urlencoded" -H "X-qk-timezone: GMT+09:00" --data-raw "dateTime=2022-05-13 13:15:00&localDateTime=2022-05-13 13:15:00"

        // 入参东九区被转为了东八区，少了一小时
        System.out.println(dto);
        TimeZoneVO vo = new TimeZoneVO();
        vo.setDateTime(dto.getDateTime());
        vo.setLocalDateTime(dto.getLocalDateTime());
        // 出参又重新转回东九区
        return vo;
    }
}
