package com.money.dto.demo;

import com.money.web.util.MoneyCommUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.money.web.dto.PageQueryRequest;

import java.util.Map;

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

    /**
     * 可排序字段映射
     *
     * @return {@link Map }<{@link String }, {@link String }>
     */
    @Override
    public Map<String, String> sortKeyMap() {
        return MoneyCommUtil.sortFieldMap("createTime", "updateTime");
    }
}
