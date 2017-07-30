package com.gafker.www.utils.validator;

import com.gafker.www.pojo.requestcommond.Product;
import com.gafker.www.pojo.requestcommond.ProductFormCommond;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.Date;

/**
 *  验证提缴表单-利用Spring Validator验证器
 *  new 验证对应实体验证器与BindResult配合使用--Spring方法内使用
 *  注意：要使用验证器对整个类起作用：可Controller内重写initBinder() set注入验证器,原后调用 initBinder() 的 validate()方法
 * Created by gafker on 2017/7/29.
 */
public class ProductSpringValidator implements Validator{
    /**
     * 确认能否处理指定的类
     * @param aClass
     * @return
     */
    @Override
    public boolean supports(Class<?> aClass) {
        return ProductFormCommond.class.isAssignableFrom(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        Product productFormCommond =(Product)o;
        ValidationUtils.rejectIfEmpty(errors,"prodName","productName.required");
        ValidationUtils.rejectIfEmpty(errors,"price","price.required");
        ValidationUtils.rejectIfEmpty(errors,"prodDate","productDate.required");

        Float price = productFormCommond.getPrice();
        if(price != null && price < 0){
            errors.rejectValue("price","price.negative");
        }
        Date productDate = productFormCommond.getProductDate();
        if(productDate != null){
            if(productDate.after(new Date())){
                errors.rejectValue("productionDate","productionDate.invalid");
            }
        }

    }
}
