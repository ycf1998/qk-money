/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80026 (8.0.26)
 Source Host           : localhost:3306
 Source Schema         : qk_money

 Target Server Type    : MySQL
 Target Server Version : 80026 (8.0.26)
 File Encoding         : 65001

 Date: 01/10/2023 17:06:05
*/

CREATE DATABASE IF NOT EXISTS `qk_money` CHARACTER SET 'utf8mb4';
USE qk_money;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for demo
-- ----------------------------
DROP TABLE IF EXISTS `demo`;
CREATE TABLE `demo`  (
                         `id` bigint UNSIGNED NOT NULL,
                         `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
                         `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                         `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                         `update_time` datetime NOT NULL,
                         `tenant_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '租户id',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of demo
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
                             `id` bigint UNSIGNED NOT NULL,
                             `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典名',
                             `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '字典描述',
                             `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `create_time` datetime NOT NULL,
                             `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `update_time` datetime NOT NULL,
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, 'permissionType', '权限类型', '', '2022-03-06 12:02:55', '', '2022-03-06 12:02:58');

-- ----------------------------
-- Table structure for sys_dict_detail
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_detail`;
CREATE TABLE `sys_dict_detail`  (
                                    `id` bigint UNSIGNED NOT NULL,
                                    `dict` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典名',
                                    `label` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典标签',
                                    `value` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典值',
                                    `sort` int NOT NULL DEFAULT 999 COMMENT '排序',
                                    `hidden` tinyint(1) NOT NULL DEFAULT 0 COMMENT '隐藏',
                                    `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                    `create_time` datetime NOT NULL,
                                    `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                    `update_time` datetime NOT NULL,
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典详情表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_detail
-- ----------------------------
INSERT INTO `sys_dict_detail` VALUES (1, 'permissionType', '目录', 'DIR', 1, 0, '', '2022-03-30 22:13:11', 'money', '2023-05-24 22:58:30');
INSERT INTO `sys_dict_detail` VALUES (2, 'permissionType', '菜单', 'MENU', 2, 0, '', '2022-03-30 22:13:11', '', '2022-03-30 22:13:17');
INSERT INTO `sys_dict_detail` VALUES (3, 'permissionType', '按钮', 'BUTTON', 3, 0, '', '2022-03-30 22:13:11', 'money', '2023-09-30 12:00:32');

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
                                   `id` bigint UNSIGNED NOT NULL,
                                   `permission_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
                                   `permission_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源类型',
                                   `parent_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '父编码',
                                   `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '图标',
                                   `permission` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '权限标识',
                                   `router_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由地址',
                                   `iframe` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否外链菜单',
                                   `hidden` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否隐藏',
                                   `component_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '组件名称',
                                   `component_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '组件路径',
                                   `sub_count` int NOT NULL DEFAULT 0 COMMENT '子节点数',
                                   `sort` int NOT NULL DEFAULT 999 COMMENT '排序',
                                   `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                   `create_time` datetime NOT NULL,
                                   `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                   `update_time` datetime NOT NULL,
                                   `tenant_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '租户id',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '资源权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES (1501921151197130754, '系统管理', 'DIR', 0, 'sys-manage', '', 'system', 0, 0, '', '', 5, 1, 'money', '2022-03-10 22:01:21', 'money', '2022-03-10 23:06:45', 0);
INSERT INTO `sys_permission` VALUES (1502278787507806210, '用户管理', 'MENU', 1501921151197130754, 'sys-user', 'user:list', 'user', 0, 0, 'User', 'system/user/index', 3, 1, 'money', '2022-03-11 21:42:29', 'money', '2022-03-11 21:42:29', 0);
INSERT INTO `sys_permission` VALUES (1502863016289398785, '角色管理', 'MENU', 1501921151197130754, 'sys-role', 'role:list', 'role', 0, 0, 'Role', 'system/role/index', 2, 2, 'money', '2022-03-13 12:24:00', 'money', '2022-03-13 12:24:00', 0);
INSERT INTO `sys_permission` VALUES (1502863270971731970, '权限管理', 'MENU', 1501921151197130754, 'sys-permission', 'permission:list', 'permission', 0, 0, 'Permission', 'system/permission/index', 3, 3, 'money', '2022-03-13 12:25:00', 'money', '2022-03-13 12:25:00', 0);
INSERT INTO `sys_permission` VALUES (1503736683986800642, '新增用户', 'BUTTON', 1502278787507806210, '', 'user:add', '', 0, 0, '', '', 0, 1, 'money', '2022-03-15 22:15:38', 'money', '2022-03-15 22:15:38', 0);
INSERT INTO `sys_permission` VALUES (1503738104236822529, '修改用户', 'BUTTON', 1502278787507806210, '', 'user:edit', '', 0, 0, '', '', 0, 2, 'money', '2022-03-15 22:21:17', 'money', '2022-03-15 22:21:17', 0);
INSERT INTO `sys_permission` VALUES (1503738191579009025, '删除用户', 'BUTTON', 1502278787507806210, '', 'user:del', '', 0, 0, '', '', 0, 3, 'money', '2022-03-15 22:21:38', 'money', '2022-03-15 22:21:38', 0);
INSERT INTO `sys_permission` VALUES (1503753702563991553, '新增角色', 'BUTTON', 1502863016289398785, '', 'role:add', '', 0, 0, '', '', 0, 1, 'money', '2022-03-15 23:23:16', 'money', '2022-03-15 23:23:16', 0);
INSERT INTO `sys_permission` VALUES (1503753930130149377, '修改角色', 'BUTTON', 1502863016289398785, '', 'role:edit', '', 0, 0, '', '', 0, 2, 'money', '2022-03-15 23:24:10', 'money', '2022-03-15 23:24:10', 0);
INSERT INTO `sys_permission` VALUES (1503754013445804034, '删除角色', 'BUTTON', 1502863016289398785, '', 'role:del', '', 0, 0, '', '', 0, 3, 'money', '2022-03-15 23:24:30', 'money', '2022-03-15 23:24:30', 0);
INSERT INTO `sys_permission` VALUES (1503754297878335489, '新增权限', 'BUTTON', 1502863270971731970, '', 'permission:add', '', 0, 0, '', '', 0, 1, 'money', '2022-03-15 23:25:38', 'money', '2022-03-15 23:25:38', 0);
INSERT INTO `sys_permission` VALUES (1503754393558798337, '修改权限', 'BUTTON', 1502863270971731970, '', 'permission:edit', '', 0, 0, '', '', 0, 2, 'money', '2022-03-15 23:26:00', 'money', '2022-03-15 23:26:00', 0);
INSERT INTO `sys_permission` VALUES (1503754468678782978, '删除权限', 'BUTTON', 1502863270971731970, '', 'permission:del', '', 0, 0, '', '', 0, 3, 'money', '2022-03-15 23:26:18', 'money', '2022-03-15 23:26:18', 0);
INSERT INTO `sys_permission` VALUES (1507371326556450818, '字典管理', 'MENU', 1501921151197130754, 'sys-dict', 'dict:list', 'dict', 0, 0, 'Dict', 'system/dict/index', 3, 4, 'money', '2022-03-25 22:58:25', 'money', '2022-03-25 22:58:25', 0);
INSERT INTO `sys_permission` VALUES (1507371669973479425, '新增字典', 'BUTTON', 1507371326556450818, '', 'dict:add', '', 0, 0, '', '', 0, 1, 'money', '2022-03-25 22:59:46', 'money', '2022-03-25 22:59:46', 0);
INSERT INTO `sys_permission` VALUES (1507371725170520065, '修改字典', 'BUTTON', 1507371326556450818, '', 'dict:edit', '', 0, 0, '', '', 0, 2, 'money', '2022-03-25 23:00:00', 'money', '2022-03-25 23:00:00', 0);
INSERT INTO `sys_permission` VALUES (1507371776840151041, '删除字典', 'BUTTON', 1507371326556450818, '', 'dict:del', '', 0, 0, '', '', 0, 3, 'money', '2022-03-25 23:00:12', 'money', '2022-03-25 23:00:12', 0);
INSERT INTO `sys_permission` VALUES (1507555956060450818, '租户管理', 'MENU', 1501921151197130754, 'sys-tenant', 'tenant:list', 'tenant', 0, 0, 'Tenant', 'system/tenant/index', 3, 5, 'money', '2022-03-26 11:12:04', 'money', '2022-03-26 11:12:04', 0);
INSERT INTO `sys_permission` VALUES (1507556070254571522, '新增租户', 'BUTTON', 1507555956060450818, '', 'tenant:add', '', 0, 0, '', '', 0, 1, 'money', '2022-03-26 11:12:31', 'money', '2022-03-26 11:12:31', 0);
INSERT INTO `sys_permission` VALUES (1507556151250776065, '修改租户', 'BUTTON', 1507555956060450818, '', 'tenant:edit', '', 0, 0, '', '', 0, 2, 'money', '2022-03-26 11:12:50', 'money', '2022-03-26 11:12:50', 0);
INSERT INTO `sys_permission` VALUES (1507556213058039809, '删除租户', 'BUTTON', 1507555956060450818, '', 'tenant:del', '', 0, 0, '', '', 0, 3, 'money', '2022-03-26 11:13:05', 'money', '2022-03-26 11:13:05', 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
                             `id` bigint UNSIGNED NOT NULL,
                             `role_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色编码',
                             `role_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
                             `level` int NOT NULL COMMENT '角色级别',
                             `description` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色描述',
                             `count` bigint NOT NULL DEFAULT 0 COMMENT '角色人数',
                             `enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '可用状态：0-禁用；1-启用',
                             `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `create_time` datetime NOT NULL,
                             `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `update_time` datetime NOT NULL,
                             `tenant_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '租户id',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 'SUPER_ADMIN', '超级管理员', 0, '拥有全部权限的人', 1, 1, '', '2021-09-07 22:49:27', 'admin', '2022-03-06 11:40:47', 0);
INSERT INTO `sys_role` VALUES (1502845638751055873, 'ADMIN', '管理员', 1, '管理员', 1, 1, 'admin', '2022-03-13 11:14:56', 'admin', '2022-03-13 11:14:56', 0);
INSERT INTO `sys_role` VALUES (1502845786646409218, 'GUEST', '游客', 99, '只能查不能改', 1, 1, 'admin', '2022-03-13 11:15:32', 'admin', '2022-03-13 11:15:42', 0);

-- ----------------------------
-- Table structure for sys_role_permission_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission_relation`;
CREATE TABLE `sys_role_permission_relation`  (
                                                 `id` bigint UNSIGNED NOT NULL,
                                                 `permission_id` bigint UNSIGNED NOT NULL COMMENT '资源权限id',
                                                 `role_id` bigint UNSIGNED NOT NULL COMMENT '角色id',
                                                 `tenant_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '租户id',
                                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色资源权限关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_permission_relation
-- ----------------------------
INSERT INTO `sys_role_permission_relation` VALUES (1662099841436852226, 1503736683986800642, 1502845638751055873, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099841436852227, 1501921151197130754, 1502845638751055873, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099841436852228, 1502278787507806210, 1502845638751055873, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099841436852229, 1503754013445804034, 1502845638751055873, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099841436852230, 1507371326556450818, 1502845638751055873, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099841436852231, 1503738191579009025, 1502845638751055873, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099841436852232, 1503753930130149377, 1502845638751055873, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099841436852233, 1502863270971731970, 1502845638751055873, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099841436852234, 1503738104236822529, 1502845638751055873, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099841436852235, 1503753702563991553, 1502845638751055873, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099841436852236, 1502863016289398785, 1502845638751055873, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099841436852237, 1507555956060450818, 1502845638751055873, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099895899889665, 1501921151197130754, 1502845786646409218, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099895966998530, 1502278787507806210, 1502845786646409218, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099895966998531, 1507371326556450818, 1502845786646409218, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099895966998532, 1502863270971731970, 1502845786646409218, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099895966998533, 1502863016289398785, 1502845786646409218, 0);
INSERT INTO `sys_role_permission_relation` VALUES (1662099895966998534, 1507555956060450818, 1502845786646409218, 0);

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant`  (
                               `id` bigint UNSIGNED NOT NULL,
                               `tenant_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户code',
                               `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'https://7up.pics/images/2023/10/21/logo.png' COMMENT 'logo',
                               `ico` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'ico',
                               `domain` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '域名',
                               `tenant_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户名称',
                               `tenant_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '租户描述',
                               `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除',
                               `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               `tenant_id` bigint UNSIGNED NOT NULL DEFAULT 0,
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
INSERT INTO `sys_tenant` VALUES (0, 'M', 'https://7up.pics/images/2023/10/21/logo.png', '', 'www.money.com', '麦尼科技', '主租户', 0, '', '2023-10-01 17:05:41', '', '2022-03-26 14:06:28', 0);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
                             `id` bigint UNSIGNED NOT NULL,
                             `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
                             `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
                             `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
                             `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'https://7up.pics/images/2023/10/21/superhero.png' COMMENT '头像',
                             `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '手机号码',
                             `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '邮箱',
                             `remark` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备注',
                             `enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '可用状态：0-禁用；1-启用',
                             `init_login` tinyint(1) NOT NULL DEFAULT 1 COMMENT '初次登录：0-不是；1-是',
                             `last_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后登录时间',
                             `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                             `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             `tenant_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '租户id',
                             PRIMARY KEY (`id`) USING BTREE,
                             UNIQUE INDEX `uk_username`(`username` ASC, `tenant_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'money', '$2a$10$W6oaOSARIA3DsZy1DkdfUuqI3L7a885Ci7AYvpQK.9NGbeVhcZihi', 'money', 'https://7up.pics/images/2023/10/21/batman.png', '18120800000', 'money@qq.com', '俺是一个超级管理员！', 1, 1, '2023-10-01 12:45:28', '', '2022-03-03 23:12:57', 'money', '2023-05-25 23:54:31', 0);
INSERT INTO `sys_user` VALUES (1502254138862391297, 'admin', '$2a$10$630Mdca6BcyUJpKC2LNT7eT93.k9pmpcQoes4qm/j2o.pnb725zE6', 'admin', 'https://7up.pics/images/2023/10/21/superhero.png', '18120803972', 'admin@qq.com', '', 1, 1, '2023-05-26 22:33:39', 'money', '2022-03-11 20:04:32', 'money', '2023-05-26 21:52:38', 0);
INSERT INTO `sys_user` VALUES (1504612500111388673, 'guest', '$2a$10$Nj/4Tn.cj2SEdoIUqMz7FOczatNV/AltEu07ieTpAO.5hEGV7lZqC', 'guest', 'https://7up.pics/images/2023/10/21/superhero.png', '18120800002', 'guest@qq.com', '', 1, 1, '2023-05-26 22:23:55', 'money', '2022-03-18 08:15:49', 'money', '2023-09-30 12:01:33', 0);

-- ----------------------------
-- Table structure for sys_user_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role_relation`;
CREATE TABLE `sys_user_role_relation`  (
                                           `id` bigint UNSIGNED NOT NULL,
                                           `user_id` bigint UNSIGNED NOT NULL COMMENT '用户id',
                                           `role_id` bigint UNSIGNED NOT NULL COMMENT '角色id',
                                           `tenant_id` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '租户id',
                                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role_relation
-- ----------------------------
INSERT INTO `sys_user_role_relation` VALUES (1507382155225899009, 1, 1, 0);
INSERT INTO `sys_user_role_relation` VALUES (1662094367798829058, 1502254138862391297, 1502845638751055873, 0);
INSERT INTO `sys_user_role_relation` VALUES (1707968908820713472, 1504612500111388673, 1502845786646409218, 0);

SET FOREIGN_KEY_CHECKS = 1;