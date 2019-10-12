 select
	 	concat('<input type="checkbox"  data-am-ucheck name="datalist" 
	   value="',tuid::varchar,'','" >') as application_id,
 	groupname,
 	groupcode,
 	tuid,
 	
 	(select count(*) from cc_cabinettemp b
  	where    cc_cabinettemp_group.tuid=b.groupid and b.status=1 and b.org_id=${def:org}
 	group by  b.groupid
 	)as zhan,
 	
 	 (select count(*) from cc_cabinettemp b
  	where    cc_cabinettemp_group.tuid=b.groupid and b.status=0 and b.org_id=${def:org}
 	group by  b.groupid
 	)as kong
 	
 from
 	cc_cabinettemp_group
 where
 	status=1
 	and org_id=${def:org}
${orderby}



