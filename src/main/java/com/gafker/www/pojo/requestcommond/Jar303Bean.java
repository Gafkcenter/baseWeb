package com.gafker.www.pojo.requestcommond;

import javax.validation.constraints.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by gafker on 2017/7/29.
 * 错误码与提示格式： 注解名.对象名.属性名（如: Size.jar303Bean.hasChildren）
 * 错误提示可以直接放在messages属性文件内
 */
public class Jar303Bean implements Serializable {
    //必须为false
    @AssertFalse
    private boolean hasChildren;
    //必须为true
    @AssertTrue
    private boolean isEmpty;
    //最高价格
    @DecimalMax("10.05")
    private BigDecimal priceHigh;
    //最低价格
    @DecimalMin("0.1")
    private BigDecimal getPriceLow;
    //integer整数位数,fraction小数位数
    @Digits(integer = 5,fraction = 2)
    private BigDecimal getPriceRange;
    //未来的某天
    @Future
    private Date shippingDate;
    //过去的某天
    @Past
    private Date birthDate;
    //小于等于150
    @Max(150)
    private int ageMax;
    //大于等于1
    @Min(1)
    private int ageMin;
    //不能为空
    @NotNull
    private String firstName;
    //可空
    @Null
    private String others;
    //正则匹配必须为3位数
    @Pattern(regexp = "\\d{3}")
    private String areaCode;
    //长度为2~140个字符
    @Size(min=2,max=140)
    private String description;

    public boolean isHasChildren() {
        return hasChildren;
    }

    public void setHasChildren(boolean hasChildren) {
        this.hasChildren = hasChildren;
    }

    public boolean isEmpty() {
        return isEmpty;
    }

    public void setEmpty(boolean empty) {
        isEmpty = empty;
    }

    public BigDecimal getPriceHigh() {
        return priceHigh;
    }

    public void setPriceHigh(BigDecimal priceHigh) {
        this.priceHigh = priceHigh;
    }

    public BigDecimal getGetPriceLow() {
        return getPriceLow;
    }

    public void setGetPriceLow(BigDecimal getPriceLow) {
        this.getPriceLow = getPriceLow;
    }

    public BigDecimal getGetPriceRange() {
        return getPriceRange;
    }

    public void setGetPriceRange(BigDecimal getPriceRange) {
        this.getPriceRange = getPriceRange;
    }

    public Date getShippingDate() {
        return shippingDate;
    }

    public void setShippingDate(Date shippingDate) {
        this.shippingDate = shippingDate;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public int getAgeMax() {
        return ageMax;
    }

    public void setAgeMax(int ageMax) {
        this.ageMax = ageMax;
    }

    public int getAgeMin() {
        return ageMin;
    }

    public void setAgeMin(int ageMin) {
        this.ageMin = ageMin;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getOthers() {
        return others;
    }

    public void setOthers(String others) {
        this.others = others;
    }

    public String getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
