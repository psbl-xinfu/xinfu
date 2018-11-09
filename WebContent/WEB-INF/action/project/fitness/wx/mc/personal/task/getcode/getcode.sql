select 
	tuid
from cc_target_group tg
inner join hr_skill skill ON tg.pk_value = skill.skill_id and tg.org_id = skill.org_id
where tg.org_id=${def:org} and tg.target_type=0 and skill.skill_scope=${fld:skilltype}
and concat(tg.target_year, '-', tg.target_month, '-01')::date=concat(${fld:target_date}, '-01')::date