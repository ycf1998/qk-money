package com.money.security.component;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * RBAC 授权服务（SecurityExpressionRoot）
 *
 * @author : money
 * @since : 1.0.0
 */
@Slf4j
@Component("rbac")
public class RbacAuthorizationService {

    /**
     * 权限检测
     *
     * @param permissions 许可
     * @return boolean
     */
    public boolean hasPermission(String... permissions) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        SecurityUserDetail userDetail = (SecurityUserDetail) authentication.getPrincipal();
        // 获取当前用户的所有权限
        Set<String> userPermissions = userDetail.getAuthorities().stream().map(GrantedAuthority::getAuthority).collect(Collectors.toSet());
        // todo 超级管理员放行所有权限
        if (userPermissions.contains("SUPER_ADMIN")) {
            return true;
        }
        // 判断当前用户的所有权限是否包含接口上定义的权限
        return Arrays.stream(permissions).anyMatch(userPermissions::contains);
    }

}

