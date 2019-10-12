select
	status as i_status,--状态
	CASE status WHEN 0 THEN '无效' ELSE '有效' END as i_status
from cc_cardtype
where
  code=${fld:vc_code} and org_id = ${def:org}