package com.money.entity;

import com.money.mb.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author baomidou
 * @since 2023-08-12
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
     * 租户id
     */
    private Long tenantId;
}
