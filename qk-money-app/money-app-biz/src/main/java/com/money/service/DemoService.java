package com.money.service;

import com.money.entity.Demo;
import com.baomidou.mybatisplus.extension.service.IService;
import com.money.common.vo.PageVO;
import com.money.dto.demo.DemoDTO;
import com.money.dto.demo.DemoQueryDTO;
import com.money.dto.demo.DemoVO;

import java.util.Collection;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author baomidou
 * @since 2023-08-12
 */
public interface DemoService extends IService<Demo> {

    PageVO<DemoVO> list(DemoQueryDTO queryDTO);

    void add(DemoDTO addDTO);

    void update(DemoDTO updateDTO);

    void delete(Collection<Long> ids);
}
