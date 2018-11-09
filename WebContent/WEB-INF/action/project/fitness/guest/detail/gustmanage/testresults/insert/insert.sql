insert into cc_testresult
(
	age,
    code,
    guestcode,
	height,
	created,
	sex,
	weight,
	skeletal_muscle,
	boday_fat,
	bmi,
	pbf,
	whr,
	kcal,
	health,
    createdby,
    org_id
)
values 
(
	${fld:i_age},
	${seq:nextval@seq_cc_testresult},
	${fld:guestid},
    ${fld:i_height},
	{ts '${def:timestamp}'},
    ${fld:i_sex},
    ${fld:f_weight},
    ${fld:f_skeletal_muscle},
    ${fld:f_boday_fat},
    ${fld:f_bmi},
    ${fld:f_pbf},
    ${fld:f_whr},
    ${fld:f_kcal},
    ${fld:i_health},
    '${def:user}',
    ${def:org}
)



