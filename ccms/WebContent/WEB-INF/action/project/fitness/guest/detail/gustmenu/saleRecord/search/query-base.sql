select
	
(SELECT  param_text  FROM cc_config WHERE category = 'OpeCategory'
	and param_value::int=op.opertype::int  
	and org_id=1003) as type,
		c.normalmoney,--应收
	c.factmoney,--实收factmoney
c.factmoney + (case when  (select DISTINCT a.factmoney * (case when  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode ) is null then 0 
else  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode )
end ) from  cc_contract a  where a.relatecode = c.code ) is null then 0
else (select DISTINCT a.factmoney * (case when  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode ) is null then 0 
else  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode )
end ) from  cc_contract a  where a.relatecode = c.code )end) 
as prepaid,--已付
  	c.normalmoney - c.factmoney - (
		COALESCE ((
			SELECT SUM (t1.factmoney) FROM cc_contract t1 
			WHERE t1.relatecode = c.code AND t1.status >= 2 and t1.org_id = c.org_id
		),0.00)
	)::numeric(10,2) AS amount_owe,--未付
	(select name from hr_staff where userlogin=op.createdby) as vc_iuser,--操作人
	op.createdate as createdate,
	(case when c.factmoney + (case when  (select DISTINCT a.factmoney * (case when  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode ) is null then 0 
else  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode )
end ) from  cc_contract a  where a.relatecode = c.code ) is null then 0
else (select DISTINCT a.factmoney * (case when  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode ) is null then 0 
else  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode )
end ) from  cc_contract a  where a.relatecode = c.code )end) 
=c.normalmoney then '已付清' else '未付清' end) as status,
	op.createtime as createtime
from cc_operatelog op
inner join cc_contract c on op.pk_value = c.code and op.org_id = c.org_id and c.contracttype!=3 
where op.customercode=${fld:id} and op.org_id='${def:org}' 
--zzn 排除租柜押金
and op.opertype!='29'
and to_char(op.createdate, 'yyyy-MM')>=${fld:startdate} 
and to_char(op.createdate, 'yyyy-MM')<=${fld:enddate} 
--${fld:paymentstatus} 1已付清， 0未付清，null全部
and (case when ${fld:paymentstatus} is null then 1=1 
		  else (case when ${fld:paymentstatus}='1' --已付清，应收=（实收+（））  --还款合同已付款 d.contracttype=3 and d.status=2
		  		then c.normalmoney= (c.factmoney + (case when (select DISTINCT a.factmoney * 
		  																(case when  (select count(d.relatecode) as geshu from cc_contract d where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode ) is null then 0 
		  																 else  (select count(d.relatecode) as geshu from cc_contract d where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode )
														 				 end) 
														 	  from  cc_contract a  where a.relatecode = c.code 
														 	  ) is null then 0  --是办卡合同，没有还款合同已付款
												    else (select DISTINCT a.factmoney * 
												    					(case when  (select count(d.relatecode) as geshu from cc_contract d where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode ) is null then 0 
												    					 else  (select count(d.relatecode) as geshu from cc_contract d  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode )
		     											                 end ) 
		     											  from  cc_contract a  where a.relatecode = c.code 
		     											) --定金合同，有还款合同已付款
		     										end
		     									  )
		     						 )
		     	--${fld:paymentstatus}=0 未付清				 
		 else c.normalmoney!= (c.factmoney + (case when  (select DISTINCT a.factmoney * 
		 														   (case when  (select count(d.relatecode) as geshu from cc_contract d  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode ) is null then 0 
																	else  (select count(d.relatecode) as geshu from cc_contract d where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode )
											 						end ) 
											 			 from  cc_contract a  where a.relatecode = c.code ) is null then 0
											 else 
											(select DISTINCT a.factmoney * (case when  (select count(d.relatecode) as geshu from cc_contract d 
 										 where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode ) is null then 0 
											else  (select count(d.relatecode) as geshu from cc_contract d 
 			 							where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode )
										end ) from  cc_contract a  where a.relatecode = c.code 
												)
										end)
							)
		end) 
	end)
--zzn 添加商品销售的记录，可能有bug 目前看所有商品销售cc_operatelog 中类型都是55的
union all

select 
    (SELECT  param_text  FROM cc_config WHERE category = 'OpeCategory'
		and param_value::int=op.opertype::int  
		and org_id=1003) as type,
	op.normalmoney,--应收
	op.factmoney,--实收factmoney
	0 as prepaid,--已付
	0   AS amount_owe,--未付
	(select name from hr_staff where userlogin=op.createdby) as vc_iuser,--操作人 
	op.createdate as createdate,
	 '已付清'  as status,
	op.createtime as createtime
from cc_operatelog op 
where op.customercode=${fld:id} and op.org_id='${def:org}'
and to_char(op.createdate, 'yyyy-MM')>=${fld:startdate} 
and to_char(op.createdate, 'yyyy-MM')<=${fld:enddate} 
and op.opertype in ('59','60','55')-- 商品、单次消费
order by createdate desc,createtime desc

