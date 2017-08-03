package com.gafker.www.utils.Times;

/**
 * Created by gafker on 2017/8/3.
 */

import java.util.Calendar;

/**
 * ����Calendar��API��װ��һЩ���ú���
 */
public class CalendarSelfDefUtils {

    public static void main(String[] args) {
        Calendar cal = Calendar.getInstance();

        // ��������Ϊ��2013-09-18��
        cal.set(2013, Calendar.SEPTEMBER, 18);

        // ��ȡ���ꡱ
        System.out.printf("year: %s\n", getYear(cal) );
        // ��ȡ���¡�
        System.out.printf("month: %s\n", getMonth(cal) );
        // ��ȡ�����¡�
        System.out.printf("previcou month: %s\n", getLastMonth(cal) );
        // ��ȡ�����¡�
        System.out.printf("next month: %s\n", getNextMonth(cal) );
        // ��ȡ���ա�
        System.out.printf("day: %s\n", getDay(cal) );
        // ��ȡCal��Ӧ���ڼ�
        System.out.printf("weekday: %s\n", getWeekDay(cal) );
        // ��������
        System.out.printf("Current Month days: %s\n", getMonthDays(cal) );
        // ��������
        System.out.printf("Previcous Month days: %s\n", getPrevMonthDays(cal) );
        // ��������
        System.out.printf("Next Month days: %s\n", getNextMonthDays(cal) );
        // ��ȡ���µ�һ������ڼ�
        System.out.printf("First day' weekday : %s\n", getFirstDayWeekday(cal) );
        // ��ȡ��ǰ�����һ������ڼ�
        System.out.printf("Last day' weekday : %s\n", getLastDayWeekday(cal) );
        // ��ȡ�������һ������ڼ�
        System.out.printf("PrevMonth Last day' weekday: %s\n", getLastDayWeekdayOfPrevMonth(cal) );
        // ��ȡ���µ�һ������ڼ�
        System.out.printf("NextMonth First day' weekday: %s\n", getFirstDayWeekdayOfNextMonth(cal) );
    }

    /**
     * ��ȡ���ꡱ
     *
     * @return ���磬2013-09-18���򷵻�2013
     */
    public static int getYear(Calendar cal) {
        return cal.get(Calendar.YEAR);
    }

    /**
     * ��ȡ���¡�
     *
     * @return ����ֵ����Ϊ����ֵ��
     * JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER, UNDECIMBER��
     * ���е�һ������ JANUARY����Ϊ 0��
     *
     * ���磬2013-09-18���򷵻�8
     */
    public static int getMonth(Calendar cal) {
        return cal.get(Calendar.MONTH);
    }

    /**
     * ��ȡ����һ���¡�
     *
     * @return ����ֵ����Ϊ����ֵ��
     * JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER, UNDECIMBER��
     * ���е�һ������ JANUARY����Ϊ 0��
     *
     * ���磬2012-01-12����һ�����ǡ�11��(��DECEMBER)��
     */
    public static int getLastMonth(Calendar cal) {
        return (cal.get(Calendar.MONTH) + 11) % 12;
    }

    /**
     * ��ȡ����һ���¡�
     *
     * @return ����ֵ����Ϊ����ֵ��
     * JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER, UNDECIMBER��
     * ���е�һ������ JANUARY����Ϊ 0��
     *
     * ���磬2013-12-12����һ�����ǡ�1��(��DECEMBER)��
     */
    public static int getNextMonth(Calendar cal) {
        return (cal.get(Calendar.MONTH) + 13) % 12;
    }

    /**
     * ��ȡ���ա�
     *
     * @return ���磬2013-09-18���򷵻�18
     *
     */
    public static int getDay(Calendar cal) {
        return cal.get(Calendar.DATE);
    }

    /**
     * ��ȡ�����µ�������
     *
     * @return ���磬2013-09-18���򷵻�30
     *
     */
    public static int getMonthDays(Calendar cal) {
        return cal.getActualMaximum(Calendar.DATE);
    }

