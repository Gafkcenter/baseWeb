package com.gafker.www.utils.converter;


import org.springframework.format.FormatterRegistry;

/**
 * Created by gafker on 2017/7/26.
 */
public class FormatterRegistrar implements org.springframework.format.FormatterRegistrar {
    private String datePattern;

    public FormatterRegistrar(String datePattern) {
        this.datePattern = datePattern;
    }

    @Override
    public void registerFormatters(FormatterRegistry registry) {
        registry.addFormatter(new DateFormatter(datePattern));
        //register more formatters here.
    }
}
