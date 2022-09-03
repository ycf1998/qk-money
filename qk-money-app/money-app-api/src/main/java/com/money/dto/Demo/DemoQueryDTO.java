package com.money.dto.Demo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import com.money.common.dto.QueryRequest;

/**
* <p>
* 
* </p>
*
* @author money
* @since 2022-09-03
*/
@Data
@EqualsAndHashCode(callSuper = true)
@Schema(description = "")
public class DemoQueryDTO extends QueryRequest {
    @Schema(description="名称")
    private String name;


}
