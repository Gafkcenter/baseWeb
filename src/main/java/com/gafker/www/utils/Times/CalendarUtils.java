package com.gafker.www.utils.Times;

/**
 * Created by gafker on 2017/8/3.
 */

import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.TimeZone;

public class CalendarUtils {

    public static void main(String[] args) {

        // ����Calendar�ġ�17���ֶεĹ��������ӿڡ�
        testAllCalendarSections();

        // ����Calendar�ġ��ȽϽӿڡ�
        testComparatorAPIs();

        // ����Calendar�ġ��ȽϽӿڡ�
        testLenientAPIs();

        // ����Calendar��Date��TimeZone��MilliSecond����غ���
        testTimeAPIs();

        // ����Calendar��clone()��getFirstDayOfWeek()�Ƚӿ�
        testOtherAPIs();

    }


    /**
     * ���ԡ�Calendar���ֶΡ�
     *
     * @param cal   -- Calendar����
     * @param field -- Ҫ���Եġ�Calendar�ֶΡ�������Ϊ����ֵ��
     *              Calendar.YEAR, Calendar.MONTH, Calendar.DATE, ... �ȵ�
     * @param title -- ����
     */
    private static void testSection(Calendar cal, int field, String title) {
        final Random random = new Random();
        final Date date = cal.getTime();

        final int min = cal.getMinimum(field); // ��ȡ"�ֶ���Сֵ"
        final int max = cal.getMaximum(field); // ��ȡ���ֶ����ֵ��

        final int actualMin = cal.getActualMinimum(field); // ��ȡ"��ǰ�����£����ֶ���Сֵ"
        final int actualMax = cal.getActualMaximum(field); // ��ȡ����ǰ�����£����ֶε����ֵ��

        // ��ȡ���ֶεĵ�ǰֵ��
        final int ori = cal.get(field);

        // ���á��ֶεĵ�ǰֵ��, ����ȡ������֮���ֵ��
        final int r1 = random.nextInt(max);
        cal.set(field, r1);
        final int set = cal.get(field);
        try {
            // �ع����ֶεĵ�ǰֵ�����ڡ��ֶ���Сֵ���͡��ֶ����ֵ��֮��ع���
            // ���ع�ֵ������Ϊ����Ҳ����Ϊ����
            cal.roll(field, -max);
        } catch (IllegalArgumentException e) {
            // ��field == Calendar.ZONE_OFFSETʱ�����׳����쳣��
            e.printStackTrace();
        }
        final int roll = cal.get(field);

        // ��ȡһ�����ֵ
        final int sign = (random.nextInt(2) == 1) ? 1 : -1;
        final int r2 = sign * random.nextInt(max);
        try {
            // ���ӡ��ֶεĵ�ǰֵ�� ������ȡ���µĵ�ǰ�ֶ�ֵ��
            // add�ġ�����ֵ������Ϊ����Ҳ����Ϊ����
            cal.add(field, r2);
        } catch (IllegalArgumentException e) {
            // ��field == Calendar.ZONE_OFFSETʱ�����׳����쳣��
            e.printStackTrace();
        }
        final int add = cal.get(field);


        // ��ӡ�ֶ���Ϣ
        System.out.printf("%s:\n\trange is [%d - %d] actualRange is [%d - %d]. original=%d, set(%d)=%d, roll(%d)=%d, add(%d)=%d\n",
                title, min, max, actualMin, actualMax, ori, r1, set, -max, roll, r2, add);
    }

