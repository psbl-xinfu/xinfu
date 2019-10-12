select
	tuid,
	groupid,
	guesttype,
	pkvalue,
	(case when guesttype=1 
		then (select name from cc_customer where code = pkvalue and org_id = ${def:org}) 
		when guesttype=0 
		then (select name from cc_guest where code = pkvalue and org_id = ${def:org}) end) as guestname
from
	cc_guest_group_member
where
	tuid::varchar=${fld:code} and org_id = ${def:org}
