select 
	s.code,
	s.itemcode,
	s.price,
	s.unit,
	s.amount,
	s.seller,
	s.money,
	s.normalmoney,
	(s.money-s.normalmoney) as zk,
	s.status,
	(case when s.paytype=1 then '现金/银行卡支付' else '储蓄卡支付' end) as zffs,
	s.remark
from cc_singleitem s
where s.code = ${fld:singleitemcode} and s.org_id = ${def:org}