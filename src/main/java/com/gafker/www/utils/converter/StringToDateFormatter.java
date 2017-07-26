package com.gafker.www.utils.converter;

import org.springframework.format.FormatterRegistrar;
import org.springframework.format.FormatterRegistry;
import org.springframework.format.datetime.DateFormatter;

/**
 * Created by gafker on 2017/7/26.
 */
public class StringToDateFormatter implements FormatterRegistrar{
    private String datePattern;

    public StringToDateFormatter(String datePattern) {
        this.datePattern = datePattern;
    }

    @Override
    public void registerFormatters(FormatterRegistry registry) {
        registry.addFormatter(new DateFormatter(datePattern));
        //register more formatters here.
    }
}
