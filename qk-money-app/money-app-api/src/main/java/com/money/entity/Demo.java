package com.money.entity;

import com.money.mb.base.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 
 * </p>
 *
 * @author money
 * @since 2022-05-28
 */
@Getter
@Setter
@Schema(description = "")
public class Demo extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private String name;

    private Integer sort;

    @Schema(description="租户id")
    private Long tenantId;


}
