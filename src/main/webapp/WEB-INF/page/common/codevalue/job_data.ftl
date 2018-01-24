var __LocalJobData = {
list: {
<#list jobs as job>
    "${job.code_value}": ["${job.code_name}", "", "","${job.code_describe}","${job.par_code_value}"]<#if job_has_next>,</#if>
</#list>
},
<!--下级工种 -->
relations: {
<#list job_list as job>
"${job.father}": [<#list job.son_list as job_son>"${job_son.son}"<#if job_son_has_next>,</#if></#list>]<#if job_has_next>,</#if>
</#list>
},
category: {
<!--一级工种 -->
provinces: [<#list job_one_list as job_one>"${job_one.code_value}"<#if job_one_has_next>,</#if></#list>],
<!-- 热门工种 -->
hotcities: ["070115", "040100", "020200", "060107", "150103", "030911", "070805", "190111", "190116", "160220", "190102", "190110", "090216", "040404", "050414", "030412"]
}
};