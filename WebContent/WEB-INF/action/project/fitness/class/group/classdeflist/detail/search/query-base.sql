select
	cp.code,
	'<input type="checkbox" name="classpreparelist" value="'||cp.code||'" "/>' AS checklink,
	(select class_name from cc_classdef where code = cl.classcode and cc_classdef.org_id = ${def:org}) as class_name,
	cp.created,
	cp.cardcode,
	(select name from cc_cardtype where code = card.cardtype and cc_cardtype.org_id = ${def:org}) as cardtypename,
	(case when cp.status=1 then '预约中' when cp.status=2 then '已上课' else '爽约' end) as status,
	cp.custname as name,
	cp.phone as mobile,
	cp.remark,
	(case when cp.issank=0 then '散客' else '会员' end) as issank
from
cc_classprepare cp
left join cc_classlist cl on cp.classlistcode = cl.code and cp.org_id = cl.org_id
left join cc_card card on cp.cardcode = card.code and cp.org_id = card.org_id and card.isgoon=0
left join cc_customer cust on cp.customercode = cust.code and cp.org_id = cust.org_id
where cp.org_id=${def:org} and cp.status!=0 and cl.code = ${fld:classlist}
${filter}
${orderby}