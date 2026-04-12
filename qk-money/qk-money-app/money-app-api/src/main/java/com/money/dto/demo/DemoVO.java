package com.money.dto.demo;

import lombok.Data;
import lombok.experimental.Accessors;

/**
 *  VO
 *
 * @author money
 * @since 2026-03-17
 */
@Data
@Accessors(chain = true)
public class DemoVO {

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
