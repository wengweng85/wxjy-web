-----------------------------------------------
-- Export file for user SXJYFP@ORCL          --
-- Created by wengsh on 2017/11/29, 15:49:55 --
-----------------------------------------------

set define off
spool excel_import_about.log

prompt
prompt Creating table AC60
prompt ===================
prompt
create table AC60
(
  aac001             VARCHAR2(36) not null,
  aac003             VARCHAR2(50) not null,
  aac002             VARCHAR2(20) not null,
  aac010             VARCHAR2(100) not null,
  aab299             VARCHAR2(20),
  aac004             VARCHAR2(20) not null,
  aac005             VARCHAR2(20),
  aac006             DATE,
  aac007             NUMBER(3),
  aac033             VARCHAR2(20),
  aac017             VARCHAR2(20),
  aac024             VARCHAR2(20),
  aac011             VARCHAR2(20),
  aae006             VARCHAR2(20),
  aac067             VARCHAR2(20),
  aae015             VARCHAR2(50),
  aac029             VARCHAR2(100),
  aac030             VARCHAR2(20),
  aac031             VARCHAR2(20),
  aaf011             VARCHAR2(100),
  aae009             VARCHAR2(100),
  aae011             VARCHAR2(50),
  aae010             VARCHAR2(80),
  aae036             DATE,
  eae052             VARCHAR2(20),
  aae200             VARCHAR2(50),
  aae199             VARCHAR2(80),
  aae202             DATE,
  aae201             VARCHAR2(100),
  aae198             VARCHAR2(100),
  aae203             VARCHAR2(100),
  aae132             VARCHAR2(100),
  aae133             VARCHAR2(80),
  aae134             VARCHAR2(50),
  aae135             VARCHAR2(100),
  aae102             DATE,
  aab301             VARCHAR2(12),
  aae100             VARCHAR2(20) not null,
  aae013             VARCHAR2(200),
  excel_batch_number VARCHAR2(36)
)
;
comment on table AC60
  is '陕西扶贫信息管理系统主表';
comment on column AC60.aac001
  is '扶贫系统主表主键（编码规则：UUID）';
comment on column AC60.aac003
  is '姓名';
comment on column AC60.aac002
  is '身份证号';
comment on column AC60.aac010
  is '劳动者户口所在地';
comment on column AC60.aab299
  is '劳动者户口所在地区行政区划码';
comment on column AC60.aac004
  is '性别代码';
comment on column AC60.aac005
  is '民族代码';
comment on column AC60.aac006
  is '出生日期';
comment on column AC60.aac007
  is '年龄';
comment on column AC60.aac033
  is '健康状况代码';
comment on column AC60.aac017
  is '婚姻状况代码';
comment on column AC60.aac024
  is '政治面貌代码';
comment on column AC60.aac011
  is '学历代码（文化程度代码）';
comment on column AC60.aae006
  is '联系电话';
comment on column AC60.aac067
  is '移动电话';
comment on column AC60.aae015
  is '劳动技能';
comment on column AC60.aac029
  is '户主姓名';
comment on column AC60.aac030
  is '是否在校生';
comment on column AC60.aac031
  is '主要致贫原因';
comment on column AC60.aaf011
  is '经办机构编码';
comment on column AC60.aae009
  is '经办机构名';
comment on column AC60.aae011
  is '经办人编码';
comment on column AC60.aae010
  is '经办人姓名';
comment on column AC60.aae036
  is '经办日期';
comment on column AC60.eae052
  is '审核状态';
comment on column AC60.aae200
  is '审核人编码';
comment on column AC60.aae199
  is '审核人姓名';
comment on column AC60.aae202
  is '审核时间';
comment on column AC60.aae201
  is '审核机构编码';
comment on column AC60.aae198
  is '审核机构名';
comment on column AC60.aae203
  is '审核原因';
comment on column AC60.aae132
  is '修改机构名';
comment on column AC60.aae133
  is '修改人姓名';
comment on column AC60.aae134
  is '修改人编码';
comment on column AC60.aae135
  is '修改机构编码';
comment on column AC60.aae102
  is '修改时间';
comment on column AC60.aab301
  is '业务经办行政区划';
comment on column AC60.aae100
  is '是否有效(1有效0无效)';
comment on column AC60.aae013
  is '备注';
comment on column AC60.excel_batch_number
  is '导入临时表之导入批次号';
create index IDX_AC60_AAC002 on AC60 (AAC002);
create index IDX_AC60_BATCH_NUMBER on AC60 (EXCEL_BATCH_NUMBER);
alter table AC60
  add constraint PK_AC60 primary key (AAC001);

