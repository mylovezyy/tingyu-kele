package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sxt.tingyu.bean.DataResult;
import com.sxt.tingyu.bean.MarriedPerson;
import com.sxt.tingyu.bean.PageDataResult;
import com.sxt.tingyu.service.IMarriedPersonService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Controller
@RequestMapping("/married")
public class MarriedPersonController {

    @Autowired
    private IMarriedPersonService iMarriedPersonService;

    @RequestMapping("/marriedManager")
    public String marriedManager(){
        return "marriedManager";
    }



    @RequestMapping("/marriedManagerData")
    @ResponseBody
    public PageDataResult marriedManagerData(MarriedPerson marriedPerson,Integer page,Integer rows) {

        Page<MarriedPerson> marriedPersonPage=new Page<>(page,rows);

        QueryWrapper<MarriedPerson> queryWrapper=new QueryWrapper<>();

        if(StringUtils.isNotBlank(marriedPerson.getPname())){
            queryWrapper.like("pname", marriedPerson.getPname());
        }

        if(StringUtils.isNotBlank(marriedPerson.getPhone())){
            queryWrapper.eq("phone", marriedPerson.getPhone());
        }

        Page<MarriedPerson> pages = iMarriedPersonService.page(marriedPersonPage, queryWrapper);

        //数据封装
        PageDataResult pageDataResult=new PageDataResult();
        pageDataResult.setRows(pages.getRecords());
        pageDataResult.setTotal(pages.getTotal());

        return pageDataResult;



    }


    @RequestMapping("/insert")
    @ResponseBody
    public DataResult insert(MarriedPerson marriedPerson){



        marriedPerson.setRegdate(LocalDateTime.now());
        marriedPerson.setStatus("1");
        System.out.println("marriedPerson = " + marriedPerson);

        boolean flag = iMarriedPersonService.save(marriedPerson);
        if(flag){
            return DataResult.ok("注册成功");
        }
        return DataResult.err("注册失败");
    }

}

