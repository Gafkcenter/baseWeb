package com.gafker.www.utils.Times;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

/**
 * Created by gafker on 2017/8/4.
 */
public class ZeroTime {
    public static void main(String[] args) {
        TimeZone.setDefault(TimeZone.getTimeZone("Etc/GMT-8"));
        System.out.println(new Date()+":"+new Date().getTimezoneOffset()+":"+new Date().getTime());
        Date d = new Date(1501862400000l);
        d.getTimezoneOffset();
        System.out.println(d+":"+d.getTimezoneOffset());
        SimpleDateFormat sdff = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sdff.setTimeZone(TimeZone.getTimeZone("Etc/GMT+7"));
        Long dLong = d.getTime();
        /**
         * 转换搜索的时间区间
         */
        int idTimeZone=8;//浏览器搜索送过来的时区
        int familyTimeZone=-7;//家族的时区
        Long timeZoneLongbet =  (idTimeZone-familyTimeZone)*60*60*1000l;
        String dateString  = sdff.format(dLong+timeZoneLongbet);
        System.out.println(sdff.getTimeZone()+":"+dateString);
//        getTimeString();

        }

    private static void getTimeString() {
        SimpleDateFormat f1 = new SimpleDateFormat("yyyy-MM-dd");
        try {
            System.out.println(f1.parse("2015-12-12"));
            f1.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
            System.out.println(f1.parse("2015-12-12"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

}