prompt
prompt Creating table AC60_EXCEL_TEMP
prompt ==============================
prompt
create table AC60_EXCEL_TEMP
(
  excel_temp_id      VARCHAR2(36) not null,
  excel_batch_number VARCHAR2(36) not null,
  aac003             VARCHAR2(50) not null,
  aac002             VARCHAR2(20) not null,
  aac010             VARCHAR2(200),
  aac004             VARCHAR2(20),
  aac005             VARCHAR2(20),
  aac007             VARCHAR2(100),
  aac024             VARCHAR2(100),
  aac011             VARCHAR2(100),
  aac033             VARCHAR2(100),
  aae015             VARCHAR2(100),
  aac029             VARCHAR2(100),
  adc001             VARCHAR2(100),
  aae006             VARCHAR2(100),
  aac030             VARCHAR2(100),
  aac031             VARCHAR2(100),
  adc002             VARCHAR2(100),
  adc003             VARCHAR2(100),
  adc004             VARCHAR2(100),
  adc005             VARCHAR2(200),
  adc006             VARCHAR2(100),
  adc007             VARCHAR2(100),
  adc008             VARCHAR2(100),
  adc009             VARCHAR2(100),
  adc010             VARCHAR2(100),
  adc011             VARCHAR2(200),
  adc012             VARCHAR2(100),
  adc013             VARCHAR2(100),
  adc014             VARCHAR2(100),
  adc015             VARCHAR2(100),
  adc016             VARCHAR2(100),
  adc017             VARCHAR2(100),
  adc018             VARCHAR2(100),
  adc019             VARCHAR2(100),
  adc020             VARCHAR2(100),
  adc021             VARCHAR2(100),
  adc022             VARCHAR2(100),
  adc023             VARCHAR2(100),
  adc024             VARCHAR2(100),
  adc025             VARCHAR2(100),
  adc026             VARCHAR2(100),
  adc027             VARCHAR2(100),
  adc028             VARCHAR2(100),
  adc029             VARCHAR2(100),
  adc030             VARCHAR2(100),
  adc031             VARCHAR2(100),
  adc032             VARCHAR2(100),
  adc033             VARCHAR2(100),
  adc034             VARCHAR2(100),
  adc035             VARCHAR2(100),
  adc036             VARCHAR2(100),
  adc037             VARCHAR2(100),
  adc038             VARCHAR2(100),
  adc039             VARCHAR2(100),
  adc040             VARCHAR2(100),
  adc041             VARCHAR2(100),
  adc042             VARCHAR2(100),
  adc043             VARCHAR2(100),
  adc044             VARCHAR2(100),
  excel_isvalid      VARCHAR2(36) not null,
  excel_rownum       NUMBER(10) not null,
  excel_impdate      DATE not null,
  excel_errormsg     VARCHAR2(36),
  excel_isop         VARCHAR2(36),
  excel_opdate       DATE,
  adc005_date        DATE,
  adc016_date        DATE,
  adc017_date        DATE,
  adc022_date        DATE,
  adc012_date        DATE
)
;
comment on table AC60_EXCEL_TEMP
  is '陕西扶贫信息管理数据导入临时表';
comment on column AC60_EXCEL_TEMP.excel_temp_id
  is '导入临时表之临时表主键';
comment on column AC60_EXCEL_TEMP.excel_batch_number
  is '导入临时表之导入批次号';
comment on column AC60_EXCEL_TEMP.aac003
  is '导入临时表之基本信息-姓名';
comment on column AC60_EXCEL_TEMP.aac002
  is '导入临时表之基本信息-身份证号';
comment on column AC60_EXCEL_TEMP.aac010
  is '导入临时表之基本信息-劳动者户口所在地';
comment on column AC60_EXCEL_TEMP.aac004
  is '导入临时表之基本信息-性别';
comment on column AC60_EXCEL_TEMP.aac005
  is '导入临时表之基本信息-民族';
comment on column AC60_EXCEL_TEMP.aac007
  is '导入临时表之基本信息-年龄';
comment on column AC60_EXCEL_TEMP.aac024
  is '导入临时表之基本信息-政治面貌';
comment on column AC60_EXCEL_TEMP.aac011
  is '导入临时表之基本信息-学历代码';
comment on column AC60_EXCEL_TEMP.aac033
  is '导入临时表之基本信息-健康状况';
comment on column AC60_EXCEL_TEMP.aae015
  is '导入临时表之基本信息-劳动技能';
comment on column AC60_EXCEL_TEMP.aac029
  is '导入临时表之基本信息-户主姓名';
comment on column AC60_EXCEL_TEMP.adc001
  is '导入临时表之就业情况-就业新式';
comment on column AC60_EXCEL_TEMP.aae006
  is '导入临时表之基本信息-联系电话';
comment on column AC60_EXCEL_TEMP.aac030
  is '导入临时表之基本信息-是否在校生';
