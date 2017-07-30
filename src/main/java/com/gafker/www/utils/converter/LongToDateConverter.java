package com.gafker.www.utils.converter;

import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 通用String or Long to Date 用于Web层Service层
 * Created by gafker on 2017/7/26.
 */
public class LongToDateConverter implements Converter<Long, Date> {

    @Override
    public Date convert(Long s) {
        try {
            return new Date(s);
        } catch (Exception e) {
            throw new IllegalArgumentException("invalid Long format.");
        }
    }
}
