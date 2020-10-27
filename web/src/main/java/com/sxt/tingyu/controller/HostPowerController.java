package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sxt.tingyu.bean.DataResult;
import com.sxt.tingyu.bean.Host;
import com.sxt.tingyu.bean.HostPower;
import com.sxt.tingyu.bean.PageDataResult;
import com.sxt.tingyu.service.IHostPowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Controller
@RequestMapping("/hostPower")
public class HostPowerController {

    @Autowired
    private IHostPowerService iHostPowerService;

    @RequestMapping("/hostPowerSet")
    @ResponseBody
    public DataResult hostPowerSet(Integer[] hostids, HostPower hostPower) {

        System.out.println(Arrays.toString(hostids));
        System.out.println(hostPower);


        boolean flag= iHostPowerService.hostPowerSet(hostids, hostPower);

        if(flag){
            return DataResult.ok("权限设置成功");
        }else{
            return DataResult.err("权限设置失败");
        }

    }
}

