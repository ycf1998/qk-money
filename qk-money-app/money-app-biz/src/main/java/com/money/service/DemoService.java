package com.money.service;

import com.money.entity.Demo;
import com.baomidou.mybatisplus.extension.service.IService;
import com.money.web.vo.PageVO;
import com.money.dto.demo.DemoDTO;
import com.money.dto.demo.DemoPageQueryDTO;
import com.money.dto.demo.DemoVO;

import java.util.Collection;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author money
 * @since 2024-12-21
 */
public interface DemoService extends IService<Demo> {

    /**
    * 列表
    *
    * @param queryDTO 查询 DTO
    * @return {@link PageVO }<{@link DemoVO }>
    */
    PageVO<DemoVO> list(DemoPageQueryDTO queryDTO);

    /**
    * 新增
    *
    * @param addDTO 新增 DTO
    * @return id
    */
    Long add(DemoDTO addDTO);

    /**
    * 修改
    *
    * @param updateDTO 修改 DTO
    */
    void update(DemoDTO updateDTO);

    /**
    * 删除
    *
    * @param ids IDS
    */
    void delete(Collection<Long> ids);

}