    /**
     * ��ȡ����һ���µ�������
     *
     * @return ���磬2013-01-18���򷵻�31 (��Ϊ2012-12��31��)
     *
     */
    public static int getPrevMonthDays(Calendar cal) {
        Calendar tmpCal = (Calendar)cal.clone(); // ��¡cal�������tmpCal�������Ͳ���ı�cal
        tmpCal.add(Calendar.MONTH, -1);   // ��Ϊ����һ���¡�
        return tmpCal.getActualMaximum(Calendar.DATE);
    }

    /**
     * ��ȡ����һ���µ�������
     *
     * @return ���磬2013-12-18���򷵻�31 (��Ϊ2014-01��31��)
     *
     */
    public static int getNextMonthDays(Calendar cal) {
        Calendar tmpCal = (Calendar)cal.clone(); // ��¡cal�������tmpCal�������Ͳ���ı�cal
        tmpCal.add(Calendar.MONTH, 1);   // ��Ϊ����һ���¡�
        return tmpCal.getActualMaximum(Calendar.DATE);
    }

    /**
     * ��ȡCal��Ӧ���ڼ�
     *
     * @return ���ء����ڼ���������Ϊ����ֵ��
     * SUNDAY��MONDAY��TUESDAY��WEDNESDAY��THURSDAY��FRIDAY �� SATURDAY��
     * SUNDAYΪ1��MONDAYΪ2���������ơ�
     * ���磬2013-09-18(������)���򷵻�4
     */
    public static int getWeekDay(Calendar cal) {
        return cal.get(Calendar.DAY_OF_WEEK);
    }


    /**
     * ��ȡ���µ�һ���Ӧ���ڼ�
     *
     * @return SUNDAYΪ1��MONDAYΪ2���������ơ�
     */
    public static int getFirstDayWeekday(Calendar cal) {

        Calendar tmpCal = (Calendar)cal.clone(); // ��¡cal�������tmpCal�������Ͳ���ı�cal
        tmpCal.set(Calendar.DATE, 1);   // ����������Ϊ���µ�һ��
        return tmpCal.get(Calendar.DAY_OF_WEEK);
    }

    /**
     * ��ȡ��ǰ�����һ���Ӧ���ڼ�
     *
     * @return SUNDAYΪ1��MONDAYΪ2���������ơ�
     */
    public static int getLastDayWeekday(Calendar cal) {
        Calendar tmpCal = (Calendar)cal.clone(); // ��¡cal�������tmpCal�������Ͳ���ı�cal
        tmpCal.set(Calendar.DATE, 1);   // ����������Ϊ���µ�һ��
        tmpCal.roll(Calendar.DATE, -1);   // ����������Ϊ�������һ��
        return tmpCal.get(Calendar.DAY_OF_WEEK);
    }


    /**
     * ��ȡ�������һ������ڼ�
     *
     * @return SUNDAYΪ1��MONDAYΪ2���������ơ�
     */
    public static int getLastDayWeekdayOfPrevMonth(Calendar cal) {

        Calendar tmpCal = (Calendar)cal.clone(); // ��¡cal�������tmpCal�������Ͳ���ı�cal
        tmpCal.set(Calendar.DATE, 1);   // ����������Ϊ���µ�һ��
        tmpCal.add(Calendar.DATE, -1);   // ����������Ϊ��һ�������һ��
        return tmpCal.get(Calendar.DAY_OF_WEEK);
    }

    /**
     * ��ȡ���µ�һ�������ƫ��
     *
     * @return SUNDAYΪ1��MONDAYΪ2���������ơ�
     */
    public static int getFirstDayWeekdayOfNextMonth(Calendar cal) {

        Calendar tmpCal = (Calendar)cal.clone(); // ��¡cal�������tmpCal�������Ͳ���ı�cal
        tmpCal.add(Calendar.MONTH, 1);   // ��Ϊ����һ���¡�
        tmpCal.set(Calendar.DATE, 1);   // ��Ϊ����һ�족
        return tmpCal.get(Calendar.DAY_OF_WEEK);
    }
}
