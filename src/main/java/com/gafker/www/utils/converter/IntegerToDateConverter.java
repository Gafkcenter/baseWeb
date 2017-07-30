package com.gafker.www.utils.converter;

import org.springframework.core.convert.converter.Converter;

import java.util.Date;

/**
 * 通用String or Long to Date 用于Web层Service层
 * Created by gafker on 2017/7/26.
 */

/**
 * 秒转换为Date
 */
public class IntegerToDateConverter implements Converter<Integer, Date> {

    @Override
    public Date convert(Integer s) {
        try {
            return new Date(s*1000);
        } catch (Exception e) {
            throw new IllegalArgumentException("invalid Integer format.");
        }
    }
}
