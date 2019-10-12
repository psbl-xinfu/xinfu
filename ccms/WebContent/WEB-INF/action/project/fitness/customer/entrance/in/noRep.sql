select 1 from cc_cabinettemp
where 
(case 
	when 
	${fld:rudge_code} is null
	then 1=2
	when
	(select count(1) from cc_cabinettemp 
		where tuid = ${fld:rudge_code} and org_id = ${def:org}
		and physics_status!=0
		)=0
	then
	1=1
	else
		(tuid = ${fld:rudge_code} and org_id = ${def:org} and (status = 1 or status=2))
	end) 
