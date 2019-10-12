select
chargemoney as normalmoney,
remark as relatedetail,
(select name from hr_staff where userlogin=cc_chargecard.createdby and org_id=${def:org}) as vc_iuser,
created
from
cc_chargecard
where customercode=${fld:customercode}
and org_id=${def:org}