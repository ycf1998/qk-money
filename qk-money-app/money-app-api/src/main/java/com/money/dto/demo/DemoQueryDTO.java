package com.money.dto.demo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.money.common.dto.QueryRequest;

/**
* <p>
* 
* </p>
*
* @author baomidou
* @since 2023-08-12
*/
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class DemoQueryDTO extends QueryRequest {

    /**
    * 名称
    */
    private String name;

}
