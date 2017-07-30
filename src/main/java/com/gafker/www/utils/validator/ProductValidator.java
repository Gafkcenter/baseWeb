package com.gafker.www.utils.validator;

import com.gafker.www.pojo.requestcommond.ProductFormCommond;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Exchanger;

/**
 * 验证提缴表单-手动写验证器
 * new 验证对应实体验证器对象执行验证返回错误列表--原始方法
 * Created by gafker on 2017/7/28.
 */
public class ProductValidator {
    public List<String> validator(ProductFormCommond productFormCommond) {
        List<String> errors = new ArrayList<>();
        String prodName = productFormCommond.getProdName();
        if (prodName == null || prodName.trim().isEmpty()) {
            errors.add("Product must have name!");
        }
        String price = productFormCommond.getPrice();
        if (price == null && price.trim().isEmpty()) {
            errors.add("Product must have a price!");
        } else {
            try {
                Float.parseFloat(price);
            } catch (Exception e) {
                errors.add("Invalid price value!");
            }

        }
        return errors;
    }
}