comment on column AC60_EXCEL_TEMP.aac031
  is '导入临时表之基本信息-主要致贫原因';
comment on column AC60_EXCEL_TEMP.adc002
  is '导入临时表之就业情况-就业地域';
comment on column AC60_EXCEL_TEMP.adc003
  is '导入临时表之就业情况-就业地';
comment on column AC60_EXCEL_TEMP.adc004
  is '导入临时表之就业情况-就业工种';
comment on column AC60_EXCEL_TEMP.adc005
  is '导入临时表之就业情况--就业时间';
comment on column AC60_EXCEL_TEMP.adc006
  is '导入临时表之就业情况-是否签订劳动合同或协议';
comment on column AC60_EXCEL_TEMP.adc007
  is '导入临时表之就业情况-是否参加社会保险';
comment on column AC60_EXCEL_TEMP.adc008
  is '导入临时表之就业情况-月均工资';
comment on column AC60_EXCEL_TEMP.adc009
  is '导入临时表之公益性岗位或公益专岗安置情况-岗位类型';
comment on column AC60_EXCEL_TEMP.adc010
  is '导入临时表之公益性岗位或公益专岗安置情况-公益性岗位安置地址';
comment on column AC60_EXCEL_TEMP.adc011
  is '导入临时表之公益性岗位或公益专岗安置情况-公益性岗位安置单位名称';
comment on column AC60_EXCEL_TEMP.adc012
  is '导入临时表之公益性岗位或公益专岗安置情况-安置时间';
comment on column AC60_EXCEL_TEMP.adc013
  is '导入临时表之公益性岗位或公益专岗安置情况-岗位名称';
comment on column AC60_EXCEL_TEMP.adc014
  is '导入临时表之培训情况-是否参加就业培训';
comment on column AC60_EXCEL_TEMP.adc015
  is '导入临时表之培训情况-培训类型';
comment on column AC60_EXCEL_TEMP.adc016
  is '导入临时表之培训情况-培训开始时间';
comment on column AC60_EXCEL_TEMP.adc017
  is '导入临时表之培训情况-培训截止时间';
comment on column AC60_EXCEL_TEMP.adc018
  is '导入临时表之培训情况-培训类别';
comment on column AC60_EXCEL_TEMP.adc019
  is '导入临时表之培训情况-取得证书';
comment on column AC60_EXCEL_TEMP.adc020
  is '导入临时表之培训情况-培训补贴（元）';
comment on column AC60_EXCEL_TEMP.adc021
  is '导入临时表之创业情况-是否就业';
comment on column AC60_EXCEL_TEMP.adc022
  is '导入临时表之创业情况-创业时间';
comment on column AC60_EXCEL_TEMP.adc023
  is '导入临时表之创业情况-是否参加创业培训';
comment on column AC60_EXCEL_TEMP.adc024
  is '导入临时表之创业情况-创业类型';
comment on column AC60_EXCEL_TEMP.adc025
  is '导入临时表之创业情况-企业或实体地址';
comment on column AC60_EXCEL_TEMP.adc026
  is '导入临时表之创业情况-企业或实体名称';
comment on column AC60_EXCEL_TEMP.adc027
  is '导入临时表之创业情况-产业类别';
comment on column AC60_EXCEL_TEMP.adc028
  is '导入临时表之创业情况-是否享受小额担保贷款';
comment on column AC60_EXCEL_TEMP.adc029
  is '导入临时表之创业情况-贷款金额（万元）';
comment on column AC60_EXCEL_TEMP.adc030
  is '导入临时表之创业情况-吸纳劳动力人数';
comment on column AC60_EXCEL_TEMP.adc031
  is '导入临时表之创业情况-是否在工商部门注册登记';
comment on column AC60_EXCEL_TEMP.adc032
  is '导入临时表之未就业情况-是否有就业愿望';
comment on column AC60_EXCEL_TEMP.adc033
  is '导入临时表之未就业情况-就业意向地';
comment on column AC60_EXCEL_TEMP.adc034
  is '导入临时表之未就业情况-期望月薪（元）';
comment on column AC60_EXCEL_TEMP.adc035
  is '导入临时表之未就业情况-就业服务需求';
comment on column AC60_EXCEL_TEMP.adc036
  is '导入临时表之提供就业服务情况-提供就业政策咨询次数(次)';
comment on column AC60_EXCEL_TEMP.adc037
  is '导入临时表之提供就业服务情况-提供就业信息次数（次）';
comment on column AC60_EXCEL_TEMP.adc038
  is '导入临时表之提供就业服务情况-提供职业指导与介绍次数（次）';
comment on column AC60_EXCEL_TEMP.adc039
  is '导入临时表之提供就业服务情况-提供培训次数（次）';
comment on column AC60_EXCEL_TEMP.adc040
  is '导入临时表之提供就业服务情况-提供创业服务次数(次)';
