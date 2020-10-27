package com.sxt.tingyu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.sxt.tingyu.bean.Role;
import com.sxt.tingyu.bean.RoleMenu;
import com.sxt.tingyu.mapper.RoleMapper;
import com.sxt.tingyu.mapper.RoleMenuMapper;
import com.sxt.tingyu.service.IAdminRoleService;
import com.sxt.tingyu.service.IRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

    @Autowired
    private RoleMenuMapper roleMenuMapper;



    @Override
    public boolean saveOrUpdateRole(Role role, Integer[] mids) {

//        在mybatisplus中，我们将数据存入到数据库，主键自动增长，当完成添加后，会返回添加数据的主键
        boolean b = this.saveOrUpdate(role);
        Integer rid = role.getRid();
        QueryWrapper<RoleMenu> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("rid", rid);
        roleMenuMapper.delete(queryWrapper);
        //通过主键我们可以将对应的菜单id添加到菜单中间表
        if (b) {
            for (Integer mid : mids) {
                RoleMenu roleMenu = new RoleMenu();
                roleMenu.setRid(rid);
                roleMenu.setMid(mid);
                int insert = roleMenuMapper.insert(roleMenu);

                if (insert == 0) {
                    return false;
                }
            }
        }else {
            return false;
        }


        return true;
    }

    @Override
    public boolean delRole(Integer rid) {




        boolean b = this.removeById(rid);
        UpdateWrapper<RoleMenu> updateWrapper=new UpdateWrapper<>();
        updateWrapper.eq("rid", rid);
        if(b){
            int delete = roleMenuMapper.delete(updateWrapper);
            if(delete==0){
                return false;
            }

        }else{
            return false;
        }

        return true;
    }
}
