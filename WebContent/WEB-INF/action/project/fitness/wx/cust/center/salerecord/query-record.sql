select
(SELECT  param_text  FROM cc_config WHERE category = 'OpeCategory'
and param_value::int=opertype::int  
and org_id=${def:org}) as type,
normalmoney,
(select name from hr_staff where userlogin=cc_operatelog.createdby and org_id=${def:org} ) as vc_iuser,
createdate,
 '已付款'  as status
from
cc_operatelog
where customercode=${fld:customercode}
and org_id=${def:org}
and normalmoney=factmoney






