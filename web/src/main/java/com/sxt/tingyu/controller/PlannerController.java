package com.sxt.tingyu.controller;


import com.sxt.tingyu.bean.PageDataResult;
import com.sxt.tingyu.bean.Planner;
import com.sxt.tingyu.service.IPlannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Controller
@RequestMapping("/planner")
public class PlannerController {


    @Autowired
    private IPlannerService iPlannerService;

    @RequestMapping("/selectAllPlanner")
    @ResponseBody
    public PageDataResult selectAllPlanner(Integer cid,Integer rows,Integer page){

        PageDataResult pageDataResult= iPlannerService.selectAllPlanner(cid,rows,page);
        return pageDataResult;

    }


}

