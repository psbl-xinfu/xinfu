select 
	code,
	mobile,
	name,
	sex,
	type,
	mc,
	(select st.name from hr_staff st where st.userlogin=mc and  st.org_id = org_id) as mcname 
from cc_guest
where code = ${fld:guest_code}
and org_id = ${def:org}