comment on column AC60_EXCEL_TEMP.adc041
  is '导入临时表之政策落实情况-是否享受职业介绍补贴';
comment on column AC60_EXCEL_TEMP.adc042
  is '导入临时表之政策落实情况-是否享受社会保险补贴';
comment on column AC60_EXCEL_TEMP.adc043
  is '导入临时表之政策落实情况-是否享受岗位补贴';
comment on column AC60_EXCEL_TEMP.adc044
  is '导入临时表之政策落实情况-是否享受其他政策扶持';
comment on column AC60_EXCEL_TEMP.excel_isvalid
  is '导入临时表之导入数据是否正确';
comment on column AC60_EXCEL_TEMP.excel_rownum
  is '导入临时表之行数';
comment on column AC60_EXCEL_TEMP.excel_impdate
  is '导入临时表之导入日期';
comment on column AC60_EXCEL_TEMP.excel_errormsg
  is '导入临时表之错误数据原因';
comment on column AC60_EXCEL_TEMP.excel_isop
  is '导入临时表之是否已经处理';
comment on column AC60_EXCEL_TEMP.excel_opdate
  is '导入临时表之处理日期';
comment on column AC60_EXCEL_TEMP.adc005_date
  is '导入临时表之就业情况--就业时间(日期格式)';
comment on column AC60_EXCEL_TEMP.adc016_date
  is '导入临时表之培训情况-培训开始时间(日期格式)';
comment on column AC60_EXCEL_TEMP.adc017_date
  is '导入临时表之培训情况-培训截止时间(日期格式)';
comment on column AC60_EXCEL_TEMP.adc022_date
  is '导入临时表之创业情况-创业时间(日期格式)';
comment on column AC60_EXCEL_TEMP.adc012_date
  is '导入临时表之公益性岗位或公益专岗安置情况-安置时间(日期格式)';
create index IDX_AC60_EXCEL_TEMP on AC60_EXCEL_TEMP (EXCEL_BATCH_NUMBER);
create index IDX_AC60_EXCEL_TEMP_AAC002 on AC60_EXCEL_TEMP (AAC002);
alter table AC60_EXCEL_TEMP
  add constraint PK_AC60_EXCEL_TEMP primary key (EXCEL_TEMP_ID);

prompt
prompt Creating table AC61
prompt ===================
prompt
create table AC61
(
  eec001        VARCHAR2(36) not null,
  aac001        VARCHAR2(36) not null,
  adc001        VARCHAR2(20),
  adc002        VARCHAR2(20),
  adc003        VARCHAR2(100),
  adc004        VARCHAR2(100),
  adc005        DATE,
  adc006        VARCHAR2(50),
  adc007        VARCHAR2(20),
  adc008        NUMBER(10,2),
  aaf011        VARCHAR2(100),
  aae009        VARCHAR2(100),
  aae011        VARCHAR2(50) not null,
  aae010        VARCHAR2(80) not null,
  aae036        DATE not null,
  aae132        VARCHAR2(100),
  aae133        VARCHAR2(80),
  aae134        VARCHAR2(50),
  aae135        VARCHAR2(100),
  aae102        DATE,
  aab301        VARCHAR2(12),
  aae100        VARCHAR2(20) not null,
  aae013        VARCHAR2(200),
  adc005_string VARCHAR2(200)
)
;
comment on table AC61
  is '扶贫就业情况表';
comment on column AC61.eec001
  is '主键(编码规则：UUID)';
comment on column AC61.aac001
  is '扶贫系统主表主键（AC60编码规则：UUID）';
comment on column AC61.adc001
  is '就业形式';
comment on column AC61.adc002
  is '就业地域';
comment on column AC61.adc003
  is '就业地';
comment on column AC61.adc004
  is '就业工种';
comment on column AC61.adc005
  is '就业时间';
comment on column AC61.adc006
  is '是否签订劳动合同或协议';
comment on column AC61.adc007
  is '是否参加社会保险';
comment on column AC61.adc008
  is '月均工资';
comment on column AC61.aaf011
  is '经办机构编码';
comment on column AC61.aae009
  is '经办机构名';
comment on column AC61.aae011
  is '经办人编码';
comment on column AC61.aae010
  is '经办人姓名';
comment on column AC61.aae036
  is '经办日期';
comment on column AC61.aae132
  is '修改机构名';
comment on column AC61.aae133
  is '修改人姓名';
comment on column AC61.aae134
  is '修改人编码';
comment on column AC61.aae135
  is '修改机构编码';
comment on column AC61.aae102
  is '修改时间';
comment on column AC61.aab301
  is '业务经办行政区划';
comment on column AC61.aae100
  is '是否有效(1有效0无效)';
comment on column AC61.aae013
  is '备注';
