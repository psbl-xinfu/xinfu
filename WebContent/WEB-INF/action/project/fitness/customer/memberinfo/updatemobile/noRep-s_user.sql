 --zzn 20190327
select 1 
from "security".s_user su
INNER JOIN hr_org g ON g.org_id = ${def:org}
inner join cc_customer cust on cust.code=${fld:cc_code}
where su.user_id !=cust.user_id and concat(COALESCE(g.memberhead,''), ${fld:cc_mobile}) = su.userlogin 
--and su.enabled='1'
