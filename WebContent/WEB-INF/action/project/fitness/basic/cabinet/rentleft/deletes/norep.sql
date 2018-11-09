select 1 from dual
where
exists 
	(select 1 from    cc_cabinet_group g
			right join cc_cabinet b on g.tuid=b.groupid  and b.org_id=${def:org}
			where g.org_id=${def:org} and	g.tuid::varchar in (select regexp_split_to_table(${fld:id}, ';'))
	)
