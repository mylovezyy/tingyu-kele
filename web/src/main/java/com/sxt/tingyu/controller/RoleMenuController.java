package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sxt.tingyu.bean.RoleMenu;
import com.sxt.tingyu.service.IRoleMenuService;
import jdk.nashorn.internal.ir.CallNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
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
@RequestMapping("/roleMenu")
public class RoleMenuController {

    @Autowired
    private IRoleMenuService iRoleMenuService;


    @RequestMapping("/selectRoleMenuByRid")
    @ResponseBody
    public List<Integer> selectMenuIdByRid(Integer rid){
        QueryWrapper<RoleMenu> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("rid", rid);

        List<RoleMenu> list = iRoleMenuService.list(queryWrapper);
        List<Integer> mids=new ArrayList<>();
        for (RoleMenu roleMenu : list) {
            mids.add(roleMenu.getMid());
        }
        return mids;

     }

}