comment on column AC61.adc005_string
  is '就业时间临时字段';
create index IDX_AC61_AAC001 on AC61 (AAC001);
alter table AC61
  add constraint PK_AC61 primary key (EEC001);

prompt
prompt Creating table AC62
prompt ===================
prompt
create table AC62
(
  eec001        VARCHAR2(36) not null,
  aac001        VARCHAR2(36) not null,
  adc009        VARCHAR2(20),
  adc010        VARCHAR2(100),
  adc011        VARCHAR2(200),
  adc012        DATE,
  adc013        VARCHAR2(100),
  aaf011        VARCHAR2(100),
  aae009        VARCHAR2(100),
  aae011        VARCHAR2(50) not null,
  aae010        VARCHAR2(80) not null,
  aae036        DATE not null,
  aae132        VARCHAR2(100),
  aae133        VARCHAR2(80),
  aae134        VARCHAR2(50),
  aae135        VARCHAR2(100),
  aae102        DATE,
  aab301        VARCHAR2(12),
  aae100        VARCHAR2(20) not null,
  aae013        VARCHAR2(200),
  adc012_string VARCHAR2(100)
)
;
comment on table AC62
  is '公益性岗位或公益专岗安置情况';
comment on column AC62.eec001
  is '主键(编码规则：UUID)';
comment on column AC62.aac001
  is '扶贫系统主表主键（AC60编码规则：UUID）';
comment on column AC62.adc009
  is '岗位类型';
comment on column AC62.adc010
  is '公益性岗位安置地址';
comment on column AC62.adc011
  is '公益性岗位安置单位名称';
comment on column AC62.adc012
  is '安置时间';
comment on column AC62.adc013
  is '岗位名称';
comment on column AC62.aaf011
  is '经办机构编码';
comment on column AC62.aae009
  is '经办机构名';
comment on column AC62.aae011
  is '经办人编码';
comment on column AC62.aae010
  is '经办人姓名';
comment on column AC62.aae036
  is '经办日期';
comment on column AC62.aae132
  is '修改机构名';
comment on column AC62.aae133
  is '修改人姓名';
comment on column AC62.aae134
  is '修改人编码';
comment on column AC62.aae135
  is '修改机构编码';
comment on column AC62.aae102
  is '修改时间';
comment on column AC62.aab301
  is '业务经办行政区划';
comment on column AC62.aae100
  is '是否有效(1有效0无效)';
comment on column AC62.aae013
  is '备注';
comment on column AC62.adc012_string
  is '安置时间临时字段';
create index IDX_AC62_AAC001 on AC62 (AAC001);
alter table AC62
  add constraint PK_AC62 primary key (EEC001);

prompt
prompt Creating table AC63
prompt ===================
prompt
create table AC63
(
  eec001        VARCHAR2(36) not null,
  aac001        VARCHAR2(36) not null,
  adc014        VARCHAR2(20),
  adc015        VARCHAR2(20),
  adc016        DATE,
  adc017        DATE,
  adc018        VARCHAR2(20),
  adc019        VARCHAR2(20),
  adc020        NUMBER(10,2),
  adc021        VARCHAR2(20),
  aaf011        VARCHAR2(100),
  aae009        VARCHAR2(100),
  aae011        VARCHAR2(50) not null,
  aae010        VARCHAR2(80) not null,
  aae036        DATE not null,
  aae132        VARCHAR2(100),
  aae133        VARCHAR2(80),
  aae134        VARCHAR2(50),
  aae135        VARCHAR2(100),
  aae102        DATE,
  aab301        VARCHAR2(12),
  aae100        VARCHAR2(20) not null,
  aae013        VARCHAR2(200),
  adc016_string VARCHAR2(100),
  adc017_string VARCHAR2(100)
)
;
comment on table AC63
  is ' 培训情况';
comment on column AC63.eec001
  is '主键(编码规则：UUID)';
comment on column AC63.aac001
  is '扶贫系统主表主键（AC60编码规则：UUID）';
comment on column AC63.adc014
  is '是否参加就业培训';
comment on column AC63.adc015
  is '培训类型';
comment on column AC63.adc016
  is '培训开始时间';
comment on column AC63.adc017
  is '培训截止时间';
comment on column AC63.adc018
  is '培训类别';
comment on column AC63.adc019
  is '取得证书';
comment on column AC63.adc020
  is '培训补贴（元）';
comment on column AC63.adc021
  is '是否就业';
comment on column AC63.aaf011
  is '经办机构编码';
comment on column AC63.aae009
  is '经办机构名';
comment on column AC63.aae011
  is '经办人编码';
comment on column AC63.aae010
  is '经办人姓名';
comment on column AC63.aae036
  is '经办日期';
comment on column AC63.aae132
  is '修改机构名';
