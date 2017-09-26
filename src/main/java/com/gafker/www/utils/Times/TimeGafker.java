package com.gafker.www.utils.Times;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 关系:GMT+08:00=Etc/GMT-8
 * Created by gafker on 2017/7/29.
 * 温馨提示: GMT+00:00=Etc/GMT=Etc/GMT+0
 * GMT+00:00 老的
 * Etc/GMT-0 新的
 * <p>
 * TimeZone offset为当前时区与格林威治0时区的差值 当前时间毫秒减去时差即得出0时区当前时间
 */
public class TimeGafker {
    private static final int HOUR = 60 * 60 * 1000;
    /**
     * 1.0时区时间（long,second,String）
     * 2.当前时区的当前时间（long,second,String）
     * 3.当前时区的当前时间转换成各国的(long,second，String)
     * 4.注意各国当前时间，与各国过去时间表示
     */
    //可用的TimeZoneIdMap
    public static final Map<String, String> zoneIds = new HashMap<>();
    public static void getGmtTime(){
        TimeZone.setDefault(TimeZone.getTimeZone("Utc/GMT+8"));
        Date d =new Date(1504751779*1000l);
        System.out.println(d.getTimezoneOffset());
        System.out.println(d);
    }

    public static int getGmtSecond() {
        Date that = new Date();
        long gmtMills = that.getTime() + 60000 * that.getTimezoneOffset();
        System.out.println(gmtMills / 1000l);//1504724228 1504753052
        return (int) (gmtMills / 1000l);
    }

    public static void main(String[] args) {
        getGmtSecond();
        //输出不同时区的当前String时间
//        String stringParttern="yyyy-MM-dd HH:mm:ss";
//        outByTimeZoneString(stringParttern,TimeZone.getDefault().getID());
//        System.out.println("----格林威治东3时区-----------------------------------------------------------------");
//        outByTimeZoneString(stringParttern,"GMT+03:00");//Etc/GMT-3
//        System.out.println("----格林威治 0 时区-----------------------------------------------------------------");
//        outByTimeZoneString(stringParttern,"Etc/GMT+0");
//        System.out.println("----格林威治西3时区-----------------------------------------------------------------");
//        outByTimeZoneString(stringParttern,"GMT-03:00");//Etc/GMT+3
//        System.out.println("---------------------------------------------------------------------");
//
//        Long longTime = getTimeZoneMills();//0时区毫秒
//        System.out.println(longTime);
//        int intCurrZeroTime = getTimeZoneSecond();//0时区秒
//        int intTime;//0时区秒
//        System.out.println(intCurrZeroTime);
//        intTime = getDayStart(intCurrZeroTime);
//        System.out.println("Dat Start:" + intTime);
//        intTime = getDayEnd(intCurrZeroTime);
//        System.out.println("Dat End:" + intTime);
        //通过给定时间比较是否在当天内与时区无关
//        boolean sameDay = isSameDay(intCurrZeroTime);
//        System.out.println("The day is same day:"+sameDay);
        //两时区offset间隔(在是时区同一边)--东区
        //getAllTimeZoneIds();
//        String timeString = getGmt0ToOtherTimeString("yyyy-MM-dd HH:mm:ss", getTimeZoneSecond(), "Etc/GMT+2");
//        long timeMills = getGmt0ToOtherTime(getTimeZoneSecond(), "Etc/GMT+2");
//        System.out.println("Etc/GMT+2 :" + timeString + ":" + timeMills);
//        getDateString(1501551362000l);
    }

    public static String getDateString(long l){
        System.out.println("2017-08-01 03:21:54");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = sdf.format(new Date(l));
        System.out.println(dateString);
        return dateString;
    }

    /**完整思路
     * 当前时区时间转换到指定时区：
     * 1.通过A时区时间-0时区与A时区offset差值得到实际0时间
     * 2.通过0时区时间+B时区与0时区offset差值得到实际B时间
     * @param pattern
     * @param gmtTime 0时区时间
     * @param timeZoneB 目标时间
     */
    /**
     * 根据0时区时间得到对应时区long时间
     *
     * @param gmtTime
     * @param timeZoneB
     * @return
     */
    private static long getGmt0ToOtherTime(int gmtTime, String timeZoneB) {
        if (!timeZoneB.contains("Etc/GMT")) {
            //东8区
            timeZoneB = "Etc/GMT-8";
        }
        long curmills = gmtTime * 1000l;
        int timeZone = -Integer.parseInt(timeZoneB.replace("Etc/GMT", ""));
        int hourMills = HOUR * timeZone;
        long bLong = curmills + hourMills;
        return bLong;
    }

