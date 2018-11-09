update hr_org_holiday set 
	begintime=${fld:begintime},
	endtime=${fld:endtime},
	remark=${fld:remark}
where
	tuid = ${fld:vc_code} and org_id = ${def:org}
