  SELECT
	concat('
	  <label class="am-checkbox">
	  <input type="radio"  data-am-ucheck name="datalist" 
	   value="',userlogin,'','" >
	   </label>
') as application_id,
  
name,
(select count(DISTINCT p.customercode) from cc_ptrest p where p.ptid=staff.userlogin and p.ptlevelcode!=(select code from cc_ptdef where reatetype=1) 
and p.org_id = staff.org_id) as customernum,
(select count(ptrest.customercode) from cc_ptrest ptrest
LEFT JOIN  cc_customer cust on cust.code=ptrest.customercode
  where not exists(
 select 1  from cc_ptrest p where p.ptlevelcode!=(select code from cc_ptdef where reatetype=1) 
and ptrest.customercode=p.customercode) and cust.pt=staff.userlogin and ptrest.org_id = staff.org_id) as gustnum
from hr_staff staff
inner join (select user_id from hr_staff_skill 
	inner join (select skill_id from hr_skill where skill_scope in ('1') and org_id = ${def:org}) skill
	on skill.skill_id = hr_staff_skill.skill_id
) hs on hs.user_id = staff.user_id
where staff.status = 1 and staff.org_id = ${def:org}