    /**
     * 根据0时区时间得到对时区日期String
     *
     * @param pattern
     * @param gmtTime
     * @param timeZoneB
     * @return
     */
    private static String getGmt0ToOtherTimeString(String pattern, int gmtTime, String timeZoneB) {
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        long bLong = getGmt0ToOtherTime(gmtTime, timeZoneB);
        String bDateString = sdf.format(new Date(bLong));
        return bDateString;
    }

    /**
     * 根据当前默认时区得到与0时区时差毫秒
     *
     * @return
     */
    public static long getTimeZoneOffset() {
        return TimeZone.getDefault().getRawOffset();
    }

    /**
     * 与给定int时间为同一天,通过毫秒或秒比与时区无关
     *
     * @param time
     * @return
     */
    public static boolean isSameDay(int time) {
        if (time >= getDayStart(time) && time <= getDayEnd(time)) {
            return true;
        }
        return false;
    }

    /**
     * 给定时间0点一天开始
     *
     * @param time
     * @return
     */
    public static int getDayStart(int time) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(time * 1000l));
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        int start = (int) (calendar.getTime().getTime() / 1000);
        return start;
    }

    /**
     * 给定时间23.59.59一天结束
     *
     * @param time
     * @return
     */
    public static int getDayEnd(int time) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(time * 1000l));
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        int end = (int) (calendar.getTime().getTime() / 1000);
        return end;
    }

    /**
     * 拿到0时区当前时间毫秒
     */
    public static long getTimeZoneMills() {
        Date newDate=null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date(System.currentTimeMillis());
        //格式化成当地时间输出
        String dateString = sdf.format(date);
        System.out.println(TimeZone.getDefault().getID() + ":" + dateString);
        try {
            newDate = sdf.parse(dateString);
        } catch (ParseException e) {
        }
        return newDate.getTime() - getTimeZoneOffset();
    }

    /**
     * 拿到0时区当前时间秒
     */
    public static int getTimeZoneSecond() {
        return (int) (getTimeZoneMills() / 1000);
    }


    /**
     * 获取所有的timeZone
     */
    public static void getAllTimeZoneIds() {
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date da=new Date();
        String[] ids = TimeZone.getAvailableIDs();
        for (int i = 0, len = ids.length; i < len; i++) {
            TimeZone.setDefault(TimeZone.getTimeZone(ids[i]));
            sdf.setTimeZone(TimeZone.getTimeZone(ids[i]));
            System.out.println(ids[i] + ":\t"+da.getTime()+ ":\t"+sdf.format(da)+ ":\t"+da.getTimezoneOffset());
        }
    }

    /**
     * 测试展示
     *
     * @param stringPartten  String日期格式
     * @param timeZoneString 时区表示 Etc/GMT-8 GMT+08:00 东8区
     */
    private static void outByTimeZoneString(String stringPartten, String timeZoneString) {
        if (stringPartten == null || "".equals(stringPartten)) {
            stringPartten = "yyyy-MM-dd HH-mm-ss";
        }
        if (timeZoneString == null || "".equals(timeZoneString)) {
            timeZoneString = "Etc/GMT+0";
        }
        SimpleDateFormat sdf = new SimpleDateFormat(stringPartten);
        long offset;
        String dateString;
        Date date = new Date(System.currentTimeMillis());
        sdf.setTimeZone(TimeZone.getTimeZone(timeZoneString));//相同：Etc/GMT Etc/GMT+0
        offset = sdf.getTimeZone().getRawOffset();
        dateString = sdf.format(date);
        System.out.println(dateString);
        System.out.println("offsetHour:" + offset / HOUR);
        System.out.println(sdf.getTimeZone());
    }

/**
 * 毫秒值
 * new Date()
 * System.currentTimeMills();
 * TimeZone.setDefaultTimeZone();
 */

}
