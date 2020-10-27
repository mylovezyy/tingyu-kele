package com.sxt.tingyu.service;

import com.sxt.tingyu.bean.Host;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sxt.tingyu.bean.PageDataResult;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
public interface IHostService extends IService<Host> {


    PageDataResult selectHostPageData(Host host, Integer page, Integer rows);
}
