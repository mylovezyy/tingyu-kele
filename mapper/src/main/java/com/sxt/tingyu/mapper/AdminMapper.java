package com.sxt.tingyu.mapper;

import com.sxt.tingyu.bean.Admin;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
public interface AdminMapper extends BaseMapper<Admin> {


    @Select("SELECT a.*,r.rname from t_admin a LEFT JOIN t_admin_role ar on a.aid=ar.aid LEFT JOIN t_role r on ar.rid=r.rid")
    List<Admin> selectAllAdmin();


}
