var __LocalIndustryData = {
    list: {
    <#list industrys as industry>
        "${industry.code_value}": ["${industry.code_name}", "", "","${industry.code_describe}","${industry.par_code_value}"]<#if industry_has_next>,</#if>
    </#list>
    },
    <!--下级行业 -->
    relations: {
    <#list industry_list as industry>
        "${industry.father}": [<#list industry.son_list as industry_son>"${industry_son.son}"<#if industry_son_has_next>,</#if></#list>]<#if industry_has_next>,</#if>
    </#list>
    },
    category: {
        <!--一级行业 -->
        provinces: [<#list industry_one_list as industry_one>"${industry_one.code_value}"<#if industry_one_has_next>,</#if></#list>],
        <!-- 热门行业 -->
        hotcities: ["070100", "090100", "080100", "030100", "030300", "050200", "070600", "070200", "060100"]
    }
};