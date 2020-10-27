package com.sxt.tingyu.service;

import com.sxt.tingyu.bean.Company;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sxt.tingyu.bean.PageDataResult;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
public interface ICompanyService extends IService<Company> {

    PageDataResult companyPage(Company company, Integer rows, Integer page);
}
