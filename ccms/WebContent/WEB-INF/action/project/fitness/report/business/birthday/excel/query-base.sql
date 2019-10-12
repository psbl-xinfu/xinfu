select
	concat('<label class="am-checkbox"><input type="checkbox"  data-am-ucheck name="datalist" ',
	'value="',c.code::varchar,'" ></label>') as application_id
	,c.code
	,c.name
	,c.mobile
	,case when c.birth is not null and c.birth != '' and c.birthday is not null and c.birthday != '' then concat(c.birth,'月',c.birthday,'日') else null end as birth
	,case when c.birth is not null and c.birth != '' and c.birthday is not null and c.birthday != '' then (
		case
		 when (concat(to_char('${def:date}'::date, 'yyyy'),'-',c.birth,'-',c.birthday) ::Date -'${def:date}'::Date)::int4<0
		   then concat(((to_char('${def:date}'::date, 'yyyy'))::int4+1)::varchar,'-',c.birth,'-',c.birthday) ::Date -'${def:date}'::Date
		 else
		   concat(to_char('${def:date}'::date, 'yyyy'),'-',c.birth,'-',c.birthday) ::Date -'${def:date}'::Date
		 end
	 ) else null end as  birthday
	,c.indate
	,s.name as mc_name
from
    cc_customer c
    left join hr_staff s ON c.mc=s.userlogin
    left join cc_card card ON card.customercode=c.code
where c.status = 1  and c.org_id = ${def:org} 
    
${filter}




