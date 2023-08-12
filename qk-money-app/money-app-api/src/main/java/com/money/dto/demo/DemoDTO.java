package com.money.dto.demo;

import lombok.Data;
import lombok.experimental.Accessors;
import javax.validation.constraints.NotNull;
import com.money.common.dto.ValidGroup;

/**
* <p>
* 
* </p>
*
* @author baomidou
* @since 2023-08-12
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

}
