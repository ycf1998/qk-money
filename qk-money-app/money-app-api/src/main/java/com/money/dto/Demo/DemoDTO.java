package com.money.dto.Demo;

import com.money.common.dto.ValidGroup;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;

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
public class DemoDTO {

    @NotNull(groups = ValidGroup.Update.class)
    private Long id;

    @Schema(description = "名称")
    private String name;

}
