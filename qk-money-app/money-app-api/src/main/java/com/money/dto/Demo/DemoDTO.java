package com.money.dto.Demo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;
import javax.validation.constraints.NotNull;
import com.money.common.dto.ValidGroup;

/**
* <p>
* 
* </p>
*
* @author money
* @since 2023-04-30
*/
@Data
@Accessors(chain = true)
@Schema(description = "")
public class DemoDTO {

    @NotNull(groups = ValidGroup.Update.class)
    private Long id;

    @Schema(description="名称")
    private String name;

    @Schema(description="状态")
    private String status;

}
