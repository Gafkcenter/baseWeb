package com.gafker.www.utils.converter;

import org.springframework.format.Formatter;
import org.springframework.format.FormatterRegistrar;
import org.springframework.format.FormatterRegistry;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * Created by gafker on 2017/7/26.
 */
public class DateFormatter implements Formatter<Date> {
    private String datePattern;
    private SimpleDateFormat dateFormat;

    public DateFormatter(String datePattern) {
        this.datePattern = datePattern;
        dateFormat = new SimpleDateFormat(datePattern);
        dateFormat.setLenient(false);
    }

    @Override
    public Date parse(String s, Locale locale) throws ParseException {
        try{
            return dateFormat.parse(s);
        }catch (Exception e){
            throw   new IllegalArgumentException("invalid date format.Please use this pattern\""+dateFormat+"\"");
        }
    }

    @Override
    public String print(Date date, Locale locale) {
        return null;
    }
}