comment on column AC63.aae133
  is '修改人姓名';
comment on column AC63.aae134
  is '修改人编码';
comment on column AC63.aae135
  is '修改机构编码';
comment on column AC63.aae102
  is '修改时间';
comment on column AC63.aab301
  is '业务经办行政区划';
comment on column AC63.aae100
  is '是否有效(1有效0无效)';
comment on column AC63.aae013
  is '备注';
comment on column AC63.adc016_string
  is '培训开始时间临时字段';
comment on column AC63.adc017_string
  is '培训截止时间临时字段';
create index IDX_AC63_AAC001 on AC63 (AAC001);
alter table AC63
  add constraint PK_AC63 primary key (EEC001);

prompt
prompt Creating table AC64
prompt ===================
prompt
create table AC64
(
  eec001        VARCHAR2(36) not null,
  aac001        VARCHAR2(36) not null,
  adc022        DATE,
  adc023        VARCHAR2(20),
  adc024        VARCHAR2(20),
  adc025        VARCHAR2(100),
  adc026        VARCHAR2(100),
  adc027        VARCHAR2(20),
  adc028        VARCHAR2(20),
  adc029        NUMBER(10,2),
  adc030        NUMBER(10),
  adc031        VARCHAR2(100),
  aaf011        VARCHAR2(100),
  aae009        VARCHAR2(100),
  aae011        VARCHAR2(50) not null,
  aae010        VARCHAR2(80) not null,
  aae036        DATE not null,
  aae132        VARCHAR2(100),
  aae133        VARCHAR2(80),
  aae134        VARCHAR2(50),
  aae135        VARCHAR2(100),
  aae102        DATE,
  aab301        VARCHAR2(12),
  aae100        VARCHAR2(20) not null,
  aae013        VARCHAR2(200),
  adc022_string VARCHAR2(100)
)
;
comment on table AC64
  is '创业情况';
comment on column AC64.eec001
  is '主键(编码规则：UUID)';
comment on column AC64.aac001
  is '扶贫系统主表主键（AC60编码规则：UUID）';
comment on column AC64.adc022
  is '创业时间';
comment on column AC64.adc023
  is '是否参加创业培训';
comment on column AC64.adc024
  is '创业类型';
comment on column AC64.adc025
  is '企业或实体地址';
comment on column AC64.adc026
  is '企业或实体名称';
comment on column AC64.adc027
  is '产业类别';
comment on column AC64.adc028
  is '是否享受小额担保贷款';
comment on column AC64.adc029
  is '贷款金额（万元）';
comment on column AC64.adc030
  is '吸纳劳动力人数';
comment on column AC64.adc031
  is '是否在工商部门注册登记';
comment on column AC64.aaf011
  is '经办机构编码';
comment on column AC64.aae009
  is '经办机构名';
comment on column AC64.aae011
  is '经办人编码';
comment on column AC64.aae010
  is '经办人姓名';
comment on column AC64.aae036
  is '经办日期';
comment on column AC64.aae132
  is '修改机构名';
comment on column AC64.aae133
  is '修改人姓名';
comment on column AC64.aae134
  is '修改人编码';
comment on column AC64.aae135
  is '修改机构编码';
comment on column AC64.aae102
  is '修改时间';
comment on column AC64.aab301
  is '业务经办行政区划';
comment on column AC64.aae100
  is '是否有效(1有效0无效)';
comment on column AC64.aae013
  is '备注';
comment on column AC64.adc022_string
  is '创业时间临时字段';
create index IDX_AC64_AAC001 on AC64 (AAC001);
alter table AC64
  add constraint PK_AC64 primary key (EEC001);

prompt
prompt Creating table AC65
prompt ===================
prompt
create table AC65
(
  eec001 VARCHAR2(36) not null,
  aac001 VARCHAR2(36) not null,
  adc032 VARCHAR2(20),
  adc033 VARCHAR2(20),
  adc034 NUMBER(10,2),
  adc035 VARCHAR2(20),
  aaf011 VARCHAR2(100),
  aae009 VARCHAR2(100),
  aae011 VARCHAR2(50) not null,
  aae010 VARCHAR2(80) not null,
  aae036 DATE not null,
  aae132 VARCHAR2(100),
  aae133 VARCHAR2(80),
  aae134 VARCHAR2(50),
  aae135 VARCHAR2(100),
  aae102 DATE,
  aab301 VARCHAR2(12),
  aae100 VARCHAR2(20) not null,
  aae013 VARCHAR2(200)
)
;
comment on table AC65
  is '未就业情况';
comment on column AC65.eec001
  is '主键(编码规则：UUID)';
comment on column AC65.aac001
  is '扶贫系统主表主键（AC60编码规则：UUID）';
comment on column AC65.adc032
  is '是否有就业愿望';
