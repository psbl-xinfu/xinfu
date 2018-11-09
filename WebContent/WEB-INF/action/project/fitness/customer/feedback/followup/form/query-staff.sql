select 
	userlogin as staffuserlogin,
	name as staffname
from hr_staff
where userlogin = '${def:user}'