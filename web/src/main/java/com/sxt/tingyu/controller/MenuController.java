package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sxt.tingyu.bean.Admin;
import com.sxt.tingyu.bean.DataResult;
import com.sxt.tingyu.bean.Menu;
import com.sxt.tingyu.service.IMenuService;
import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Objects;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private IMenuService iMenuService;


    @RequestMapping("/menuManager")
    public String menuManager(){
        return "menuManager";
    }




    @RequestMapping("/selectMenuByUser")
    @ResponseBody
    public List<Menu> selectMenuById(HttpSession session){
        Admin admin = (Admin)session.getAttribute("admin");
        System.out.println(admin);
        Integer aid = admin.getAid();
        List<Menu> menus = iMenuService.selectMenuById(aid);
        System.out.println(menus);
        return menus;
    }
    @RequestMapping("/list")
    @ResponseBody
    public List<Menu> list(){

        List<Menu> menus = iMenuService.list();
        System.out.println(menus);
        return menus;
    }


    @RequestMapping("/saveOrUpdateMenu")
    @ResponseBody
    public DataResult saveOrUpdateMenu(Menu menu){
        System.out.println("+++++++++++++++++"+menu);
//        menu的数据当中，默写数据不能为空
        if(Objects.isNull(menu.getPid())){
            menu.setPid(0);
        }
        menu.setIsparent("1");
        menu.setStatus("1");

        boolean b = iMenuService.saveOrUpdate(menu);

        return b?DataResult.ok("操作成功"):DataResult.err("操作失败");
    }

    @RequestMapping("/delMenuById")
    @ResponseBody
    public DataResult delMenuById(Integer mid){
        QueryWrapper<Menu> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("pid", mid);
        List<Menu> list = iMenuService.list(queryWrapper);
        if(list.size()>0){
            return DataResult.err("请先删除所有子菜单");
        }

        boolean b = iMenuService.removeById(mid);

        return b?DataResult.ok("删除成功"):DataResult.err("删除失败");
    }
}

