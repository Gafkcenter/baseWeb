package com.gafker.www.utils.Times;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

/**
 * Created by Administrator on 2017/8/1.
 */
public class TimeBetwin {

    public static void main(String[] args) throws ParseException {
        //1..默认时区时间毫秒---2.得到GMT0时区---3.加timeZone到当地毫秒--4.转换到String---5.转回指定时区毫秒（是否与之前的相同）--6.转换回指定时区String
        //2.时间切分：前一天的时间，后一天的时间yyyy-MM-dd
        //3.时间切分：分给前一天的时长，分给后一天的时长
//        Date date =  new Date();
        //1.默认时区long
//        Long dateLong = date.getTime();
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//       String defRawDate =  sdf.format(dateLong);
//        System.out.println("1默认时区long:"+dateLong+"\t"+defRawDate);
       //2.得到GMT0时区 0时区对吗？
//        Long timeZone0Long = dateLong-(TimeZone.getDefault().getRawOffset());
//        String defGMT0Date =  sdf.format(dateLong);
//        System.out.println("2得到GMT0时区 0时区对吗？:"+timeZone0Long+"\t"+defGMT0Date);
        //3.加timeZone到当地毫秒
//       Long timeZoneLong =timeZone0Long+(TimeZone.getTimeZone("Etc/GMT-8")).getRawOffset();
        //1501430400000L//中国的2018/7/31 00:00:00
        int ieTimeZone=+8;
        int familyTimeZone=-6;
        int res=ieTimeZone-familyTimeZone;
        Long lStart=1501430400000L+res*60*60*1000;//搜索开始当地时区0点
        Long lEnd=1501430400000L+res*60*60*1000+24*60*60*1000-1000;//搜索结束当地时间23:59:59
        Date date =  new Date(lStart);
        //验证
        //要转换到的目标时区（要查到目标时间是0点的必须做处理才能得到家族的0时区，要不原变是电脑上的时区出现不准）
        getDiffrentTimeZoneLongAndString(date,"Etc/GMT+6");
        //ie传过来的时区(ie上传0点时区时间来，但在另一时区不是0点)
        getDiffrentTimeZoneLongAndString(date,"Etc/GMT-8");
//        getDiffrentTimeZoneLongAndString(date,"Etc/GMT+3");
//        getDiffrentTimeZoneLongAndString(date,"Etc/GMT-8");
//        getDiffrentTimeZoneLongAndString(date,"Etc/GMT+12");
//        getDiffrentTimeZoneLongAndString(date,"Etc/GMT-12");

    }

    private static void getDiffrentTimeZoneLongAndString(Date date,String timeZone) throws ParseException {
        //1.默认时区long
        TimeZone.setDefault(TimeZone.getTimeZone(timeZone));
        Long dateLong = date.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String defRawDate =  sdf.format(dateLong);
        System.out.println("1默认时区long:"+dateLong+"\t"+defRawDate);
        System.out.println("1默认时区TimeZone:"+TimeZone.getDefault());
        String stringAfeterDate = sdf.format(dateLong);
        Long reverseToLong = sdf.parse(stringAfeterDate).getTime();
        System.out.println(sdf.getTimeZone() + "---" + stringAfeterDate+"---"+reverseToLong);
        System.out.println("----------------------------------------------------");
    }

    public void test1() throws ParseException {
        //1..默认时区时间毫秒---2.得到GMT0时区---3.加timeZone到当地毫秒--4.转换到String---5.转回指定时区毫秒（是否与之前的相同）--6.转换回指定时区String
        //2.时间切分：前一天的时间，后一天的时间yyyy-MM-dd
        //3.时间切分：分给前一天的时长，分给后一天的时长

        Date date = new Date();
        //1.默认时区long
        Long dateLong = date.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String defRawDate = sdf.format(dateLong);
        System.out.println("1默认时区long:" + dateLong + "\t" + defRawDate);
        //2.得到GMT0时区 0时区对吗？
        Long timeZone0Long = dateLong - (TimeZone.getDefault().getRawOffset());
        String defGMT0Date = sdf.format(dateLong);
        System.out.println("2得到GMT0时区 0时区对吗？:" + timeZone0Long + "\t" + defGMT0Date);
        //3.加timeZone到当地毫秒
        Long timeZoneLong = timeZone0Long + (TimeZone.getTimeZone("Etc/GMT-8")).getRawOffset();
        //4.转换到String
//        sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //4.1默认转换String  确认正确性
//        String timeNoZoneStringDate = sdf.format(timeZoneLong);
//        System.out.println("4加timeZone到当地毫秒-4.1默认转换String  确认正确性:"+timeZoneLong+"\t"+timeNoZoneStringDate);
        //4.2带timeZone转换String  确认正确性
//        sdf.setTimeZone(TimeZone.getTimeZone("Etc/GMT-8"));
//        String timeZoneStringDate = sdf.format(timeZoneLong);
//        System.out.println("加timeZone到当地毫秒-4.2带timeZone转换String  确认正确性:"+timeZoneLong+"\t"+timeZoneStringDate);
        //5.转回指定时区毫秒（是否与之前的相同）
        //5.1默认转换String  确认正确性
//        sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        Date timeNoZoneStringDateTo =  sdf.parse(timeNoZoneStringDate);
//        Long  timeZoneLongSame = timeNoZoneStringDateTo.getTime();
//        System.out.println("5.转回指定时区毫秒（是否与之前的相同）-5.1默认转换String  确认正确性:(long与4.1相同吗)"+timeZoneLongSame+"\t"+timeNoZoneStringDate);
        //5.2默认转换String  确认正确性
//        sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        Date timeZoneStringDateTo =  sdf.parse(timeZoneStringDate);
//        Long  timeZzoneLongSame = timeNoZoneStringDateTo.getTime();
//        System.out.println("5.转回指定时区毫秒（是否与之前的相同）-5.2默认转换String  确认正确性:(long与4.1相同吗)"+timeZzoneLongSame+"\t"+timeZoneStringDate);
    }
}
