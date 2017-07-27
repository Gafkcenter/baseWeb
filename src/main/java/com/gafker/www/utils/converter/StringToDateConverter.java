package com.gafker.www.utils.converter;

import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 通用String or Long to Date 用于Web层Service层
 * Created by gafker on 2017/7/26.
 */
public class StringToDateConverter implements Converter<String, Date> {
    private String datePattern;

    public StringToDateConverter(String datePattern) {
        this.datePattern = datePattern;
    }

    @Override
    public Date convert(String s) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat(datePattern);
            dateFormat.setLenient(false);
            return dateFormat.parse(s);
        } catch (ParseException e) {
            throw new IllegalArgumentException("invalid date format.Please use this pattern\"" + datePattern + "\"");
        }
    }
}
