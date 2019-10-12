select code as lcode 
from  cc_ptlog where  ptrestcode=${fld:ptrestcode} and  org_id=${def:org}  
	and customercode=
				(select code from cc_customer where user_id=
					(select user_id  from hr_staff where userlogin='${def:user}' and org_id=${def:org})
					and org_id=${def:org}
order by 	code desc)
and org_id=${def:org}