comment on column AC65.adc033
  is '就业意向地';
comment on column AC65.adc034
  is '期望月薪（元）';
comment on column AC65.adc035
  is '就业服务需求';
comment on column AC65.aaf011
  is '经办机构编码';
comment on column AC65.aae009
  is '经办机构名';
comment on column AC65.aae011
  is '经办人编码';
comment on column AC65.aae010
  is '经办人姓名';
comment on column AC65.aae036
  is '经办日期';
comment on column AC65.aae132
  is '修改机构名';
comment on column AC65.aae133
  is '修改人姓名';
comment on column AC65.aae134
  is '修改人编码';
comment on column AC65.aae135
  is '修改机构编码';
comment on column AC65.aae102
  is '修改时间';
comment on column AC65.aab301
  is '业务经办行政区划';
comment on column AC65.aae100
  is '是否有效(1有效0无效)';
comment on column AC65.aae013
  is '备注';
create index IDX_AC65_AAC001 on AC65 (AAC001);
alter table AC65
  add constraint PK_AC65 primary key (EEC001);

prompt
prompt Creating table AC66
prompt ===================
prompt
create table AC66
(
  eec001 VARCHAR2(36) not null,
  aac001 VARCHAR2(36) not null,
  adc036 NUMBER(5),
  adc037 NUMBER(5),
  adc038 NUMBER(5),
  adc039 NUMBER(5),
  adc040 NUMBER(5),
  aaf011 VARCHAR2(100),
  aae009 VARCHAR2(100),
  aae011 VARCHAR2(50) not null,
  aae010 VARCHAR2(80) not null,
  aae036 DATE not null,
  aae132 VARCHAR2(100),
  aae133 VARCHAR2(80),
  aae134 VARCHAR2(50),
  aae135 VARCHAR2(100),
  aae102 DATE,
  aab301 VARCHAR2(12),
  aae100 VARCHAR2(20) not null,
  aae013 VARCHAR2(200)
)
;
comment on table AC66
  is '提供就业服务情况';
comment on column AC66.eec001
  is '主键(编码规则：UUID)';
comment on column AC66.aac001
  is '扶贫系统主表主键（AC60编码规则：UUID）';
comment on column AC66.adc036
  is '提供就业政策咨询次数(次)';
comment on column AC66.adc037
  is '提供就业信息次数（次）';
comment on column AC66.adc038
  is '提供职业指导与介绍次数（次）';
comment on column AC66.adc039
  is '提供培训次数（次）';
comment on column AC66.adc040
  is '提供创业服务次数(次)';
comment on column AC66.aaf011
  is '经办机构编码';
comment on column AC66.aae009
  is '经办机构名';
comment on column AC66.aae011
  is '经办人编码';
comment on column AC66.aae010
  is '经办人姓名';
comment on column AC66.aae036
  is '经办日期';
comment on column AC66.aae132
  is '修改机构名';
comment on column AC66.aae133
  is '修改人姓名';
comment on column AC66.aae134
  is '修改人编码';
comment on column AC66.aae135
  is '修改机构编码';
comment on column AC66.aae102
  is '修改时间';
comment on column AC66.aab301
  is '业务经办行政区划';
comment on column AC66.aae100
  is '是否有效(1有效0无效)';
comment on column AC66.aae013
  is '备注';
create index IDX_AC66_AAC001 on AC66 (AAC001);
alter table AC66
  add constraint PK_AC66 primary key (EEC001);

prompt
prompt Creating table AC67
prompt ===================
prompt
create table AC67
(
  eec001 VARCHAR2(36) not null,
  aac001 VARCHAR2(36) not null,
  adc041 VARCHAR2(20),
  adc042 VARCHAR2(20),
  adc043 VARCHAR2(20),
  adc044 VARCHAR2(20),
  aaf011 VARCHAR2(100),
  aae009 VARCHAR2(100),
  aae011 VARCHAR2(50) not null,
  aae010 VARCHAR2(80) not null,
  aae036 DATE not null,
  aae132 VARCHAR2(100),
  aae133 VARCHAR2(80),
  aae134 VARCHAR2(50),
  aae135 VARCHAR2(100),
  aae102 DATE,
  aab301 VARCHAR2(12),
  aae100 VARCHAR2(20) not null,
  aae013 VARCHAR2(200)
)
;
comment on table AC67
  is '政策落实情况';
comment on column AC67.eec001
  is '主键(编码规则：UUID)';
comment on column AC67.aac001
  is '扶贫系统主表主键（AC60编码规则：UUID）';
comment on column AC67.adc041
  is '是否享受职业介绍补贴';
comment on column AC67.adc042
  is '是否享受社会保险补贴';
comment on column AC67.adc043
  is '是否享受岗位补贴';
comment on column AC67.adc044
  is '是否享受其他政策扶持';
