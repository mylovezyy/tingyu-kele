package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sxt.tingyu.bean.Admin;
import com.sxt.tingyu.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.HttpSessionRequiredException;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
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
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private IAdminService iAdminService;


    @RequestMapping("/login")
    public String login(String aname, String apwd, Model model, HttpSession session) {


        QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("aname",aname);
        queryWrapper.eq("apwd",apwd);

        Admin admin = iAdminService.getOne(queryWrapper);
        System.out.println("admin :"+admin);
        if(admin == null){
            model.addAttribute("errorMsg","账号密码错误！请重新登录");
            return "forward:/login.jsp";
        }
        //共享登录用户对象
        session.setAttribute("admin",admin);

        return "redirect:/index.do";
    }


    @RequestMapping("/adminManager")

    public String adminManager() {
        return "adminManager";
    }


    @RequestMapping("/selectAllAdmin")
    @ResponseBody
    public List<Admin> selectAllAdmin() {
        List<Admin> admins = iAdminService.selectAllAdmin();
        return admins;
    }

}