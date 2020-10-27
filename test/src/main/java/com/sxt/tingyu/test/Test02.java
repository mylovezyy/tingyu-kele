//package com.sxt.tingyu.test;
//
//import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
//import com.baomidou.mybatisplus.core.metadata.IPage;
//import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
//import com.sxt.tingyu.bean.Host;
//import com.sxt.tingyu.mapper.HostMapper;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.test.context.ContextConfiguration;
//import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//
//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration("classpath:springdao.xml")
//public class Test02 {
//
//    @Autowired
//    private HostMapper hostMapper;
//    @Test
//    public void selectHostPageData(){
//        Page<Host> page=new Page<Host>(1,10);
//
//        QueryWrapper<Host> queryWrapper=new QueryWrapper<>();
//
//        IPage<Host> hostIPage = hostMapper.selectHostPageData(queryWrapper, page);
//
//        System.out.println("hostIPage = " + hostIPage);
//
//
//    }
//}
