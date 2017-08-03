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

        Date date =  new Date();
        //1.默认时区long
        Long dateLong = date.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
       String defRawDate =  sdf.format(dateLong);
        System.out.println("1默认时区long:"+dateLong+"\t"+defRawDate);
       //2.得到GMT0时区 0时区对吗？
        Long timeZone0Long = dateLong-(TimeZone.getDefault().getRawOffset());
        String defGMT0Date =  sdf.format(dateLong);
        System.out.println("2得到GMT0时区 0时区对吗？:"+timeZone0Long+"\t"+defGMT0Date);
        //3.加timeZone到当地毫秒
       Long timeZoneLong =timeZone0Long+(TimeZone.getTimeZone("Etc/GMT-8")).getRawOffset();
        //4.转换到String
        sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //4.1默认转换String  确认正确性
        String timeNoZoneStringDate = sdf.format(timeZoneLong);
        System.out.println("4加timeZone到当地毫秒-4.1默认转换String  确认正确性:"+timeZoneLong+"\t"+timeNoZoneStringDate);
        //4.2带timeZone转换String  确认正确性
        sdf.setTimeZone(TimeZone.getTimeZone("Etc/GMT-8"));
        String timeZoneStringDate = sdf.format(timeZoneLong);
        System.out.println("加timeZone到当地毫秒-4.2带timeZone转换String  确认正确性:"+timeZoneLong+"\t"+timeZoneStringDate);
        //5.转回指定时区毫秒（是否与之前的相同）
        //5.1默认转换String  确认正确性
        sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date timeNoZoneStringDateTo =  sdf.parse(timeNoZoneStringDate);
        Long  timeZoneLongSame = timeNoZoneStringDateTo.getTime();
        System.out.println("5.转回指定时区毫秒（是否与之前的相同）-5.1默认转换String  确认正确性:(long与4.1相同吗)"+timeZoneLongSame+"\t"+timeNoZoneStringDate);
        //5.2默认转换String  确认正确性
        sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date timeZoneStringDateTo =  sdf.parse(timeZoneStringDate);
        Long  timeZzoneLongSame = timeNoZoneStringDateTo.getTime();
        System.out.println("5.转回指定时区毫秒（是否与之前的相同）-5.2默认转换String  确认正确性:(long与4.1相同吗)"+timeZzoneLongSame+"\t"+timeZoneStringDate);
    }

    public void test() throws ParseException{
        //        vshowId:1745253
//        searchStartTime:1501430400000
//        searchEndTime:1501516740000
//        timezone:8
//        startTime:2017-07-31 00:00
//        endTime:2017-07-31 23:59

//       Integer startTime= 1501430400;
//       Integer endTime= 1501516740;
//        String timeZone="+2";
//        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        format.setTimeZone(TimeZone.getTimeZone("GMT" + timeZone));
//        String startDateStr = format.format(new Date(startTime * 1000l));
//        String endDateStr = format.format(new Date(endTime * 1000l));
//        format.setTimeZone(TimeZone.getTimeZone("GMT" + timeZone));
//
//        Integer tempStartTime = Math.round(format.parse(startDateStr).getTime() / 1000);
//        Integer tempEndTime = Math.round(format.parse(endDateStr).getTime() / 1000);
//        System.out.println("tempStartTime:"+tempStartTime+"\t tempEndTime:"+tempEndTime);


        //GMT0
//        Long sysCur = System.currentTimeMillis();
//        Long gmt0 = System.currentTimeMillis()-(TimeZone.getDefault().getRawOffset());
//        System.out.println("default:"+sysCur +"\t gmt0"+ gmt0+"\t offset :"+TimeZone.getDefault().getRawOffset());

        //输出默认时区(默认时区毫秒--String格式--回到毫秒)
        Date date =  new Date();
        Long dateLong = date.getTime();
        SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //1.日期毫秒--String 格式
        String stringDateDef =  sdf.format(dateLong);
        //2.String 到日期毫秒
        long longDateDef = sdf.parse(stringDateDef).getTime();
        sdf.setTimeZone(TimeZone.getDefault());
        //1.日期毫秒--String 格式
        String stringDateTimeZoneDef =  sdf.format(date);
        //2.String 到日期毫秒
        long longDateTimeZoneDef = sdf.parse(stringDateTimeZoneDef).getTime();
        System.out.println("输出当前时区当前时间毫秒与string:");
        System.out.println("时区："+TimeZone.getDefault().getRawOffset()/(60*60*1000)+"\tlong:"+dateLong+"\t stringDateDef:"+stringDateDef+"\t stringDateTimeZoneDef:"+stringDateTimeZoneDef);
        //指定时区的毫秒(当前时区得到0时区再得到指定时区)
        Date date1 =  new Date();
        Long dateLong1 = date.getTime();
        SimpleDateFormat sdf1 =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String stringDateNoSetTimeZone = sdf1.format(date1);
        sdf1.setTimeZone(TimeZone.getTimeZone("Etc/GMT-2"));
        String stringDateUseTimeZone = sdf1.format(date1);
        Date date2 =  sdf.parse(stringDateUseTimeZone);
        Long long2 = date2.getTime();
        System.out.println("输出指定时区时间毫秒与string:");
       // System.out.println("指定时区：Etc/GMT-6\ttimeZoneId long: "+long2+"\t StringDate:"+stringDate1);

        //指定时间的毫秒得到对应时间String
        Date date3 = new Date(1501655189000l);
        SimpleDateFormat sdf3 =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sdf3.setTimeZone(TimeZone.getTimeZone("Etc/GMT-8"));
        String dateString =sdf3.format(date3);
        System.out.println(dateString);

        //指定时区的毫秒(当前时区得到0时区再得到指定时区)
        //指定时区的毫秒格式化到String
        //指定时区的毫秒到的日期格式化

        //跨天问题（startTime,endTime）
        //startDay,endDay(yyyy-MM-dd)
    }
}
