package com.sxt.tingyu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sxt.tingyu.bean.PageDataResult;
import com.sxt.tingyu.bean.Planner;
import com.sxt.tingyu.mapper.PlannerMapper;
import com.sxt.tingyu.service.IPlannerService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Service
public class PlannerServiceImpl extends ServiceImpl<PlannerMapper, Planner> implements IPlannerService {

    @Override
    public PageDataResult selectAllPlanner(Integer cid, Integer rows, Integer pages) {
        Page<Planner> page=new Page<>(pages,rows);
        QueryWrapper<Planner> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("cid", cid);
        Page<Planner> plannerPage = this.page(page, queryWrapper);
        PageDataResult pageDataResult=new PageDataResult();
        pageDataResult.setTotal(plannerPage.getTotal());
        pageDataResult.setRows(plannerPage.getRecords());


        return pageDataResult;
    }
}
