package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.sxt.tingyu.bean.Company;
import com.sxt.tingyu.bean.DataResult;
import com.sxt.tingyu.bean.PageDataResult;
import com.sxt.tingyu.service.ICompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;
import java.util.Objects;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Controller
@RequestMapping("/company")
public class CompanyController {

    @Autowired
    private ICompanyService iCompanyService;


    @RequestMapping("/companyManager")
    public String companyManager() {

        return "companyManager";
    }

    @RequestMapping("/companyPage")
    @ResponseBody
    public PageDataResult companyPage(Company company, Integer rows, Integer page) {

        PageDataResult pageDataResult = iCompanyService.companyPage(company, rows, page);
        return pageDataResult;

    }

    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public DataResult saveOrUpdate(Company company) {
        if (Objects.isNull(company.getCid())) {
            company.setStarttime(LocalDateTime.now());
            company.setStatus("1");

        }
        boolean flag = iCompanyService.saveOrUpdate(company);
        if (flag) {
            return DataResult.ok("操作成功");
        } else {
            return DataResult.ok("操作失败");
        }
    }

    @RequestMapping("/changeCompanyStatus")
    @ResponseBody
    public DataResult changeCompanyStatus(Integer cid, String status) {

        UpdateWrapper updateWrapper = new UpdateWrapper();
        updateWrapper.eq("cid", cid);
        if("0".equals(status)){
            updateWrapper.set("status", "1");
        }
        if("1".equals(status)){
            updateWrapper.set("status", "2");
        }
        if("2".equals(status)){
            updateWrapper.set("status", "1");
        }


        boolean flag = iCompanyService.update(updateWrapper);
        if (flag) {
           return DataResult.ok("修改成功");
        } else {
            return DataResult.err("修改失败");
        }

    }

}

