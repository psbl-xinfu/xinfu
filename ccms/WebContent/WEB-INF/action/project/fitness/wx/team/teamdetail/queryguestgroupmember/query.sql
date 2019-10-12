select 
	gm.tuid,
	(case when gm.guesttype=1 then (select t.tuid from t_attachment_files t where t.pk_value = gm.pkvalue and t.table_code = 'cc_customer' and t.org_id= gm.org_id order by t.tuid desc limit 1)
			else (select t.tuid from t_attachment_files t where t.pk_value = gm.pkvalue and t.table_code = 'cc_guest' and t.org_id= gm.org_id order by t.tuid desc limit 1)
	end) as imgid,
	(case
		when (select name from cc_customer where code = gm.pkvalue and org_id = ${fld:org_id}) is not null
		then (select name from cc_customer where code = gm.pkvalue and org_id = ${fld:org_id})
		else (select name from cc_guest where code = gm.pkvalue and org_id = ${fld:org_id})
	end) as name,
	gm.org_id,
	gm.pkvalue
from cc_guest_group_member gm
where gm.groupid = ${fld:groupid}
and org_id = ${fld:org_id}
and (case when ${fld:name} is null then 1=1 else 
	(exists(
		select 1 from cc_customer cust
		where cust.code = gm.pkvalue
		and (cust.code = ${fld:name} or cust.name like concat('%', ${fld:name}, '%') or cust.mobile like concat('%', ${fld:name}, '%'))
		and cust.org_id = gm.org_id
	)
	or exists(
		select 1 from cc_guest guest
		where guest.code = gm.pkvalue
		and (guest.code = ${fld:name} or guest.name like concat('%', ${fld:name}, '%') or guest.mobile like concat('%', ${fld:name}, '%'))
		and guest.org_id = gm.org_id
	))
end)
order by gm.tuid asc