    /**
     * ����Calendar�ġ�17���ֶεĹ��������ӿڡ�
     */
    private static void testAllCalendarSections() {
        // 00. ERA �ֶ�
        testSection(Calendar.getInstance(), Calendar.ERA, "Calendar.ERA");
        // 01. YEAR �ֶ�
        testSection(Calendar.getInstance(), Calendar.YEAR, "Calendar.YEAR");
        // 02. MONTH �ֶ�
        testSection(Calendar.getInstance(), Calendar.MONTH, "Calendar.MONTH");
        // 03. WEEK_OF_YEAR �ֶ�
        testSection(Calendar.getInstance(), Calendar.WEEK_OF_YEAR, "Calendar.WEEK_OF_YEAR");
        // 04. WEEK_OF_MONTH �ֶ�
        testSection(Calendar.getInstance(), Calendar.WEEK_OF_MONTH, "Calendar.WEEK_OF_MONTH");
        // 05. DATE �ֶ�
        testSection(Calendar.getInstance(), Calendar.DATE, "Calendar.DATE");
        // 06. DAY_OF_MONTH �ֶ�
        testSection(Calendar.getInstance(), Calendar.DAY_OF_MONTH, "Calendar.DAY_OF_MONTH");
        // 07. DAY_OF_YEAR �ֶ�
        testSection(Calendar.getInstance(), Calendar.DAY_OF_YEAR, "Calendar.DAY_OF_YEAR");
        // 08. DAY_OF_WEEK �ֶ�
        testSection(Calendar.getInstance(), Calendar.DAY_OF_WEEK, "Calendar.DAY_OF_WEEK");
        // 09. DAY_OF_WEEK_IN_MONTH �ֶ�
        testSection(Calendar.getInstance(), Calendar.DAY_OF_WEEK_IN_MONTH, "Calendar.DAY_OF_WEEK_IN_MONTH");
        // 10. AM_PM �ֶ�
        testSection(Calendar.getInstance(), Calendar.AM_PM, "Calendar.AM_PM");
        // 11. HOUR �ֶ�
        testSection(Calendar.getInstance(), Calendar.HOUR, "Calendar.HOUR");
        // 12. HOUR_OF_DAY �ֶ�
        testSection(Calendar.getInstance(), Calendar.HOUR_OF_DAY, "Calendar.HOUR_OF_DAY");
        // 13. MINUTE �ֶ�
        testSection(Calendar.getInstance(), Calendar.MINUTE, "Calendar.MINUTE");
        // 14. SECOND �ֶ�
        testSection(Calendar.getInstance(), Calendar.SECOND, "Calendar.SECOND");
        // 15. MILLISECOND �ֶ�
        testSection(Calendar.getInstance(), Calendar.MILLISECOND, "Calendar.MILLISECOND");
        // 16. ZONE_OFFSET �ֶ�
        testSection(Calendar.getInstance(), Calendar.ZONE_OFFSET, "Calendar.ZONE_OFFSET");
    }

    /**
     * ����Calendar�ġ��ȽϽӿڡ�
     */
    private static void testComparatorAPIs() {
        // �½�cal1 ����ʱ��Ϊ1988��
        Calendar cal1 = Calendar.getInstance();
        cal1.set(Calendar.YEAR, 1988);
        // �½�cal2 ����ʱ��Ϊ2000��
        Calendar cal2 = Calendar.getInstance();
        cal2.set(Calendar.YEAR, 2000);
        // �½�cal3, Ϊcal1�Ŀ�¡����
        Calendar cal3 = (Calendar) cal1.clone();

        // equals �ж� cal1��cal2�ġ�ʱ�䡢ʱ���ȡ������Ƿ����
        boolean isEqual12 = cal1.equals(cal2);
        // equals �ж� cal1��cal3�ġ�ʱ�䡢ʱ���ȡ������Ƿ����
        boolean isEqual13 = cal1.equals(cal3);
        // cal1�Ƿ��cal2��
        boolean isBefore = cal1.before(cal2);
        // cal1�Ƿ��cal2��
        boolean isAfter = cal1.after(cal2);
        // �Ƚ�cal1��cal2
        // (01) ��cal1 ���� cal2������-1
        // (02) ��cal1 ���� cal2������0
        // (03) ��cal1 ���� cal2������1
        int icompare = cal1.compareTo(cal2);

        System.out.printf("\ntestComparatorAPIs: isEuqal12=%s, isEqual13=%s, isBefore=%s, isAfter=%s, icompare=%s\n",
                isEqual12, isEqual13, isBefore, isAfter, icompare);
    }

