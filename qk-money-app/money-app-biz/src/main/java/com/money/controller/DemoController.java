package com.money.controller;

import com.money.web.exception.BaseException;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.security.access.prepost.PreAuthorize;
import com.money.web.dto.ValidGroup;
import com.money.web.vo.PageVO;
import com.money.service.DemoService;
import com.money.dto.demo.DemoDTO;
import com.money.dto.demo.DemoPageQueryDTO;
import com.money.dto.demo.DemoVO;

import java.util.Set;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author money
 * @since 2024-12-21
 */
@RestController
@RequestMapping("/demo")
@RequiredArgsConstructor
public class DemoController {

    private final DemoService demoService;

    @GetMapping
    @PreAuthorize("@rbac.hasPermission('demo:list')")
    public PageVO<DemoVO> list(@Validated DemoPageQueryDTO queryDTO) {
        if (true) {
            throw new BaseException("测试");
        }
        return demoService.list(queryDTO);
    }

    @PostMapping
    @PreAuthorize("@rbac.hasPermission('demo:add')")
    public Long add(@Validated(ValidGroup.Save.class) @RequestBody DemoDTO addDTO) {
        return demoService.add(addDTO);
    }

    @PutMapping
    @PreAuthorize("@rbac.hasPermission('demo:edit')")
    public void update(@Validated(ValidGroup.Update.class) @RequestBody DemoDTO updateDTO) {
        demoService.update(updateDTO);
    }

    @DeleteMapping
    @PreAuthorize("@rbac.hasPermission('demo:del')")
    public void delete(@RequestBody Set<Long> ids) {
        demoService.delete(ids);
    }

}