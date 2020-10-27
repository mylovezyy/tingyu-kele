package com.sxt.tingyu.util;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;

public class AliyunSendSmsUtils {


    public static int randomCode() {
        int v = (int) (Math.random() * (999999 - 100000) + 1 + 100000);
        return v;

    }


    public static String sendSms(String phone, int randomCode) {
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAI4GJZkQpK7eRtu4XPh7Y9", "wTmWmcb0GUO1XrLRLEXSGcnKFWeGOG");
        IAcsClient client = new DefaultAcsClient(profile);

        CommonRequest request = new CommonRequest();
        request.setSysMethod(MethodType.POST);
        request.setSysDomain("dysmsapi.aliyuncs.com");
        request.setSysVersion("2017-05-25");
        request.setSysAction("SendSms");
        request.putQueryParameter("RegionId", "cn-hangzhou");
        request.putQueryParameter("PhoneNumbers", phone);
        request.putQueryParameter("SignName", "tingyu主持人");
        request.putQueryParameter("TemplateCode", "SMS_204751123");
//        request.putQueryParameter("TemplateParam", "{\"code\":\"" + randomCode + "\"}");
        request.putQueryParameter("TemplateParam", "{\"code\":\"NiShiHanPi\"}");

        try {
            CommonResponse response = client.getCommonResponse(request);
            System.out.println(response.getData());
            String data = response.getData();
            return  data;
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }

        return null;

    }

}
