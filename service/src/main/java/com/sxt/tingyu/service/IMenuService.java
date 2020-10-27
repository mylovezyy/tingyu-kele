package com.sxt.tingyu.service;

import com.sxt.tingyu.bean.Menu;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
public interface IMenuService extends IService<Menu> {
    public List<Menu> selectMenuById(Integer aid);

}
