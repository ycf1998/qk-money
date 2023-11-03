package com.money.controller;

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
import com.money.common.dto.ValidGroup;
import com.money.common.vo.PageVO;
import com.money.service.DemoService;
import com.money.dto.demo.DemoDTO;
import com.money.dto.demo.DemoQueryDTO;
import com.money.dto.demo.DemoVO;

import java.util.Set;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author baomidou
 * @since 2023-08-12
 */
@RestController
@RequestMapping("/demo")
@RequiredArgsConstructor
public class DemoController {

    private final DemoService demoService;

    @GetMapping
    @PreAuthorize("@rbac.hasPermission('demo:list')")
    public PageVO<DemoVO> list(@Validated DemoQueryDTO queryDTO) {
        return demoService.list(queryDTO);
    }

    @PostMapping
    @PreAuthorize("@rbac.hasPermission('demo:add')")
    public void add(@Validated(ValidGroup.Save.class) @RequestBody DemoDTO addDTO) {
        demoService.add(addDTO);
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