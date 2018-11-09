SELECT
(select name from cc_customer where code=p.customercode) as name,
(select mobile from cc_customer where code=p.customercode) as mobile,
p.preparedate,

d.ptlevelname as ptlevelname,
p.code,
(select name from hr_staff where userlogin=p.ptid) as pt,

to_char(preparetime,'HH24:MI')as preparetime,
to_char(p.preparetime+ concat(d.times,' min')::interval, 'HH24:MI') as preparetime1,
(case when p.status=0 then '无效'  when p.status=1 then '预约中' when p.status=2 then '已上课'
when p.status=3 then '爽约' else '待确认' end)  as status,
p.customercode,

(SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =(select user_id from cc_customer where code=p.customercode and  cc_customer.org_id=${def:org} )
		 )as headpic
FROM cc_ptprepare p 
inner join cc_ptrest t on p.ptrestcode=t.code and p.org_id = t.org_id 
inner join cc_ptdef d on d.code=t.ptlevelcode and d.org_id = t.org_id 
where 
 p.org_id=${def:org}
and p.status!=0
and p.ptid='${def:user}'
and p.code=${fld:code}
