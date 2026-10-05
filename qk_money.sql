CREATE DATABASE IF NOT EXISTS `qk_money` CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci';
USE `qk_money`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- >>> qk-money >>>

-- demo
DROP TABLE IF EXISTS `demo`;
CREATE TABLE `demo` (
  `id`          bigint       NOT NULL                COMMENT '主键ID',
  `name`        varchar(50)  NOT NULL                COMMENT '名称',
  `create_by`   varchar(50)  NOT NULL                COMMENT '创建人',
  `create_time` datetime     NOT NULL                COMMENT '创建时间',
  `update_by`   varchar(50)  NOT NULL                COMMENT '更新人',
  `update_time` datetime     NOT NULL                COMMENT '更新时间',
  `tenant_id`   bigint       NOT NULL DEFAULT 0      COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '示例表';

-- sys_dict
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id`          bigint       NOT NULL                COMMENT '主键ID',
  `dict_name`   varchar(50)  NOT NULL                COMMENT '字典名称，不可修改',
  `dict_desc`   varchar(500) NOT NULL DEFAULT ''     COMMENT '字典描述',
  `create_by`   varchar(50)  NOT NULL                COMMENT '创建人',
  `create_time` datetime     NOT NULL                COMMENT '创建时间',
  `update_by`   varchar(50)  NOT NULL                COMMENT '更新人',
  `update_time` datetime     NOT NULL                COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_dict_name` (`dict_name`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典表';

-- sys_dict_detail
DROP TABLE IF EXISTS `sys_dict_detail`;
CREATE TABLE `sys_dict_detail` (
  `id`          bigint       NOT NULL                COMMENT '主键ID',
  `dict`        varchar(50)  NOT NULL                COMMENT '所属字典，对应 sys_dict.dict_name',
  `value`       varchar(50)  NOT NULL                COMMENT '字典值',
  `name_cn`     varchar(100) NOT NULL                COMMENT '中文名称',
  `name_en`     varchar(100) NOT NULL DEFAULT ''     COMMENT '英文名称',
  `sort`        int          NOT NULL DEFAULT 999    COMMENT '排序',
  `hidden`      tinyint(1)   NOT NULL DEFAULT 0      COMMENT '是否隐藏：0-否；1-是',
  `create_by`   varchar(50)  NOT NULL                COMMENT '创建人',
  `create_time` datetime     NOT NULL                COMMENT '创建时间',
  `update_by`   varchar(50)  NOT NULL                COMMENT '更新人',
  `update_time` datetime     NOT NULL                COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_dict_value` (`dict`, `value`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典详情表';

-- sys_permission
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id`               bigint       NOT NULL              COMMENT '主键ID',
  `permission_name`  varchar(50)  NOT NULL              COMMENT '名称',
  `permission_type`  varchar(20)  NOT NULL              COMMENT '资源类型：DIR-目录；MENU-菜单；BUTTON-按钮',
  `parent_id`        bigint       NOT NULL DEFAULT 0    COMMENT '父节点ID，0 为根节点',
  `icon`             varchar(255) NOT NULL DEFAULT ''   COMMENT '图标',
  `permission_code`  varchar(100) NOT NULL DEFAULT ''   COMMENT '权限标识，如 user:list；目录等无标识时为空串',
  `router_path`      varchar(200) NOT NULL DEFAULT ''   COMMENT '路由地址',
  `iframe`           tinyint(1)   NOT NULL DEFAULT 0    COMMENT '是否外链菜单：0-否；1-是',
  `hidden`           tinyint(1)   NOT NULL DEFAULT 0    COMMENT '是否隐藏：0-否；1-是',
  `component_name`   varchar(100) NOT NULL DEFAULT ''   COMMENT '组件名称',
  `component_path`   varchar(200) NOT NULL DEFAULT ''   COMMENT '组件路径',
  `sort`             int          NOT NULL DEFAULT 999  COMMENT '排序',
  `create_by`        varchar(50)  NOT NULL              COMMENT '创建人',
  `create_time`      datetime     NOT NULL              COMMENT '创建时间',
  `update_by`        varchar(50)  NOT NULL              COMMENT '更新人',
  `update_time`      datetime     NOT NULL              COMMENT '更新时间',
  `tenant_id`        bigint       NOT NULL DEFAULT 0    COMMENT '租户ID',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_permission_code` (`tenant_id`, `permission_code`),
  KEY `idx_tenant_parent_id` (`tenant_id`, `parent_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资源权限表';

-- sys_role
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id`          bigint       NOT NULL                COMMENT '主键ID',
  `role_code`   varchar(50)  NOT NULL                COMMENT '角色编码',
  `role_name`   varchar(50)  NOT NULL                COMMENT '角色名称',
  `level`       int          NOT NULL DEFAULT 0      COMMENT '角色级别，数值越小权限越大',
  `description` varchar(500) NOT NULL DEFAULT ''     COMMENT '角色描述',
  `enabled`     tinyint(1)   NOT NULL DEFAULT 1      COMMENT '可用状态：0-禁用；1-启用',
  `create_by`   varchar(50)  NOT NULL                COMMENT '创建人',
  `create_time` datetime     NOT NULL                COMMENT '创建时间',
  `update_by`   varchar(50)  NOT NULL                COMMENT '更新人',
  `update_time` datetime     NOT NULL                COMMENT '更新时间',
  `tenant_id`   bigint       NOT NULL DEFAULT 0      COMMENT '租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_role_code` (`tenant_id`, `role_code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色表';

-- sys_role_permission
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `id`            bigint NOT NULL             COMMENT '主键ID',
  `role_id`       bigint NOT NULL             COMMENT '角色ID',
  `permission_id` bigint NOT NULL             COMMENT '权限ID',
  `tenant_id`     bigint NOT NULL DEFAULT 0   COMMENT '租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_role_permission` (`tenant_id`, `role_id`, `permission_id`),
  KEY `idx_tenant_permission_id` (`tenant_id`, `permission_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色资源权限关联表';

-- sys_tenant
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant` (
  `id`          bigint       NOT NULL              COMMENT '主键ID',
  `tenant_code` varchar(50)  NOT NULL              COMMENT '租户编码',
  `logo`        varchar(255) NOT NULL DEFAULT ''   COMMENT 'logo 地址',
  `ico`         varchar(255) NOT NULL DEFAULT ''   COMMENT 'ico 地址',
  `domain`      varchar(100) NOT NULL DEFAULT ''   COMMENT '域名',
  `tenant_name` varchar(50)  NOT NULL              COMMENT '租户名称',
  `tenant_desc` varchar(500) NOT NULL DEFAULT ''   COMMENT '租户描述',
  `deleted`     tinyint(1)   NOT NULL DEFAULT 0    COMMENT '逻辑删除：0-未删除；1-已删除',
  `create_by`   varchar(50)  NOT NULL              COMMENT '创建人',
  `create_time` datetime     NOT NULL              COMMENT '创建时间',
  `update_by`   varchar(50)  NOT NULL              COMMENT '更新人',
  `update_time` datetime     NOT NULL              COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_code` (`tenant_code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户表';

-- sys_user
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id`              bigint       NOT NULL                COMMENT '主键ID',
  `username`        varchar(50)  NOT NULL                COMMENT '用户名，不可修改',
  `password`        varchar(100) NOT NULL                COMMENT '密码，BCrypt 加密',
  `nickname`        varchar(50)  NOT NULL DEFAULT ''     COMMENT '昵称',
  `avatar`          varchar(255) NOT NULL DEFAULT ''     COMMENT '头像地址',
  `phone`           varchar(20)  NOT NULL DEFAULT ''     COMMENT '手机号码',
  `email`           varchar(100) NOT NULL DEFAULT ''     COMMENT '邮箱',
  `remark`          varchar(500) NOT NULL DEFAULT ''     COMMENT '备注',
  `enabled`         tinyint(1)   NOT NULL DEFAULT 1      COMMENT '可用状态：0-禁用；1-启用',
  `init_login`      tinyint(1)   NOT NULL DEFAULT 1      COMMENT '是否初次登录：0-否；1-是',
  `last_login_time` datetime     NULL                    COMMENT '最后登录时间，从未登录为 NULL',
  `create_by`       varchar(50)  NOT NULL                COMMENT '创建人',
  `create_time`     datetime     NOT NULL                COMMENT '创建时间',
  `update_by`       varchar(50)  NOT NULL                COMMENT '更新人',
  `update_time`     datetime     NOT NULL                COMMENT '更新时间',
  `tenant_id`       bigint       NOT NULL DEFAULT 0      COMMENT '租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_username` (`tenant_id`, `username`),
  KEY `idx_tenant_last_login_time` (`tenant_id`, `last_login_time`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表';

-- sys_user_role
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id`        bigint NOT NULL             COMMENT '主键ID',
  `user_id`   bigint NOT NULL             COMMENT '用户ID',
  `role_id`   bigint NOT NULL             COMMENT '角色ID',
  `tenant_id` bigint NOT NULL DEFAULT 0   COMMENT '租户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_role` (`tenant_id`, `user_id`, `role_id`),
  KEY `idx_tenant_role_id` (`tenant_id`, `role_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户角色关联表';

-- sys_dict
INSERT INTO `sys_dict` (`id`, `dict_name`, `dict_desc`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
(1, 'permissionType', '权限类型', '', '2022-03-06 12:02:55', '', '2022-03-06 12:02:58');

-- sys_dict_detail
INSERT INTO `sys_dict_detail` (`id`, `dict`, `value`, `name_cn`, `name_en`, `sort`, `hidden`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
(1, 'permissionType', 'DIR',    '目录', 'Directory', 1, 0, '', '2022-03-30 22:13:11', 'money', '2024-05-18 17:34:10'),
(2, 'permissionType', 'MENU',   '菜单', 'Menu',      2, 0, '', '2022-03-30 22:13:11', 'money', '2024-05-18 17:34:19'),
(3, 'permissionType', 'BUTTON', '按钮', 'Button',    3, 0, '', '2022-03-30 22:13:11', 'money', '2024-05-18 17:34:27');

-- sys_permission
INSERT INTO `sys_permission` (`id`, `permission_name`, `permission_type`, `parent_id`, `icon`, `permission_code`, `router_path`, `iframe`, `hidden`, `component_name`, `component_path`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`) VALUES
(1501921151197130754, '系统管理', 'DIR',    0,                   'sys-manage', '',            'system',                       0, 0, '',           '',                        1, 'money', '2022-03-10 22:01:21', 'money', '2022-03-10 23:06:45', 0),
(1502278787507806210, '用户管理', 'MENU',   1501921151197130754, 'sys-user',   'user:list',   'user',                         0, 0, 'User',       'system/user/index',       1, 'money', '2022-03-11 21:42:29', 'money', '2022-03-11 21:42:29', 0),
(1502863016289398785, '角色管理', 'MENU',   1501921151197130754, 'sys-role',   'role:list',   'role',                         0, 0, 'Role',       'system/role/index',       2, 'money', '2022-03-13 12:24:00', 'money', '2022-03-13 12:24:00', 0),
(1502863270971731970, '权限管理', 'MENU',   1501921151197130754, 'sys-permission', 'permission:list', 'permission',             0, 0, 'Permission', 'system/permission/index', 3, 'money', '2022-03-13 12:25:00', 'money', '2022-03-13 12:25:00', 0),
(1503736683986800642, '新增用户', 'BUTTON', 1502278787507806210, '',           'user:add',    '',                             0, 0, '',           '',                        1, 'money', '2022-03-15 22:15:38', 'money', '2022-03-15 22:15:38', 0),
(1503738104236822529, '修改用户', 'BUTTON', 1502278787507806210, '',           'user:edit',   '',                             0, 0, '',           '',                        2, 'money', '2022-03-15 22:21:17', 'money', '2022-03-15 22:21:17', 0),
(1503738191579009025, '删除用户', 'BUTTON', 1502278787507806210, '',           'user:del',    '',                             0, 0, '',           '',                        3, 'money', '2022-03-15 22:21:38', 'money', '2022-03-15 22:21:38', 0),
(1503753702563991553, '新增角色', 'BUTTON', 1502863016289398785, '',           'role:add',    '',                             0, 0, '',           '',                        1, 'money', '2022-03-15 23:23:16', 'money', '2022-03-15 23:23:16', 0),
(1503753930130149377, '修改角色', 'BUTTON', 1502863016289398785, '',           'role:edit',   '',                             0, 0, '',           '',                        2, 'money', '2022-03-15 23:24:10', 'money', '2022-03-15 23:24:10', 0),
(1503754013445804034, '删除角色', 'BUTTON', 1502863016289398785, '',           'role:del',    '',                             0, 0, '',           '',                        3, 'money', '2022-03-15 23:24:30', 'money', '2022-03-15 23:24:30', 0),
(1503754297878335489, '新增权限', 'BUTTON', 1502863270971731970, '',           'permission:add',  '',                         0, 0, '',           '',                        1, 'money', '2022-03-15 23:25:38', 'money', '2022-03-15 23:25:38', 0),
(1503754393558798337, '修改权限', 'BUTTON', 1502863270971731970, '',           'permission:edit', '',                         0, 0, '',           '',                        2, 'money', '2022-03-15 23:26:00', 'money', '2022-03-15 23:26:00', 0),
(1503754468678782978, '删除权限', 'BUTTON', 1502863270971731970, '',           'permission:del',  '',                         0, 0, '',           '',                        3, 'money', '2022-03-15 23:26:18', 'money', '2022-03-15 23:26:18', 0),
(1507371326556450818, '字典管理', 'MENU',   1501921151197130754, 'sys-dict',   'dict:list',   'dict',                         0, 0, 'Dict',       'system/dict/index',       4, 'money', '2022-03-25 22:58:25', 'money', '2022-03-25 22:58:25', 0),
(1507371669973479425, '新增字典', 'BUTTON', 1507371326556450818, '',           'dict:add',    '',                             0, 0, '',           '',                        1, 'money', '2022-03-25 22:59:46', 'money', '2022-03-25 22:59:46', 0),
(1507371725170520065, '修改字典', 'BUTTON', 1507371326556450818, '',           'dict:edit',   '',                             0, 0, '',           '',                        2, 'money', '2022-03-25 23:00:00', 'money', '2022-03-25 23:00:00', 0),
(1507371776840151041, '删除字典', 'BUTTON', 1507371326556450818, '',           'dict:del',    '',                             0, 0, '',           '',                        3, 'money', '2022-03-25 23:00:12', 'money', '2022-03-25 23:00:12', 0),
(1507555956060450818, '租户管理', 'MENU',   1501921151197130754, 'sys-tenant', 'tenant:list', 'tenant',                       0, 0, 'Tenant',     'system/tenant/index',     5, 'money', '2022-03-26 11:12:04', 'money', '2022-03-26 11:12:04', 0),
(1507556070254571522, '新增租户', 'BUTTON', 1507555956060450818, '',           'tenant:add',  '',                             0, 0, '',           '',                        1, 'money', '2022-03-26 11:12:31', 'money', '2022-03-26 11:12:31', 0),
(1507556151250776065, '修改租户', 'BUTTON', 1507555956060450818, '',           'tenant:edit', '',                             0, 0, '',           '',                        2, 'money', '2022-03-26 11:12:50', 'money', '2022-03-26 11:12:50', 0),
(1507556213058039809, '删除租户', 'BUTTON', 1507555956060450818, '',           'tenant:del',  '',                             0, 0, '',           '',                        3, 'money', '2022-03-26 11:13:05', 'money', '2022-03-26 11:13:05', 0);

-- sys_role
INSERT INTO `sys_role` (`id`, `role_code`, `role_name`, `level`, `description`, `enabled`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`) VALUES
(1,                  'SUPER_ADMIN', '超级管理员', 0,  '拥有全部权限的人', 1, '',      '2021-09-07 22:49:27', 'admin', '2022-03-06 11:40:47', 0),
(1502845638751055873, 'ADMIN',       '管理员',     1,  '管理员',           1, 'admin', '2022-03-13 11:14:56', 'admin', '2022-03-13 11:14:56', 0),
(1502845786646409218, 'GUEST',       '游客',       99, '只能查不能改',     1, 'admin', '2022-03-13 11:15:32', 'admin', '2022-03-13 11:15:42', 0);

-- sys_role_permission
INSERT INTO `sys_role_permission` (`id`, `role_id`, `permission_id`, `tenant_id`) VALUES
(1662099841436852226, 1502845638751055873, 1503736683986800642, 0),
(1662099841436852227, 1502845638751055873, 1501921151197130754, 0),
(1662099841436852228, 1502845638751055873, 1502278787507806210, 0),
(1662099841436852229, 1502845638751055873, 1503754013445804034, 0),
(1662099841436852230, 1502845638751055873, 1507371326556450818, 0),
(1662099841436852231, 1502845638751055873, 1503738191579009025, 0),
(1662099841436852232, 1502845638751055873, 1503753930130149377, 0),
(1662099841436852233, 1502845638751055873, 1502863270971731970, 0),
(1662099841436852234, 1502845638751055873, 1503738104236822529, 0),
(1662099841436852235, 1502845638751055873, 1503753702563991553, 0),
(1662099841436852236, 1502845638751055873, 1502863016289398785, 0),
(1662099841436852237, 1502845638751055873, 1507555956060450818, 0),
(1662099895899889665, 1502845786646409218, 1501921151197130754, 0),
(1662099895966998530, 1502845786646409218, 1502278787507806210, 0),
(1662099895966998531, 1502845786646409218, 1507371326556450818, 0),
(1662099895966998532, 1502845786646409218, 1502863270971731970, 0),
(1662099895966998533, 1502845786646409218, 1502863016289398785, 0),
(1662099895966998534, 1502845786646409218, 1507555956060450818, 0);

-- sys_tenant
INSERT INTO `sys_tenant` (`id`, `tenant_code`, `logo`, `ico`, `domain`, `tenant_name`, `tenant_desc`, `deleted`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
(0, 'M', 'https://7up.pics/images/2023/10/21/logo.png', '', 'www.money.com', '麦尼科技', '主租户', 0, '', '2022-03-26 14:06:28', '', '2023-10-01 17:05:41');

-- sys_user
INSERT INTO `sys_user` (`id`, `username`, `password`, `nickname`, `avatar`, `phone`, `email`, `remark`, `enabled`, `init_login`, `last_login_time`, `create_by`, `create_time`, `update_by`, `update_time`, `tenant_id`) VALUES
(1,                  'money', '$2a$10$W6oaOSARIA3DsZy1DkdfUuqI3L7a885Ci7AYvpQK.9NGbeVhcZihi', 'money', 'https://7up.pics/images/2023/10/21/batman.png',     '18120800000', 'money@qq.com', '俺是一个超级管理员！', 1, 1, '2023-10-01 12:45:28', '',      '2022-03-03 23:12:57', 'money', '2023-05-25 23:54:31', 0),
(1502254138862391297, 'admin', '$2a$10$630Mdca6BcyUJpKC2LNT7eT93.k9pmpcQoes4qm/j2o.pnb725zE6', 'admin', 'https://7up.pics/images/2023/10/21/superhero.png', '18120803972', 'admin@qq.com', '',                     1, 1, '2023-05-26 22:33:39', 'money', '2022-03-11 20:04:32', 'money', '2023-05-26 21:52:38', 0),
(1504612500111388673, 'guest', '$2a$10$Nj/4Tn.cj2SEdoIUqMz7FOczatNV/AltEu07ieTpAO.5hEGV7lZqC', 'guest', 'https://7up.pics/images/2023/10/21/superhero.png', '18120800002', 'guest@qq.com', '',                     1, 1, '2023-05-26 22:23:55', 'money', '2022-03-18 08:15:49', 'money', '2023-09-30 12:01:33', 0);

-- sys_user_role
INSERT INTO `sys_user_role` (`id`, `user_id`, `role_id`, `tenant_id`) VALUES
(1507382155225899009, 1,                    1,                    0),
(1662094367798829058, 1502254138862391297,  1502845638751055873,  0),
(1707968908820713472, 1504612500111388673,  1502845786646409218,  0);

-- <<< qk-money <<<

SET FOREIGN_KEY_CHECKS = 1;
