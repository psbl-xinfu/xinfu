select 
	gg.groupname,
	(select count(1) from cc_guest_group_member where groupid = gg.tuid and org_id = ${fld:org_id}) as num,
	gg.org_id,
	(case
		when (select name from cc_customer where code = gg.leader and org_id = ${fld:org_id}) is not null
		then (select name from cc_customer where code = gg.leader and org_id = ${fld:org_id})
		else (select name from cc_guest where code = gg.leader and org_id = ${fld:org_id})
	end) as name,
	(case when (select t.tuid from t_attachment_files t where t.pk_value = gg.leader and t.table_code = 'cc_customer' 
					and t.org_id= gg.org_id order by t.tuid desc limit 1) is not null
		then (select t.tuid from t_attachment_files t where t.pk_value = gg.leader and t.table_code = 'cc_customer' 
					and t.org_id= gg.org_id order by t.tuid desc limit 1)
		else (select t.tuid from t_attachment_files t where t.pk_value = gg.leader and t.table_code = 'cc_guest' and t.org_id= gg.org_id order by t.tuid desc limit 1)
	end) as imgid,
	gg.remark
from cc_guest_group gg
where gg.org_id = ${fld:org_id}
and tuid = ${fld:groupid}

