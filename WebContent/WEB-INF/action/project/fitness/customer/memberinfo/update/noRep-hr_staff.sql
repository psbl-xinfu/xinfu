 --zzn 20190327
select 1 
from hr_staff staf
INNER JOIN hr_org g ON g.org_id = '${def:org}'
inner join cc_customer cust on cust.code=${fld:cc_code}
where staf.user_id !=cust.user_id and concat(COALESCE(g.memberhead,''), ${fld:cc_mobile}) = staf.userlogin 
and staf.is_member='1'
and staf.org_id='${def:org}'
