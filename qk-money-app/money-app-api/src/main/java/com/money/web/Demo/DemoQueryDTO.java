package com.money.web.Demo;

import java.io.Serializable;
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
* @since 2022-04-26
*/
@Data
@EqualsAndHashCode(callSuper = true)
@Schema(description = "")
public class DemoQueryDTO extends QueryRequest implements Serializable {

    private static final long serialVersionUID = 1L;
    private String name;


}
