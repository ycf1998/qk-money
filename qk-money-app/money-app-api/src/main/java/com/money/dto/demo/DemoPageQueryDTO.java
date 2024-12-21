package com.money.dto.demo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.money.web.dto.PageQueryRequest;

/**
* <p>
* 
* </p>
*
* @author money
* @since 2024-12-21
*/
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class DemoPageQueryDTO extends PageQueryRequest {

    /**
    * 名称
    */
    private String name;

    /**
    * 状态
    */
    private String status;

}
