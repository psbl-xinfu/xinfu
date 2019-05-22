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
	s.code,
	s.itemcode,
	s.price,
	(case when
  unit='0' then '次'
  when unit='1' then '张'
  else null
  end) as unit,
	s.amount,
	s.seller,
	s.money,
	s.normalmoney,
	s.discount as zk,
	s.status,
	 (select string_agg(param_text,';')
		from paytype where 0.00 != (case when get_arr_value(s.pay_detail,rowno) = '' then '0.00' else get_arr_value(s.pay_detail,rowno) end)::numeric(10,2)
	) as zffs,
	s.remark
from cc_singleitem s
where s.code = ${fld:singleitemcode} and s.org_id = ${def:org}