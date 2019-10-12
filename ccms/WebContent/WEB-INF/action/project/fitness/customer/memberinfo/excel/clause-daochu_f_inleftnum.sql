and exists(
	select 1 from dual
	where (case 
	when ${fld:daochu_f_inleftnum} = 0  then 
		(select count(1) from cc_inleft where customercode = r.code 
		and indate>=${fld:daochu_start_date} and indate<=${fld:daochu_end_date}
		and org_id = ${def:org})=0
	when ${fld:daochu_f_inleftnum} = 1  then 
		(select count(1) from cc_inleft where customercode = r.code 
		and indate>=${fld:daochu_start_date} and indate<=${fld:daochu_end_date}
		and org_id = ${def:org})>0 and (select count(1) from cc_inleft where customercode = r.code 
		and indate>=${fld:daochu_start_date} and indate<=${fld:daochu_end_date}
		and org_id = ${def:org})<=4
	when ${fld:daochu_f_inleftnum} = 2  then 
		(select count(1) from cc_inleft where customercode = r.code 
		and indate>=${fld:daochu_start_date} and indate<=${fld:daochu_end_date}
		and org_id = ${def:org})>4 and (select count(1) from cc_inleft where customercode = r.code 
		and indate>=${fld:daochu_start_date} and indate<=${fld:daochu_end_date}
		and org_id = ${def:org})<=15
	when ${fld:daochu_f_inleftnum} = 3  then 
		(select count(1) from cc_inleft where customercode = r.code 
		and indate>=${fld:daochu_start_date} and indate<=${fld:daochu_end_date}
		and org_id = ${def:org})>15
	end)
	
	
)