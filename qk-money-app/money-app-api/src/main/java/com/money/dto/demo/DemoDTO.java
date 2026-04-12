package com.money.dto.demo;

import lombok.Data;
import lombok.experimental.Accessors;
import jakarta.validation.constraints.NotNull;
import com.money.web.dto.ValidGroup;

/**
 *  DTO
 *
 * @author money
 * @since 2026-03-17
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
