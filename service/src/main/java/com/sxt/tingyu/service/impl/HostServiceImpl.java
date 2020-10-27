package com.sxt.tingyu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sxt.tingyu.bean.Host;
import com.sxt.tingyu.bean.PageDataResult;
import com.sxt.tingyu.mapper.HostMapper;
import com.sxt.tingyu.service.IHostService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Objects;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Service
public class HostServiceImpl extends ServiceImpl<HostMapper, Host> implements IHostService {

    @Autowired
    private HostMapper hostMapper;


    @Override
    public PageDataResult selectHostPageData(Host host, Integer pages, Integer rows) {

        Page<Host> page = new Page<>(pages, rows);

        QueryWrapper<Host> queryWrapper = new QueryWrapper<>();

        //这里需要判断参数是否为空，或者位null，如果为空，不能设置该参数
        //StringUtils.isNotBlank()判断字符类型数据是否为空
        if (StringUtils.isNotBlank(host.getHname())) {
            queryWrapper.like("hname", host.getHname());
        }

        if (StringUtils.isNotBlank(host.getStatus())) {
            queryWrapper.like("status", host.getStatus());
        }

        if (StringUtils.isNotBlank(host.getStrong())) {
            if ("0".equals(host.getStrong())) {
                queryWrapper.orderByDesc("strong");
            } else if ("1".equals(host.getStrong())) {
                queryWrapper.orderByAsc("strong");
            }
        }

        if (!Objects.isNull(host.getOrdernumber())) {
            if (0 == host.getOrdernumber()) {
                queryWrapper.orderByDesc("ordernumber");
            } else if (1 == host.getOrdernumber()) {
                queryWrapper.orderByAsc("ordernumber");
            }
        }

        if (!Objects.isNull(host.getHpstar())) {

                queryWrapper.eq("hpstar", host.getHpstar());

        }

        if(!Objects.isNull(host.getHpdiscount())){
            queryWrapper.eq("hpdiscount", host.getHpdiscount());
        }


        IPage<Host> hostIPage = hostMapper.selectHostPageData(queryWrapper, page);

        PageDataResult pageDataResult = new PageDataResult();
        pageDataResult.setRows(hostIPage.getRecords());
        pageDataResult.setTotal(hostIPage.getTotal());

        System.out.println("123");
        return pageDataResult;
    }
}
