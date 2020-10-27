package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sxt.tingyu.bean.AdminRole;
import com.sxt.tingyu.bean.DataResult;
import com.sxt.tingyu.bean.PageDataResult;
import com.sxt.tingyu.bean.Role;
import com.sxt.tingyu.service.IAdminRoleService;
import com.sxt.tingyu.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.awt.dnd.DropTarget;
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
@RequestMapping("/role")
public class RoleController {
    @Autowired
    private IRoleService iRoleService;

    @Autowired
    private IAdminRoleService iAdminRoleService;

    @RequestMapping("/roleManager")
    public String roleManager() {
        return "roleManager";
    }


    @RequestMapping("/list")
    @ResponseBody
    public PageDataResult selectRoleList(Integer rows, Integer page) {

        Page<Role> pages = new Page<>(page, rows);

        Page<Role> pageNums = iRoleService.page(pages);

        PageDataResult pageDataResult = new PageDataResult();

        pageDataResult.setTotal(pageNums.getTotal());
        pageDataResult.setRows(pageNums.getRecords());

        System.out.println("pageDataResult = " + pageDataResult);
        return pageDataResult;

    }

    @RequestMapping("/saveOrUpdateRole")
    @ResponseBody
    public DataResult saveOrUpdateRole(Role role, Integer[] mids) {

//  注意，这里我们需要知道当我们在进行多个sql的操作时，需要有事务存在，
//        那么我们处理的代码就应该放在service层


        boolean flag = iRoleService.saveOrUpdateRole(role, mids);


        return flag ? DataResult.ok("操作成功") : DataResult.err("操作失败");
    }


    @RequestMapping("/delRole")
    @ResponseBody
    public DataResult delRole(Integer rid) {

//  注意，这里我们需要知道当我们在进行多个sql的操作时，需要有事务存在，
//        那么我们处理的代码就应该放在service层
        QueryWrapper<AdminRole> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("rid", rid);
        List<AdminRole> list = iAdminRoleService.list(queryWrapper);

        if(list.size()>0){
            return DataResult.err("存在管理员，不能删除");
        }

        boolean flag = iRoleService.delRole(rid);


        return flag ? DataResult.ok("操作成功") : DataResult.err("操作失败");
    }

}

