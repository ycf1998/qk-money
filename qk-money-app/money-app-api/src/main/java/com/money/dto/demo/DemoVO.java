package com.money.dto.demo;

import lombok.Data;
import lombok.experimental.Accessors;

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
public class DemoVO {

    private Long id;

    /**
    * 名称
    */
    private String name;

}
