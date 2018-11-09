update t_union set 
	group_name= ${fld:group_name},
	remark= ${fld:remark} 
where tuid = ${fld:tuid};