    /**
     * ����Calendar�ġ��ȽϽӿڡ�
     */
    private static void testLenientAPIs() {
        Calendar cal = Calendar.getInstance();

        // ��ȡĬ�ϵġ����ݶȡ�������true
        boolean oriLenient = cal.isLenient();
        // MONTHֵֻ���ǡ�0-11��������Խ�硣�������ڵ�ǰcal�ǿ��ݵģ����Բ����׳��쳣
        cal.set(Calendar.MONTH, 50);

        // ���á����ݶȡ�Ϊfalse��
        cal.setLenient(false);
        // ��ȡ���ú�ġ����ݶȡ�
        boolean curLenient = cal.isLenient();
        try {
            // MONTHֵֻ���ǡ�0-11��������Խ�硣���ҵ�ǰcal�ǲ����ݵģ����Ի�����쳣��
            // ���ǣ��쳣���´μ�������ʱ�Ż��׳�������set()�в����׳��쳣����Ҫ�ȵ�get()�вŻ��׳��쳣
            cal.set(Calendar.MONTH, 50);
            // ��ʱ����cal���ж�ȡ����ȡ�ᵼ�����¼���cal��ֵ�����Դ�ʱ�׳��쳣��
            int m2 = cal.get(Calendar.MONTH);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }

        System.out.printf("\ntestLenientAPIs: oriLenient=%s, curLenient=%s\n",
                oriLenient, curLenient);
    }

    /**
     * ����Calendar��Date��TimeZone��MilliSecond����غ���
     */
    private static void testTimeAPIs() {
        Calendar cal = Calendar.getInstance();

        // ����cal��ʱ��Ϊ��GMT+8��
        cal.setTimeZone(TimeZone.getTimeZone("GMT+8"));
        // ��ȡ��ǰ��calʱ��
        TimeZone timezone = cal.getTimeZone();

        // ���� milliseconds
        cal.setTimeInMillis(1279419645742l);
        // ��ȡ milliseconds
        long millis = cal.getTimeInMillis();
        // ���� milliseconds֮��ʱ��Ҳ�ı��ˡ�
        // ��ȡcal��Ӧ������
        Date date = cal.getTime();

        // ����ʱ��Ϊ��1988-08-08��
        cal.set(1988, 8, 8);
        // ����ʱ��Ϊ��1999-09-09 09:09��
        cal.set(1999, 9, 9, 9, 9);
        // ����ʱ��Ϊ��2000-10-10 10:10:10��
        cal.set(2000, 10, 10, 10, 10, 10);

        System.out.printf("\ntestTimeAPIs: date=%s, timezone=%s, millis=%s\n",
                date, timezone, millis);
    }

    /**
     * ����Calendar��clone()��getFirstDayOfWeek()�Ƚӿ�
     */
    private static void testOtherAPIs() {
        Calendar cal = Calendar.getInstance();
        // ��¡cal
        Calendar clone = (Calendar) cal.clone();

        // ���� Ϊ 2013-01-10��
        // ע��2013-01-01 Ϊ�����ڶ�����2013-01-06Ϊ�������족��
        clone.set(Calendar.YEAR, 2013);
        clone.set(Calendar.MONTH, 0);
        clone.set(Calendar.DATE, 10);
        // ���á�����ĵ�һ���������ٰ���1�족��
        // ��2013-01-10���ڵ�2������
        clone.setMinimalDaysInFirstWeek(1);
        int m1 = clone.getMinimalDaysInFirstWeek();
        int index1 = clone.get(Calendar.WEEK_OF_YEAR);

        // ���á�����ĵ�һ���������ٰ���7�족��
        // ��2013-01-10���ڵ�1������
        clone.setMinimalDaysInFirstWeek(7);
        int m2 = clone.getMinimalDaysInFirstWeek();
        int index2 = clone.get(Calendar.WEEK_OF_YEAR);

        // ���á�ÿ�ܵĵ�һ�������ڼ�����
        clone.setFirstDayOfWeek(Calendar.WEDNESDAY);
        // ��ȡ��ÿ�ܵĵ�һ�������ڼ�����
        int firstdayOfWeek = clone.getFirstDayOfWeek();

        System.out.printf("\ntestOtherAPIs: firstdayOfWeek=%s, [minimalDay, WeekOfYear]={(%s, %s), (%s, %s)} %s\n",
                firstdayOfWeek, m1, index1, m2, index2, clone.getTime());
    }
}
