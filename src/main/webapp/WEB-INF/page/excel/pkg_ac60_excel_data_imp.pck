create or replace package pkg_ac60_excel_data_imp AS

  -- 成功返回标志
  RT_SUCCESS_CODE constant number  := '1';
  -- 错误返回标志
  RT_ERROR_CODE   constant number  := '0';

  PROCEDURE ac60_temp_imp_update(in_excel_batch_number varchar2,rt_code out varchar2,rt_msg out varchar2);

end pkg_ac60_excel_data_imp;
/
create or replace package body pkg_ac60_excel_data_imp AS

   PROCEDURE ac60_temp_imp_update(in_excel_batch_number varchar2,rt_code out varchar2,rt_msg out varchar2) AS
   BEGIN
    
     --更新数据状态0/8*40+80
     update s_excel_batch t set t.excel_batch_status='2',t.excel_batch_rt_msg='', t.excel_batch_data_status=round(0/8*70+30),t.excel_batch_end_time=sysdate, t.excel_batch_cost=round((t.excel_batch_end_time-t.excel_batch_begin_time)*24*60*60) where t.excel_batch_number=in_excel_batch_number;  
    
     commit;
     
    --1 数据合法性校验
      
     update ac60_excel_temp t set t.excel_isvalid='0',t.excel_isop='1',t.excel_opdate=sysdate, t.excel_errormsg='姓名不能为空' where  t.excel_batch_number =in_excel_batch_number and t.aac003 is null and excel_isvalid='1';
      
     update ac60_excel_temp t set t.excel_isvalid='0',t.excel_isop='1',t.excel_opdate=sysdate, t.excel_errormsg='身份证号不能为空' where  t.excel_batch_number =in_excel_batch_number and t.aac002 is null and excel_isvalid='1';
      
     update ac60_excel_temp t set t.excel_isvalid='0',t.excel_isop='1',t.excel_opdate=sysdate, t.excel_errormsg='身份证格式不符合要求' where  t.excel_batch_number =in_excel_batch_number and length(t.aac002)<15  and excel_isvalid='1';
     
     --业务校验 是否已经导入过
      
     --update ac60_excel_temp t set t.excel_isvalid='0',t.excel_isop='1',t.excel_opdate=sysdate, t.excel_errormsg='已经导入,不能重复导入' where  t.excel_batch_number =in_excel_batch_number and exists (select 1 from ac60 c where c.aac002=t.aac002) and excel_isvalid='1';
     
    
     --重复aac002数据删除
     update ac60_excel_temp t
     set t.excel_isvalid  = '0',
        t.excel_isop     = '1',
        t.excel_opdate   = sysdate,
        t.excel_errormsg = '存在同样的身份证数据'
     where rowid not in (select max(rowid)
        from ac60_excel_temp
        where excel_batch_number =in_excel_batch_number and excel_isvalid ='1'
        group by aac002 having count(*)>1
      )
      and aac002  in(
        select aac002 from ac60_excel_temp
        where excel_batch_number =in_excel_batch_number and excel_isvalid ='1'
        group by aac002 having count(*)>1
      );
          
    
     COMMIT;
     
     --循环查询临时表之日期 判断格式是否正确
     for c in (select   
       excel_temp_id,
       adc005,--导入临时表之就业情况--就业时间
       adc012,--导入临时表之公益性岗位或公益专岗安置情况-安置时间(日期格式)
       adc016 ,--导入临时表之培训情况-培训开始时间 
       adc017 ,--导入临时表之培训情况-培训截止时间 
       adc022 --导入临时表之创业情况-创业时间 
       from ac60_excel_temp   where excel_batch_number =in_excel_batch_number and excel_isvalid='1')
     loop
       --就业时间
       begin 
          update ac60_excel_temp t set adc005_date= TO_DATE(substr(replace(replace(c.adc005,'-','/'),'.','/'),0,10),'yyyy-MM-dd') where excel_temp_id=c.excel_temp_id;
       exception
         when others then
         null;  
       end;  
       
       --安置时间(日期格式)
       begin 
          update ac60_excel_temp t set adc012_date= TO_DATE(substr(replace(replace(c.adc012,'-','/'),'.','/'),0,10),'yyyy-MM-dd') where excel_temp_id=c.excel_temp_id;
       exception
         when others then
         null;  
       end;   
       
       --培训开始时间 
       begin 
          update ac60_excel_temp t set adc016_date= TO_DATE(substr(replace(replace(c.adc016,'-','/'),'.','/'),0,10),'yyyy-MM-dd') where excel_temp_id=c.excel_temp_id;
       exception
         when others then
         null;  
       end;   
       
       --培训截止时间 
       begin 
          update ac60_excel_temp t set adc017_date= TO_DATE(substr(replace(replace(c.adc017,'-','/'),'.','/'),0,10),'yyyy-MM-dd') where excel_temp_id=c.excel_temp_id;
       exception
         when others then
         null;  
       end;   
       
       --创业时间
       begin 
          update ac60_excel_temp t set adc022_date= TO_DATE(substr(replace(replace(c.adc022,'-','/'),'.','/'),0,10),'yyyy-MM-dd') where excel_temp_id=c.excel_temp_id;
       exception
         when others then
         null;  
       end;   
     end loop;  

     commit;
    
     --ac60数据插入
     rt_msg:='基本信息增加';
     
     insert into ac60
        (
          aac001   ,--      扶贫系统主表主键（编码规则：uuid）
          aac003   ,--      姓名
          aac002   ,--      身份证号
          aac010   ,--      劳动者户口所在地
          aab299   ,--      劳动者户口所在地区行政区划码
          aac004   ,--      性别代码
          aac005   ,--      民族代码
          aac007   ,--      年龄
          aac033   ,--      健康状况代码
          aac024   ,--      政治面貌代码
          aac011   ,--      学历代码（文化程度代码）
          aae006   ,--      联系电话
          aae015   ,--      劳动技能
          aac029   ,--      户主姓名
          aac030   ,--      是否在校生
          aac031   ,--      主要致贫原因
          aaf011   ,--      经办机构编码
          aae009   ,--      经办机构名
          aae011   ,--      经办人编码
          aae010   ,--      办人姓名
          aae036   ,--      经办日期
          eae052   ,--      审核状态
          aab301   ,--      业务经办行政区划
          aae100   ,--      是否有效(1有效0无效)
          aae013   ,--      备注,
          EXCEL_BATCH_NUMBER --导入临时表之导入批次号
        )
        select
          sys_guid()   ,--      扶贫系统主表主键（编码规则：uuid）
          aac003   ,--      姓名
          aac002   ,--      身份证号
          aac010   ,--      劳动者户口所在地
          null   ,--      劳动者户口所在地区行政区划码
          (select code_value from code_value t where t.code_type='AAC004' and CODE_NAME=aac004)   ,--      性别代码
          (select code_value from code_value t where t.code_type='AAC005' and CODE_NAME=aac005)    ,--      民族代码
          aac007   ,--      年龄
          (select code_value from code_value t where t.code_type='AAC033' and CODE_NAME=aac033)     ,--      健康状况代码
          (select code_value from code_value t where t.code_type='AAC024' and CODE_NAME=aac024)    ,--      政治面貌代码
          (select code_value from code_value t where t.code_type='AAC011' and CODE_NAME=aac011)    ,--      学历代码（文化程度代码）
          aae006   ,--      联系电话
          (select code_value from code_value t where t.code_type='AAE015' and CODE_NAME=aae015)    ,--      劳动技能
          aac029   ,--      户主姓名
          (select code_value from code_value t where t.code_type='YESNO' and CODE_NAME=aac030)    ,--      是否在校生
          aac031   ,--      主要致贫原因
          null     ,--      经办机构编码
          null     ,--      经办机构名
          'sxft_data_imp'   ,--      经办人编码
          'excel数据导入'   ,--      办人姓名
          sysdate   ,--      经办日期
          '1'   ,     --      审核状态
          null   ,--      业务经办行政区划
          '1'   ,--      是否有效(1有效0无效)
          '数据导入'   ,--      备注
          in_excel_batch_number
       from ac60_excel_temp t where t.excel_batch_number=in_excel_batch_number and t.excel_isvalid='1'
       and not exists (select 1 from ac60 a where a.aac002=t.aac002);
       
       
       COMMIT;
       
       --劳动者户口所在地区行政区划码
       update ac60 t set t.aab299=(select groupid from s_group s where s.otherinfo=t.aac010) where t.aab299 is null and t.EXCEL_BATCH_NUMBER=  in_excel_batch_number;
          

       --更新数据状态1/8*70+30
       update s_excel_batch t set t.excel_batch_data_status=round(1/8*70+30),t.excel_batch_end_time=sysdate, t.excel_batch_cost=round((t.excel_batch_end_time-t.excel_batch_begin_time)*24*60*60) where t.excel_batch_number=in_excel_batch_number;
       
       COMMIT;
       
       --AC61 扶贫就业情况表
       
       --先将库中的已经导入的数据删除
       delete from AC61 a where exists (select 1 from ac60_excel_temp t,ac60 f where t.aac002=f.aac002 and  f.aac001=a.aac001 and t.excel_batch_number=in_excel_batch_number and t.excel_isvalid='1' );
       
       COMMIT;
       
       
       rt_msg:='扶贫就业情况增加';
       
       INSERT INTO AC61(
          eec001  ,--     主键(编码规则：uuid)
          aac001  ,--     扶贫系统主表主键（ac60编码规则：uuid）
          adc001  ,--     就业形式
          adc002  ,--     就业地域
          adc003  ,--     就业地
          adc004  ,--     就业工种
          adc005  ,--     就业时间 日期格式
          adc005_string  ,--     就业时间 
          adc006  ,--     是否签订劳动合同或协议
          adc007  ,--     是否参加社会保险
          adc008  ,--     月均工资
          aae010  ,--     经办人姓名
          aaf011  ,--     经办机构编码
          aae009  ,--     经办机构名
          aae011  ,--     经办人编码
          aab301  ,--     业务经办行政区划
          aae100  ,--     是否有效(1有效0无效)
          aae036  ,
          aae013  --      备注
       )
       SELECT 
          sys_guid()  ,--     主键(编码规则：uuid)
          (select aac001 from ac60 t where t.aac002=a.aac002 )  ,--     扶贫系统主表主键（ac60编码规则：uuid）
          (select code_value from code_value t where t.code_type='ADC001' and CODE_NAME=adc001)   ,--     就业形式
          (select code_value from code_value t where t.code_type='ADC002' and CODE_NAME=adc002)  ,--     就业地域
          (select max(code_value) from code_value t where t.code_type='AAB301' and CODE_DESCRIBE=adc003) adc003 ,--     就业地
          (select code_value from code_value t where t.code_type='ACA111' and CODE_NAME=adc004) adc004  ,--     就业工种
          adc005_date  ,--     就业时间 日期格式 ,
          adc005  ,--     就业时间 
          (select code_value from code_value t where t.code_type='YESNO' and CODE_NAME=adc006) adc006  ,--     是否签订劳动合同或协议
          (select code_value from code_value t where t.code_type='YESNO' and CODE_NAME=adc007) adc007  ,--     是否参加社会保险
          decode(sign(length( REGEXP_REPLACE( REGEXP_REPLACE(REGEXP_REPLACE(adc008,'\-[0-9]+',''),'\.[0-9]+',''),'[^\x00-\xff]|[a-z|A-Z]',''))-8),-1,REGEXP_REPLACE( REGEXP_REPLACE(REGEXP_REPLACE(adc008,'\-[0-9]+',''),'\.[0-9]+',''),'[^\x00-\xff]|[a-z|A-Z]','')) adc008 ,--     月均工资
          'excel数据导入'  ,--     经办人姓名
          null  ,--     经办机构编码
          null  ,--     经办机构名
          'sxft_data_imp'  ,--     经办人编码
          null  ,--     业务经办行政区划
          '1'  ,--     是否有效(1有效0无效)
          sysdate,
          in_excel_batch_number  --      备注
       FROM  ac60_excel_temp a where a.excel_batch_number=in_excel_batch_number and a.excel_isvalid='1';   
            
       --更新数据状态2/8*40+80
       update s_excel_batch t set t.excel_batch_data_status=round(2/8*70+30) ,t.excel_batch_end_time=sysdate, t.excel_batch_cost=round((t.excel_batch_end_time-t.excel_batch_begin_time)*24*60*60) where t.excel_batch_number=in_excel_batch_number;
         
       COMMIT;
       
       
       
       
       
       --AC62  公益性岗位或公益专岗安置情况
       
       
       rt_msg:='公益性岗位或公益专岗安置情况增加';
       
       --先将库中的已经导入的数据删除
       delete from AC62 a where exists (select 1 from ac60_excel_temp t,ac60 f where t.aac002=f.aac002 and  f.aac001=a.aac001 and t.excel_batch_number=in_excel_batch_number and t.excel_isvalid='1' );
       
       COMMIT;
       
       
       INSERT INTO AC62 (
          eec001  ,--     主键(编码规则：uuid)
          aac001   ,--     扶贫系统主表主键（ac60编码规则：uuid）
          adc009   ,--   岗位类型
          adc010   ,--  公益性岗位安置地址
          adc011   ,--   公益性岗位安置单位名称
          adc012   ,--   安置时间
          adc012_string   ,--   安置时间
          adc013   ,--   岗位名称
          aae010  ,--     经办人姓名
          aaf011  ,--     经办机构编码
          aae009  ,--     经办机构名
          aae011  ,--     经办人编码
          aab301  ,--     业务经办行政区划
          aae100  ,--     是否有效(1有效0无效)
          aae036,
          aae013  --      备注
       )
       SELECT
          sys_guid()   ,--     主键(编码规则：uuid)
          (select aac001 from ac60 t where t.aac002=a.aac002 )  ,--     扶贫系统主表主键（ac60编码规则：uuid）
          (select code_value from code_value t where t.code_type='ADC009' and CODE_NAME=adc009)  adc009  ,--   岗位类型
          (select max(code_value) from code_value t where t.code_type='AAB301' and CODE_DESCRIBE=adc010),--  公益性岗位安置地址
          adc011   ,--   公益性岗位安置单位名称 ,
          adc012_date,
          adc012 ,--   安置时间,
          adc013   ,--   岗位名称
          'excel数据导入'  ,--     经办人姓名
          null  ,--     经办机构编码
          null  ,--     经办机构名
          'sxft_data_imp'  ,--     经办人编码
          null  ,--     业务经办行政区划
          '1'  ,--     是否有效(1有效0无效)
          sysdate,
          in_excel_batch_number  --      备注
       FROM  ac60_excel_temp a where  a.excel_batch_number=in_excel_batch_number and a.excel_isvalid='1';  
      
       
       --更新数据状态3/7*40+80
       update s_excel_batch t set t.excel_batch_data_status=round(3/8*70+30),t.excel_batch_end_time=sysdate, t.excel_batch_cost=round((t.excel_batch_end_time-t.excel_batch_begin_time)*24*60*60)  where t.excel_batch_number=in_excel_batch_number;
       
       COMMIT;
       
       --AC63  培训情况
       
       rt_msg:='培训情况增加';
        --先将库中的已经导入的数据删除
       delete from AC63 a where exists (select 1 from ac60_excel_temp t,ac60 f where t.aac002=f.aac002 and  f.aac001=a.aac001 and t.excel_batch_number=in_excel_batch_number and t.excel_isvalid='1' );
       
       COMMIT;
       

       INSERT INTO AC63 (
          eec001   ,--     主键(编码规则：uuid)
          aac001   ,--     扶贫系统主表主键（ac60编码规则：uuid）
          adc014   ,--     是否参加就业培训
          adc015   ,--     培训类型
          adc016   ,--     培训开始时间
          adc016_string  ,--     培训开始时间 字符格式
          adc017   ,--     培训截止时间
          adc017_string,   --培训截止时间 字符格式
          adc018   ,--     培训类别
          adc019   ,--     取得证书
          adc020   ,--     培训补贴（元）
          aae010   ,--     经办人姓名
          aaf011   ,--     经办机构编码
          aae009   ,--     经办机构名
          aae011   ,--     经办人编码
          aab301   ,--     业务经办行政区划
          aae100   ,--     是否有效(1有效0无效)
          aae036,
          aae013  --       备注
       )
       SELECT
          sys_guid()   ,--     主键(编码规则：uuid)
          (select aac001 from ac60 t where t.aac002=a.aac002 )  ,--     扶贫系统主表主键（ac60编码规则：uuid）
          (select code_value from code_value t where t.code_type='YESNO' and CODE_NAME=adc014)  adc014 ,--     是否参加就业培训
          (select code_value from code_value t where t.code_type='ADC015' and CODE_NAME=adc015)   adc015,--     培训类型
          adc016_date  ,--     培训开始时间  
          adc016,
          adc017_date  ,--     培训截止时间  ,
          adc017,
          (select code_value from code_value t where t.code_type='ADC018' and CODE_NAME=adc018)  adc018   ,--     培训类别
          (select code_value from code_value t where t.code_type='ADC019' and CODE_NAME=adc019)   adc019 ,--     取得证书
          REGEXP_REPLACE( REGEXP_REPLACE(REGEXP_REPLACE(adc020,'\-[0-9]+',''),'\.[0-9]+',''),'[^\x00-\xff]|[a-z|A-Z]','') adc020 ,--    --     培训补贴（元） 
          'excel数据导入'  ,--     经办人姓名
          null  ,--     经办机构编码
          null  ,--     经办机构名
          'sxft_data_imp'  ,--     经办人编码
          null  ,--     业务经办行政区划
          '1'  ,--     是否有效(1有效0无效)
          sysdate,
          in_excel_batch_number  --      备注
       FROM  ac60_excel_temp a where   a.excel_batch_number=in_excel_batch_number and a.excel_isvalid='1';  
       
       
       --更新数据状态4/8*70+30
       update s_excel_batch t set t.excel_batch_data_status=round(4/8*70+30),t.excel_batch_end_time=sysdate, t.excel_batch_cost=round((t.excel_batch_end_time-t.excel_batch_begin_time)*24*60*60)  where t.excel_batch_number=in_excel_batch_number;
       
       COMMIT;
       
       --AC64  创业情况
       
       
       rt_msg:='创业情况增加';
       
        --先将库中的已经导入的数据删除
       delete from AC64 a where exists (select 1 from ac60_excel_temp t,ac60 f where t.aac002=f.aac002 and  f.aac001=a.aac001 and t.excel_batch_number=in_excel_batch_number and t.excel_isvalid='1' );
       
       COMMIT;
       
 
       INSERT INTO AC64 (
          eec001  ,--    主键(编码规则：uuid)
          aac001   ,--   扶贫系统主表主键（ac60编码规则：uuid）
          adc022,--    创业时间
          adc022_string  ,--    创业时间
          adc023  ,--    是否参加创业培训
          adc024  ,--    创业类型
          adc025  ,--    企业或实体地址
          adc026  ,--    企业或实体名称
          adc027  ,--    产业类别
          adc028  ,--    是否享受小额担保贷款
          adc029  ,--    贷款金额（万元）
          adc030  ,--    吸纳劳动力人数
          adc031  ,--     是否在工商部门注册登记
          aae010  ,--    经办人姓名
          aaf011  ,--    经办机构编码
          aae009  ,--    经办机构名
          aae011  ,--    经办人编码
          aab301  ,--    业务经办行政区划
          aae100  ,--    是否有效(1有效0无效)
          aae036,
          aae013  --     备注
       )
       SELECT
          sys_guid()   ,--     主键(编码规则：uuid)
          (select aac001 from ac60 t where t.aac002=a.aac002 )  ,--     扶贫系统主表主键（ac60编码规则：uuid）
          adc022_date,
          adc022  ,--     --   创业时间
          (select code_value from code_value t where t.code_type='YESNO' and CODE_NAME=adc023)  adc023 ,--   是否参加创业培训
          (select code_value from code_value t where t.code_type='ADC024' and CODE_NAME=adc024)  adc024 ,--   创业类型
          adc025  ,--   企业或实体地址
          adc026  ,--   企业或实体名称
          (select code_value from code_value t where t.code_type='ADC027' and CODE_NAME=adc027)  adc027 ,--   产业类别
          (select code_value from code_value t where t.code_type='YESNO' and CODE_NAME=adc028)  adc028 ,--   是否享受小额担保贷款
          REGEXP_REPLACE( REGEXP_REPLACE(REGEXP_REPLACE(adc029,'\-[0-9]+',''),'\.[0-9]+',''),'[^\x00-\xff]|[a-z|A-Z]','')  adc029 ,--   贷款金额（万元）
          REGEXP_REPLACE( REGEXP_REPLACE(REGEXP_REPLACE(adc030,'\-[0-9]+',''),'\.[0-9]+',''),'[^\x00-\xff]|[a-z|A-Z]','')  adc030 ,--   吸纳劳动力人数  ）
          (select code_value from code_value t where t.code_type='YESNO' and CODE_NAME=adc031) adc031  ,--   是否在工商部门注册登记
          'excel数据导入'  ,--     经办人姓名
          null  ,--     经办机构编码
          null  ,--     经办机构名
          'sxft_data_imp'  ,--     经办人编码
          null  ,--     业务经办行政区划
          '1'  ,--     是否有效(1有效0无效)
          sysdate,
          in_excel_batch_number  --      备注
       FROM  ac60_excel_temp a where   a.excel_batch_number=in_excel_batch_number and a.excel_isvalid='1'; 
       
       
       --更新数据状态5/8*70+30
       update s_excel_batch t set t.excel_batch_data_status=round(5/8*70+30),t.excel_batch_end_time=sysdate, t.excel_batch_cost=round((t.excel_batch_end_time-t.excel_batch_begin_time)*24*60*60)  where t.excel_batch_number=in_excel_batch_number;
       
       COMMIT;
       
       --AC65  未就业情况
       
       rt_msg:='未就业情况增加';
       
        --先将库中的已经导入的数据删除
       delete from AC65 a where exists (select 1 from ac60_excel_temp t,ac60 f where t.aac002=f.aac002 and  f.aac001=a.aac001 and t.excel_batch_number=in_excel_batch_number and t.excel_isvalid='1' );
       
       COMMIT;

       INSERT INTO AC65 (
          eec001  ,--     主键(编码规则：uuid)
          aac001  ,--     扶贫系统主表主键（ac60编码规则：uuid）
          adc032  ,--     是否有就业愿望
          adc033  ,--     就业意向地
          adc034  ,--     期望月薪（元）
          adc035  ,--     就业服务需求
          aae010  ,--     经办人姓名
          aaf011  ,--     经办机构编码
          aae009  ,--     经办机构名
          aae011  ,--     经办人编码
          aab301  ,--     业务经办行政区划
          aae100  ,--     是否有效(1有效0无效)
          aae036  ,
          aae013  --      备注
       )
       SELECT
          sys_guid()   ,--     主键(编码规则：uuid)
          (select aac001 from ac60 t where t.aac002=a.aac002 )  ,--     扶贫系统主表主键（ac60编码规则：uuid）
          (select code_value from code_value t where t.code_type='YESNO' and CODE_NAME=adc032) adc032  ,--   是否有就业愿望
          (select code_value from code_value t where t.code_type='ADC033' and CODE_NAME=adc033) adc033  ,--   就业意向地
          REGEXP_REPLACE( REGEXP_REPLACE(REGEXP_REPLACE(adc034,'\-[0-9]+',''),'\.[0-9]+',''),'[^\x00-\xff]|[a-z|A-Z]','')  adc034 ,--   期望月薪（元）
           (select code_value from code_value t where t.code_type='ADC035' and CODE_NAME=adc035)  adc035  ,--   就业服务需求
          'excel数据导入'  ,--     经办人姓名
          null  ,--     经办机构编码
          null  ,--     经办机构名
          'sxft_data_imp'  ,--     经办人编码
          null  ,--     业务经办行政区划
          '1'  ,--     是否有效(1有效0无效)
          sysdate,
          in_excel_batch_number  --      备注
       FROM  ac60_excel_temp a where   a.excel_batch_number=in_excel_batch_number and a.excel_isvalid='1';
       
       
        --更新数据状态6/8*70+30
       update s_excel_batch t set t.excel_batch_data_status=round(6/8*70+30),t.excel_batch_end_time=sysdate, t.excel_batch_cost=round((t.excel_batch_end_time-t.excel_batch_begin_time)*24*60*60)  where t.excel_batch_number=in_excel_batch_number;

       COMMIT;
       
       --AC66  提供就业服务情况
       
       rt_msg:='提供就业服务情况增加';
       
        --先将库中的已经导入的数据删除
       delete from AC66 a where exists (select 1 from ac60_excel_temp t,ac60 f where t.aac002=f.aac002 and  f.aac001=a.aac001 and t.excel_batch_number=in_excel_batch_number and t.excel_isvalid='1' );
       
       COMMIT;

       INSERT INTO AC66 (
          eec001   ,--     主键(编码规则：uuid)
          aac001   ,--     扶贫系统主表主键（ac60编码规则：uuid）
          adc036   ,--   提供就业政策咨询次数(次)
          adc037   ,--   提供就业信息次数（次）
          adc038   ,--   提供职业指导与介绍次数（次）
          adc039   ,--   提供培训次数（次）
          adc040   ,--   提供创业服务次数(次)
          aae010  ,--     经办人姓名
          aaf011  ,--     经办机构编码
          aae009  ,--     经办机构名
          aae011  ,--     经办人编码
          aab301  ,--     业务经办行政区划
          aae100  ,--     是否有效(1有效0无效)
          aae036,
          aae013  --      备注
       )
       SELECT
          sys_guid()   ,--     主键(编码规则：uuid)
         (select aac001 from ac60 t where t.aac002=a.aac002 )  ,--     扶贫系统主表主键（ac60编码规则：uuid）
          REGEXP_REPLACE( REGEXP_REPLACE(REGEXP_REPLACE(adc036,'\-[0-9]+',''),'\.[0-9]+',''),'[^\x00-\xff]|[a-z|A-Z]','') adc036 ,--  提供就业政策咨询次数(次)
          REGEXP_REPLACE( REGEXP_REPLACE(REGEXP_REPLACE(adc037,'\-[0-9]+',''),'\.[0-9]+',''),'[^\x00-\xff]|[a-z|A-Z]','') adc037 ,--  提供就业信息次数（次）
          REGEXP_REPLACE( REGEXP_REPLACE(REGEXP_REPLACE(adc038,'\-[0-9]+',''),'\.[0-9]+',''),'[^\x00-\xff]|[a-z|A-Z]','') adc038 ,--  提供职业指导与介绍次数（次）
          REGEXP_REPLACE( REGEXP_REPLACE(REGEXP_REPLACE(adc039,'\-[0-9]+',''),'\.[0-9]+',''),'[^\x00-\xff]|[a-z|A-Z]','') adc039 ,--  提供培训次数（次）
          REGEXP_REPLACE( REGEXP_REPLACE(REGEXP_REPLACE(adc040,'\-[0-9]+',''),'\.[0-9]+',''),'[^\x00-\xff]|[a-z|A-Z]','') adc040 ,--  提供创业服务次数(次)
          'excel数据导入'  ,--     经办人姓名
          null  ,--     经办机构编码
          null  ,--     经办机构名
          'sxft_data_imp'  ,--     经办人编码
          null  ,--     业务经办行政区划
          '1'  ,--     是否有效(1有效0无效)
          sysdate,
          in_excel_batch_number  --      备注
       FROM  ac60_excel_temp a where   a.excel_batch_number=in_excel_batch_number and a.excel_isvalid='1'; 
       
       --更新数据状态7/8*70+30
       update s_excel_batch t set t.excel_batch_data_status=round(7/8*70+30),t.excel_batch_end_time=sysdate, t.excel_batch_cost=round((t.excel_batch_end_time-t.excel_batch_begin_time)*24*60*60)  where t.excel_batch_number=in_excel_batch_number;
       
       COMMIT; 
       
       --AC67  政策落实情况
       
       rt_msg:='政策落实情况增加';
       
        --先将库中的已经导入的数据删除
       delete from AC67 a where exists (select 1 from ac60_excel_temp t,ac60 f where t.aac002=f.aac002 and  f.aac001=a.aac001 and t.excel_batch_number=in_excel_batch_number and t.excel_isvalid='1' );
       
       COMMIT;
       
       INSERT INTO AC67 (
          eec001  ,--     主键(编码规则：uuid)
          aac001  ,--     扶贫系统主表主键（ac60编码规则：uuid）
          adc041  ,--   是否享受职业介绍补贴
          adc042  ,--   是否享受社会保险补贴
          adc043  ,--   是否享受岗位补贴
          adc044  ,--  是否享受其他政策扶持
          aae010  ,--     经办人姓名
          aaf011  ,--     经办机构编码
          aae009  ,--     经办机构名
          aae011  ,--     经办人编码
          aab301  ,--     业务经办行政区划
          aae100  ,--     是否有效(1有效0无效)
          aae036,
          aae013  --      备注
       )
       SELECT
          sys_guid()   ,--     主键(编码规则：uuid)
          (select aac001 from ac60 t where t.aac002=a.aac002 )  ,--     扶贫系统主表主键（ac60编码规则：uuid）
          (select code_value from code_value t where t.code_type='YESNO' and CODE_NAME=adc041) adc041 ,--   是否享受职业介绍补贴
          (select code_value from code_value t where t.code_type='YESNO' and CODE_NAME=adc042) adc042 ,--   是否享受社会保险补贴
          (select code_value from code_value t where t.code_type='YESNO' and CODE_NAME=adc043) adc043 ,--   是否享受岗位补贴
          (select code_value from code_value t where t.code_type='YESNO' and CODE_NAME=adc044) adc044 ,--  是否享受其他政策扶持
          'excel数据导入'  ,--     经办人姓名
          null  ,--     经办机构编码
          null  ,--     经办机构名
          'sxft_data_imp'  ,--     经办人编码
          null  ,--     业务经办行政区划
          '1'  ,--     是否有效(1有效0无效)
          sysdate,
          in_excel_batch_number  --      备注
       FROM  ac60_excel_temp a where   a.excel_batch_number=in_excel_batch_number and a.excel_isvalid='1'; 
       
       COMMIT;
       
       --更新临时表处理状态 
       UPDATE ac60_excel_temp T SET T.EXCEL_ERRORMSG='成功', T.EXCEL_OPDATE=SYSDATE,t.excel_isop='1' WHERE T.EXCEL_ISVALID='1' and t.excel_batch_number=in_excel_batch_number ;
       
       --更新批次表数据状态
       UPDATE S_EXCEL_BATCH T SET  T.EXCEL_BATCH_STATUS='3',T.EXCEL_BATCH_ERROR_COUNT=(SELECT count(*) from ac60_excel_temp c where c.excel_batch_number=t.excel_batch_number and c.excel_isvalid='0' ),T.EXCEL_BATCH_TOTAL_COUNT=(SELECT count(*) from ac60_excel_temp c where c.excel_batch_number=t.excel_batch_number  ) where  t.excel_batch_number=in_excel_batch_number ;
       
       
       --更新数据状态8/8*70+30
       update s_excel_batch t set t.excel_batch_data_status=round(8/8*70+30),t.excel_batch_end_time=sysdate, t.excel_batch_cost=round((t.excel_batch_end_time-t.excel_batch_begin_time)*24*60*60) where t.excel_batch_number=in_excel_batch_number;
       
       rt_code:=RT_SUCCESS_CODE;
       
       update S_EXCEL_BATCH t set  t.excel_batch_rt_code=RT_SUCCESS_CODE where excel_batch_number=in_excel_batch_number;
       
       COMMIT;

    Exception
       when others THEN
       rt_code:=RT_ERROR_CODE;
       rt_msg:=rt_msg||sqlerrm;
       update S_EXCEL_BATCH t set T.EXCEL_BATCH_STATUS='4', t.excel_batch_rt_code=rt_code ,t.excel_batch_rt_msg=rt_msg where excel_batch_number=in_excel_batch_number;
       COMMIT;
    END;
end pkg_ac60_excel_data_imp;
/
