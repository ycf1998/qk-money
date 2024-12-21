package com.money.dto.demo;

import lombok.Data;
import lombok.experimental.Accessors;
import javax.validation.constraints.NotNull;
import com.money.web.dto.ValidGroup;

/**
* <p>
* 
* </p>
*
* @author money
* @since 2024-12-21
*/
@Data
@Accessors(chain = true)
public class DemoDTO {

    @NotNull(groups = ValidGroup.Update.class)
    private Long id;

    /**
    * 名称
    */
    private String name;

    /**
    * 状态
    */
    private String status;

}
