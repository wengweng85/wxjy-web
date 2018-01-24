var __LocalAreaData = {
    list: {
    <#list areas as area>
        "${area.code_value}": ["${area.code_name}", "", "","${area.code_describe}","${area.par_code_value}"]<#if area_has_next>,</#if>
    </#list>
    },
    <!--下级地区 -->
    relations: {
    <#list area_list as area>
        "${area.father}": [<#list area.son_list as area_son>"${area_son.son}"<#if area_son_has_next>,</#if></#list>]<#if area_has_next>,</#if>
    </#list>
    },
    category: {
        <!--省份 -->
        provinces: [<#list provinces as area>"${area.code_value}"<#if area_has_next>,</#if></#list>],
        <!-- 热门城市 -->
        hotcities: ["${localcity}"<#list area_list as area><#if area.father==localcity><#list area.son_list as area_son>,"${area_son.son}"</#list></#if></#list>]
    }
};