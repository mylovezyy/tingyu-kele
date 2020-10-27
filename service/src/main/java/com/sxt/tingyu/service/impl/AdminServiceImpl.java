package com.sxt.tingyu.service.impl;

import com.sxt.tingyu.bean.Admin;

import com.sxt.tingyu.mapper.AdminMapper;

import com.sxt.tingyu.service.IAdminService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Service
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements IAdminService {

    @Autowired
    private AdminMapper adminMapper;


    @Override
    public List selectAllAdmin() {
        List<Admin> admins = adminMapper.selectAllAdmin();

        return admins;
    }



}
