package com.sxt.tingyu.controller;

import com.sxt.tingyu.bean.DataResult;
import com.sxt.tingyu.util.AliyunSendSmsUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class SendSmsController {

    @RequestMapping("/sendSms")
    @ResponseBody
    public Object sendSms(String phone, HttpSession session){


        int randomCode = AliyunSendSmsUtils.randomCode();
        session.setAttribute("randomCode", randomCode);
        System.out.println("randomCode = " + randomCode);
        session.setMaxInactiveInterval(600);
        String s = AliyunSendSmsUtils.sendSms(phone, randomCode);
        System.out.println(s);

        return s;
    }

    @RequestMapping("/checkCode")
    @ResponseBody
    public boolean checkCode(String verifyCode, HttpSession session){

        Object randomCode = session.getAttribute("randomCode");
        if(verifyCode.equals(randomCode+"")){
            return true;
        }
        return false;
    }

}
