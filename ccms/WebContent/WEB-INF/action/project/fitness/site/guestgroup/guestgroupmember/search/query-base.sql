select
	concat('<input type="checkbox" name="guestgroupmember" value="', gm.tuid, '" />') AS checklink,
	cg.groupname,
	(case when gm.guesttype=0 then '资源' when gm.guesttype=1 then '会员' end) as guesttype,
	(case when gm.guesttype=1 
		then cust.name
		when gm.guesttype=0 
		then guest.name end) as guestname
from cc_guest_group_member gm
left join cc_guest_group cg on gm.groupid = cg.tuid and gm.org_id = cg.org_id
left join cc_customer cust on gm.pkvalue = cust.code and gm.org_id= cust.org_id
left join cc_guest guest on gm.pkvalue = guest.code and gm.org_id = guest.org_id
where gm.org_id = ${def:org} and gm.status = 1 and cg.tuid = ${fld:searchgroupid}
${filter}
${orderby}
