SELECT
customercode,
p.code,
(select name from cc_customer where code=p.customercode and org_id = ${def:org}) as name,
(select mobile from cc_customer where code=p.customercode and org_id = ${def:org}) as mobile,
p.preparedate,
to_char(p.preparetime, 'HH24:MI') as preparetime,
(case when  p.status=0 then '无效'  when p.status=1 then '预约中' when p.status=2 then '已上课'
when p.status=3 then '爽约' else '待确认' end)  as status,
p.customercode,
(
select d.ptlevelname from cc_ptrest t 
  left join cc_ptdef d  on d.code=t.ptlevelcode and t.org_id = d.org_id 
  where t.code=p.ptrestcode and t.org_id = ${def:org} 
)as ptlevelname

FROM cc_ptprepare p
where org_id=${def:org}
and ptid='${def:user}'
and code=${fld:code}


