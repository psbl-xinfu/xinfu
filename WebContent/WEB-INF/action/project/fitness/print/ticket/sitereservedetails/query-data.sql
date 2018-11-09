with paytype as (
	SELECT rowno::integer-1 AS rowno, vc_content FROM (
		SELECT ROW_NUMBER() OVER() AS rowno, vc_content, i_useravailable FROM (
			SELECT vc_content, i_useravailable FROM E_CNFG WHERE VC_CATEGORY = 'OtherPayWay' ORDER BY cnfg_id
		) AS t1 
	) AS t2 WHERE i_useravailable = '1'
) 
select
 (SELECT tenantry_name FROM t_tenantry WHERE tenantry_id = 100) as vc_head,
 (SELECT  vc_content  FROM e_cnfg WHERE  vc_category = 'Wish')  as  vc_foot,
  vc_billcode,----凭条编号
  vc_sitecode,----货号
  e_finance.f_money::numeric(10,2),---金额
  e_sitedef.vc_sitename, ----场地名称
  e_sitedef.f_price,-----单价
 (case when c_closetime is not null and c_opentime is not null 
  then to_char((c_closetime::time without time zone-c_opentime::time without time zone),'hh24:mi:ss') else '' end)as shi_chang,--在场时间;时长
  ---datediff('mi',c_closetime,c_opentime),
 --------''60'' as f_shichang,
  e_finance.f_money::numeric(10,2),--" IS '收入';
  e_finance.f_cash::numeric(10,2),--" IS '现金金额';
  e_finance.vc_auser,--" IS '操作人';
  e_finance.c_atime,--" IS '操作时间';
  (
  	e_sitedef.f_price || '元/小时 ' ||
 	(case e_sitedef.i_timetype when '0' then '以实际发生时间计算' when '1' then '以15分钟为最小计费单位计算' when '2' then '以半小时为最小计费单位计算' else '' end)
  ) as f_remark,----备注
 (
  select  string_agg((e_sitedef.vc_sitename|| '<br/>' || e_siteusedetail.vc_sitecode || '       ' ||e_sitedef.f_price::numeric(10,2)|| '*' || ${fld:shi_chang} || '       '||e_finance.f_premoney::numeric(10,2)),'<br/>')   
  from   e_siteusedetail  
  left  join  e_sitedef  on  e_siteusedetail.vc_sitecode=e_sitedef.vc_code
  inner join  e_finance   on   e_siteusedetail.vc_billcode=e_finance.vc_code
  where  vc_billcode=${fld:pk_value}
  )as  gouwu_xiaopiao, 
  
 (select  count(1)   from   e_sitedef  where  vc_code=e_siteusedetail.vc_sitecode)  as  f_jianshu,
	(
		select string_agg(vc_content||'：'||get_arr_value(e_finance.pay_detail,rowno),'<br/>') 
		from paytype
	) as paydetail
 from  e_siteusedetail
 inner join  e_finance   on   e_siteusedetail.vc_billcode=e_finance.vc_code
 left  join  e_sitedef  on  e_siteusedetail.vc_sitecode=e_sitedef.vc_code
 where vc_billcode=${fld:pk_value}
  
  
