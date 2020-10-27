package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.sxt.tingyu.bean.DataResult;
import com.sxt.tingyu.bean.Host;
import com.sxt.tingyu.bean.PageDataResult;
import com.sxt.tingyu.service.IHostService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.security.timestamp.TSRequest;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Controller
@RequestMapping("/host")
public class HostController {

    @Autowired
    private IHostService iHostService;


    @RequestMapping("/hostManager")
    public String HostManager(){
            return "hostmanager";
    }


    @RequestMapping("/selectPage")
    @ResponseBody
    public PageDataResult selectHostPageData(Host host, @RequestParam(defaultValue = "1") Integer page,@RequestParam(defaultValue = "10") Integer rows){

        System.out.println("page = " + page);
        PageDataResult pageDataResult=iHostService.selectHostPageData(host,page,rows);

        System.out.println(pageDataResult);
        return pageDataResult;
    }

    @RequestMapping("/changeStrong")
    @ResponseBody
    public  DataResult changeStrong(String strong, Integer hid){


        UpdateWrapper updatewrapper=new UpdateWrapper();
        updatewrapper.eq("hid", hid);
        updatewrapper.set("strong", strong);
        boolean flag = iHostService.update(updatewrapper);

        if(flag){
            return DataResult.ok("修改成功");
        }else {
            return DataResult.err("修改失败");
        }

    }

    @RequestMapping("/insertHost")
    @ResponseBody
    public  DataResult insertHost(Host host){
        System.out.println("host = " + host);

        host.setStarttime(LocalDateTime.now());
        host.setStatus("1");
        host.setStrong("0");


        boolean flag = iHostService.save(host);
        System.out.println(flag);
        if(flag){
            return DataResult.ok("添加成功");
        }else {
            return DataResult.err("添加失败");
        }
    }
    @RequestMapping("/chanageHostStatus")
    @ResponseBody
    public  DataResult chanageHostStatus(Integer hid,Integer status){


        UpdateWrapper updateWrapper=new UpdateWrapper();
        updateWrapper.eq("hid", hid);
        if(status==0){
            updateWrapper.set("status", 1);
        }else if(status==1){
            updateWrapper.set("status", 0);
        }

        boolean flag = iHostService.update(updateWrapper);
        System.out.println(flag);
        if(flag){
            return DataResult.ok("修改成功");
        }else {
            return DataResult.err("修改失败");
        }
    }

}

