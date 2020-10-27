package com.sxt.tingyu.service;

import com.sxt.tingyu.bean.HostPower;
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
public interface IHostPowerService extends IService<HostPower> {

    boolean hostPowerSet(Integer[] hids, HostPower hostPower);
}