comment on column AC67.aaf011
  is '经办机构编码';
comment on column AC67.aae009
  is '经办机构名';
comment on column AC67.aae011
  is '经办人编码';
comment on column AC67.aae010
  is '经办人姓名';
comment on column AC67.aae036
  is '经办日期';
comment on column AC67.aae132
  is '修改机构名';
comment on column AC67.aae133
  is '修改人姓名';
comment on column AC67.aae134
  is '修改人编码';
comment on column AC67.aae135
  is '修改机构编码';
comment on column AC67.aae102
  is '修改时间';
comment on column AC67.aab301
  is '业务经办行政区划';
comment on column AC67.aae100
  is '是否有效(1有效0无效)';
comment on column AC67.aae013
  is '备注';

prompt
prompt Creating table S_EXCEL_BATCH
prompt ============================
prompt
create table S_EXCEL_BATCH
(
  excel_batch_id            VARCHAR2(36) not null,
  excel_batch_number        VARCHAR2(36),
  excel_batch_total_count   NUMBER(10),
  excel_batch_error_count   NUMBER(10),
  excel_batch_begin_time    DATE,
  excel_batch_end_time      DATE,
  excel_batch_cost          NUMBER(10),
  excel_batch_file_path     VARCHAR2(500),
  excel_batch_file_length   NUMBER(10),
  excel_batch_excel_type    VARCHAR2(20),
  excel_batch_aae011        VARCHAR2(20),
  excel_batch_status        VARCHAR2(3),
  excel_batch_data_status   NUMBER(3),
  excel_batch_rt_code       VARCHAR2(20),
  excel_batch_rt_msg        VARCHAR2(200),
  excel_batch_file_name     VARCHAR2(200),
  excel_error_file_path     VARCHAR2(200),
  excel_error_file_download VARCHAR2(200)
)
;
comment on table S_EXCEL_BATCH
  is '系统管理之excel数据导入状态表';
comment on column S_EXCEL_BATCH.excel_batch_id
  is 'excel导入状态表编号(uuid)';
comment on column S_EXCEL_BATCH.excel_batch_number
  is 'excel导入批次号。生成规则年月日时分秒毫秒';
comment on column S_EXCEL_BATCH.excel_batch_total_count
  is 'excel导入数据总量';
comment on column S_EXCEL_BATCH.excel_batch_error_count
  is 'excel导入数据错误数量';
comment on column S_EXCEL_BATCH.excel_batch_begin_time
  is 'excel导入数据开始时间';
comment on column S_EXCEL_BATCH.excel_batch_end_time
  is 'excel导入数据结束时间';
comment on column S_EXCEL_BATCH.excel_batch_cost
  is 'excel导入数据耗费时间(秒）';
comment on column S_EXCEL_BATCH.excel_batch_file_path
  is 'excel导入文件路径';
comment on column S_EXCEL_BATCH.excel_batch_file_length
  is 'excel导入文件大小';
comment on column S_EXCEL_BATCH.excel_batch_excel_type
  is 'excel导入类型';
comment on column S_EXCEL_BATCH.excel_batch_aae011
  is 'excel导入经办人';
comment on column S_EXCEL_BATCH.excel_batch_status
  is 'excel导入状态导入步骤(-1默认状态 0转换xlsx 1导入临时表 2解析临时表 3导入完成 4导入失败)';
comment on column S_EXCEL_BATCH.excel_batch_data_status
  is 'excel导入数据状态(0-100)';
comment on column S_EXCEL_BATCH.excel_batch_rt_code
  is 'excel导入数据校验是否成功';
comment on column S_EXCEL_BATCH.excel_batch_rt_msg
  is 'excel导入数据校验错误原因';
comment on column S_EXCEL_BATCH.excel_batch_file_name
  is 'excel导入文件原文件名';
comment on column S_EXCEL_BATCH.excel_error_file_path
  is 'excel导出文件文件路径';
comment on column S_EXCEL_BATCH.excel_error_file_download
  is 'excel导出文件文件生成状（0正在生成 1生成成功可下载 2 生成失败）';
alter table S_EXCEL_BATCH
  add constraint PK_EXCEL_BATCH_ID primary key (EXCEL_BATCH_ID);

prompt
prompt Creating package PKG_AC60_EXCEL_DATA_IMP
prompt ========================================
prompt
create or replace package pkg_ac60_excel_data_imp AS

  -- 成功返回标志
  RT_SUCCESS_CODE constant number  := '1';
  -- 错误返回标志
  RT_ERROR_CODE   constant number  := '0';

  PROCEDURE ac60_temp_imp_update(in_excel_batch_number varchar2,rt_code out varchar2,rt_msg out varchar2);

end pkg_ac60_excel_data_imp;
/


spool off
