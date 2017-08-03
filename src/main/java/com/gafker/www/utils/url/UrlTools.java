package com.gafker.www.utils.url;

import com.mchange.v2.collection.MapEntry;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/31.
 */
public class UrlTools {
    public static void main(String[] args) {
        try {
            String params = "";
            Map<String,String> map =new HashMap<>();
            map.put("A1","中国");
            map.put("A2","日本");
            map.put("A3","美国");
            map.put("A4","英国");
            map.put("A5","法国");
            for(Map.Entry<String,String> m:map.entrySet()){
                params+="&"+URLEncoder.encode(m.getKey(),"UTF-8")+"=";
            }
            String url="http://dbo.vshowlive.com/vshow-console/user/info?userId=334428&name=测试";
            String  name = url;
           name = URLEncoder.encode(name, "UTF-8");
            System.out.println(name);
            //name = URLEncoder.encode(name, "UTF-8");
            System.out.println(name);
            //name = URLDecoder.decode(name, "UTF-8");
            System.out.println(name);
            System.out.println(URLDecoder.decode(name, "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
}
