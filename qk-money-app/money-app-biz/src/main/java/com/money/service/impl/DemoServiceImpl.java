package com.money.service.impl;

import com.money.entity.Demo;
import com.money.mapper.DemoMapper;
import com.money.service.DemoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import com.money.util.PageUtil;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.money.common.vo.PageVO;
import com.money.dto.Demo.DemoDTO;
import com.money.dto.Demo.DemoQueryDTO;
import com.money.dto.Demo.DemoVO;

import java.util.Collection;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author money
 * @since 2023-06-15
 */
@Service
@RequiredArgsConstructor
public class DemoServiceImpl extends ServiceImpl<DemoMapper, Demo> implements DemoService {

    @Override
    public PageVO<DemoVO> list(DemoQueryDTO queryDTO) {
        Page<Demo> page = this.lambdaQuery()
                .last(StrUtil.isNotBlank(queryDTO.getOrderBy()), queryDTO.getOrderBySql())
                .page(PageUtil.toPage(queryDTO));
        return PageUtil.toPageVO(page, DemoVO::new);
    }

    @Override
    public void add(DemoDTO addDTO) {
        Demo demo = new Demo();
        BeanUtil.copyProperties(addDTO, demo);
        this.save(demo);
    }

    @Override
    public void update(DemoDTO updateDTO) {
        Demo demo = new Demo();
        BeanUtil.copyProperties(updateDTO, demo);
        this.updateById(demo);
    }

    @Override
    public void delete(Collection<Long> ids) {
        this.removeByIds(ids);
    }

}
