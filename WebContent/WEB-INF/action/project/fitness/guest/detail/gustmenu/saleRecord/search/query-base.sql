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
	op.createdate,
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
	op.createtime
from cc_operatelog op
inner join cc_contract c on op.pk_value = c.code and op.org_id = c.org_id and c.contracttype!=3
where op.customercode=${fld:id} and op.org_id='${def:org}'
and to_char(op.createdate, 'yyyy-MM')>=${fld:startdate} 
and to_char(op.createdate, 'yyyy-MM')<=${fld:enddate} 
and (case when ${fld:paymentstatus} is null then 1=1 else 
		(case when ${fld:paymentstatus}='1' then c.normalmoney= (c.factmoney + (case when  (select DISTINCT a.factmoney * (case when  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode ) is null then 0 
else  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode )
end ) from  cc_contract a  where a.relatecode = c.code ) is null then 0
else (select DISTINCT a.factmoney * (case when  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode ) is null then 0 
else  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode )
end ) from  cc_contract a  where a.relatecode = c.code )end))
		else c.normalmoney!= (c.factmoney + (case when  (select DISTINCT a.factmoney * (case when  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode ) is null then 0 
else  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode )
end ) from  cc_contract a  where a.relatecode = c.code ) is null then 0
else (select DISTINCT a.factmoney * (case when  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode ) is null then 0 
else  (select count(d.relatecode) as geshu from cc_contract d 
  where d.contracttype=3 and d.status=2 and c.code = d.relatecode GROUP BY  d.relatecode )
end ) from  cc_contract a  where a.relatecode = c.code )end))
		end) end)
order by op.createdate desc,op.createtime desc
