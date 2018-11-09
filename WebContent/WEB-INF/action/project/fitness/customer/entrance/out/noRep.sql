select 1 from cc_cabinettemp
where 
(case 
	when 
	${fld:rudge_code} is null
	then 1=2
	when 
	(select count(1) from cc_cabinettemp 
		where cabinettempcode = ${fld:rudge_code} and org_id = ${fld:unionorgid})=0
	then
		1=1
	else
		(cabinettempcode = ${fld:rudge_code} and org_id = ${fld:unionorgid}
		and cardcode=${fld:cardcode} and status!=1)
	end)
