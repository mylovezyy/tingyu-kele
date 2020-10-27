package com.sxt.tingyu.mapper;

import com.sxt.tingyu.bean.Menu;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
public interface MenuMapper extends BaseMapper<Menu> {


    public List<Menu> selectMenuById(Integer aid);


}
