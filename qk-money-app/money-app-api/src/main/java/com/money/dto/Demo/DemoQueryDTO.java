package com.money.dto.Demo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.money.common.dto.QueryRequest;

/**
* <p>
* 
* </p>
*
* @author money
* @since 2023-04-30
*/
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@Schema(description = "")
public class DemoQueryDTO extends QueryRequest {

    @Schema(description="名称")
    private String name;

    @Schema(description="状态")
    private String status;

}
