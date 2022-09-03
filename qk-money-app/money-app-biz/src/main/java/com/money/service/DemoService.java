package com.money.service;

import com.money.entity.Demo;
import com.baomidou.mybatisplus.extension.service.IService;
import com.money.common.vo.PageVO;
import com.money.dto.Demo.DemoDTO;
import com.money.dto.Demo.DemoQueryDTO;
import com.money.dto.Demo.DemoVO;

import java.util.Set;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author money
 * @since 2022-09-03
 */
public interface DemoService extends IService<Demo> {

    PageVO<DemoVO> list(DemoQueryDTO queryDTO);

    void add(DemoDTO addDTO);

    void update(DemoDTO updateDTO);

    void delete(Set<Long> ids);
}
