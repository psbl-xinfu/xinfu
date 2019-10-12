with paytype as (
	SELECT rowno::integer-1 AS rowno, param_text FROM (
		SELECT ROW_NUMBER() OVER() AS rowno, param_text, status FROM (
			SELECT param_text, status FROM cc_config WHERE CATEGORY = 'OtherPayWay' 
			and org_id = (case when 
				not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=cc_config.category) 
				then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end) 
			ORDER BY tuid
		) AS t1 
	) AS t2 WHERE status = 1
) 
select
    s.name,
    s.normalmoney,
    (select string_agg(param_text,';')
		from paytype where 0.00 != (case when get_arr_value(s.pay_detail,rowno) = '' then '0.00' else get_arr_value(s.pay_detail,rowno) end)::numeric(10,2)
	) as payment,
    cust.code,
    cust.name as cust_name,
    (case when s.status=1 then '未付款' else '已付款' end) as status,
    (select name from hr_staff where userlogin = s.createdby) as createdby,
    s.created
from cc_singleitem s
left join cc_customer cust on cust.code=s.customercode and s.org_id=cust.org_id
where
  1=1 
  and s.org_id = ${def:org}
${filter} 
order by s.created desc

