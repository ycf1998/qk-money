package com.money.dto.Demo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
* <p>
* 
* </p>
*
* @author money
* @since 2022-09-03
*/
@Data
@Schema(description = "")
public class DemoDTO {

    private Long id;

    @Schema(description="名称")
    private String name;


}
