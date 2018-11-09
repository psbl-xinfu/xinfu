  SELECT
	concat('
	  <label class="am-checkbox">
	  <input type="radio"  data-am-ucheck name="datalist" 
	   value="',userlogin,'','" >
	   </label>
') as application_id,
  
name,
(select count(DISTINCT p.customercode) from cc_ptrest p where ptid=staff.userlogin and p.org_id = staff.org_id) as customernum,

(select count(DISTINCT c.customercode) from cc_card c where status!=0 and status!=6 and isgoon=0 and c.org_id = staff.org_id
and 
	not exists(
		select 1 from cc_ptrest p where p.customercode=c.customercode
		and ptid=staff.userlogin and p.org_id = staff.org_id
	)
) as gustnum
from hr_staff staff
inner join (select user_id from hr_staff_skill 
	inner join (select skill_id from hr_skill where skill_scope in ('1', '4') and org_id = ${def:org}) skill
	on skill.skill_id = hr_staff_skill.skill_id
) hs on hs.user_id = staff.user_id
where staff.status = 1 and staff.org_id = ${def:org}