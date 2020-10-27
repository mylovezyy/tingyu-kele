package com.sxt.tingyu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sxt.tingyu.bean.Company;
import com.sxt.tingyu.bean.PageDataResult;
import com.sxt.tingyu.mapper.CompanyMapper;
import com.sxt.tingyu.service.ICompanyService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Objects;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Service
public class CompanyServiceImpl extends ServiceImpl<CompanyMapper, Company> implements ICompanyService {

    @Override
    public PageDataResult companyPage(Company company, Integer rows, Integer pageNumber) {

        Page<Company> page=new Page<>(pageNumber,rows);
        QueryWrapper<Company> queryWrapper=new QueryWrapper<>();
        if(StringUtils.isNotBlank(company.getCname())){
            queryWrapper.like("cname", company.getCname());
        }

        if(StringUtils.isNotBlank(company.getStatus())){
            queryWrapper.eq("status", company.getStatus());
        }

        if(!Objects.isNull(company.getOrdernumber())){
            if(company.getOrdernumber()==0){
                queryWrapper.orderByDesc("ordernumber");
            }
            if(company.getOrdernumber()==1){
                queryWrapper.orderByAsc("ordernumber");
            }
        }

        Page<Company> companyPage = this.baseMapper.selectPage(page, queryWrapper);
        PageDataResult pageDataResult=new PageDataResult();
        pageDataResult.setRows(companyPage.getRecords());
        pageDataResult.setTotal(companyPage.getTotal());


        return pageDataResult;
    }
}
