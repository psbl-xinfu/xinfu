 select
		concat('
	  <input type="checkbox"   name="datalist" 
	   value="',tuid::varchar,'','" >
	') as application_id,
	tuid,
 	groupname,
 	groupcode
 from
 	cc_cabinet_group
 where
 	status=1
 	and org_id=${def:org}
${orderby}



