package com.sxt.tingyu.service;

import com.sxt.tingyu.bean.PageDataResult;
import com.sxt.tingyu.bean.Planner;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
public interface IPlannerService extends IService<Planner> {

    PageDataResult selectAllPlanner(Integer cid, Integer rows, Integer page);
}
