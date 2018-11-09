select 
	string_agg(
		(case when gm.guesttype=1 then (select t.tuid from t_attachment_files t where t.pk_value = gm.pkvalue and t.table_code = 'cc_customer' and t.org_id= gm.org_id order by t.tuid desc limit 1)
				else (select t.tuid from t_attachment_files t where t.pk_value = gm.pkvalue and t.table_code = 'cc_guest' and t.org_id= gm.org_id order by t.tuid desc limit 1)
		end)::varchar
	, ';') as imgid
from cc_guest_group_member gm
where gm.groupid = ${fld:groupid}
and org_id = ${fld:org_id}
