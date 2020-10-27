package com.sxt.tingyu.service;

import com.sxt.tingyu.bean.Role;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
public interface IRoleService extends IService<Role> {

    boolean saveOrUpdateRole(Role role, Integer[] mids);

    boolean delRole(Integer rid);
}
