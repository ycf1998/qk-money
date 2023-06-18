package com.money.dto.Demo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
    import lombok.experimental.Accessors;

/**
* <p>
* 
* </p>
*
* @author money
* @since 2023-06-18
*/
@Data
@Accessors(chain = true)
@Schema(description = "")
public class DemoVO {

    private Long id;

    @Schema(description = "名称")
    private String name;

}
