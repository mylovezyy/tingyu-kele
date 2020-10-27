package com.sxt.tingyu.bean;

public class DataResult {

    private Integer status;
    private String msg;


    public static DataResult ok(String msg){
        DataResult dr=new DataResult();
        dr.status=200;
        dr.msg=msg;
        return  dr;
    }

    public static DataResult err(String msg){
        DataResult dr=new DataResult();
        dr.status=500;
        dr.msg=msg;
        return  dr;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
