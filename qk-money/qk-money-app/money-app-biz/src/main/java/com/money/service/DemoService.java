package com.money.service;

import com.money.entity.Demo;
import com.baomidou.mybatisplus.extension.service.IService;
import com.money.web.vo.PageVO;
import com.money.dto.demo.DemoDTO;
import com.money.dto.demo.DemoPageQueryDTO;
import com.money.dto.demo.DemoVO;

import java.util.Collection;

/**
 *  服务接口
 *
 * @author money
 * @since 2026-03-17
 */
public interface DemoService extends IService<Demo> {

    /**
     * 分页查询
     *
     * @param queryDTO 查询 DTO
     * @return 分页结果
     */
    PageVO<DemoVO> list(DemoPageQueryDTO queryDTO);

    /**
     * 添加
     *
     * @param addDTO 添加 DTO
     * @return 主键 ID
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
     * @param ids ID 集合
     */
    void delete(Collection<Long> ids);

}
