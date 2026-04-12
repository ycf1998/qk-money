package com.money.entity;

import com.money.mb.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 *  实体类
 *
 * @author money
 * @since 2026-03-17
 */
@Getter
@Setter
@Accessors(chain = true)
public class Demo extends BaseEntity {

    /**
     * 名称
     */
    private String name;

    /**
     * 状态
     */
    private String status;

    /**
     * 租户id
     */
    private Long tenantId;
}
