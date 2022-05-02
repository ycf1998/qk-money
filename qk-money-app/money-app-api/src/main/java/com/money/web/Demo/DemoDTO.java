package com.money.web.Demo;

import java.io.Serializable;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
* <p>
* 
* </p>
*
* @author money
* @since 2022-04-26
*/
@Data
@Schema(description = "")
public class DemoDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;

    private String name;


}
