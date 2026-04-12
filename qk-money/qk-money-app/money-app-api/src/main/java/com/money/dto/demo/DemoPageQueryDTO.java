package com.money.dto.demo;

import com.money.web.dto.PageQueryRequest;
import com.money.web.util.MoneyCommUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Map;

/**
 *  分页查询 DTO
 *
 * @author money
 * @since 2026-03-17
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

    /**
     * 可排序字段映射
     *
     * @return 排序字段映射
     */
    @Override
    public Map<String, String> sortKeyMap() {
        return MoneyCommUtil.sortFieldMap("createTime", "updateTime");
    }
}
