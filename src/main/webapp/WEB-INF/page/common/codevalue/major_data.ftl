var __LocalMajorData = {
    list: {
    <#list majors as major>
        "${major.code_value}": ["${major.code_name}", "", "","${major.code_describe}","${major.par_code_value}"]<#if major_has_next>,</#if>
    </#list>
    },
    <!--下级专业 -->
    relations: {
    <#list major_list as major>
        "${major.father}": [<#list major.son_list as major_son>"${major_son.son}"<#if major_son_has_next>,</#if></#list>]<#if major_has_next>,</#if>
    </#list>
    },
    category: {
        <!--一级专业 -->
        provinces: [<#list major_one_list as major_one>"${major_one.code_value}"<#if major_one_has_next>,</#if></#list>],
        <!-- 热门专业 -->
        hotcities: ["130501", "135101", "120801", "120501", "120301", "110601"]
    }
};