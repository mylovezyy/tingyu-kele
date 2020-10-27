package com.sxt.tingyu.service.impl;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sxt.tingyu.bean.HostPower;
import com.sxt.tingyu.bean.PageDataResult;
import com.sxt.tingyu.mapper.HostPowerMapper;
import com.sxt.tingyu.service.IHostPowerService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Service
public class HostPowerServiceImpl extends ServiceImpl<HostPowerMapper, HostPower> implements IHostPowerService {

    @Override
    public boolean hostPowerSet(Integer[] hids, HostPower hostPower) {

        for (Integer hid : hids) {
            hostPower.setHostid(hid);
            int insert = this.baseMapper.insert(hostPower);
            if(insert!=1){
                return false;
            }
        }
        return true;
    }
}
