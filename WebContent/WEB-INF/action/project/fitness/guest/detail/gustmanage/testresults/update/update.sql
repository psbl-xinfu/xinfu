update cc_testresult 
set 
	height = ${fld:i_height},
	age =  ${fld:i_age},
	sex = ${fld:i_sex},
	weight = ${fld:f_weight},
	skeletal_muscle = ${fld:f_skeletal_muscle},
	boday_fat = ${fld:f_boday_fat},
	bmi = ${fld:f_bmi},
	pbf = ${fld:f_pbf},
	whr = ${fld:f_whr},
	kcal = ${fld:f_kcal},
	health = ${fld:i_health},
    remark = COALESCE(remark,'')||'${def:user}:${def:timestamp};' 
where code = ${fld:vc_code}  and org_id = ${def:org}
