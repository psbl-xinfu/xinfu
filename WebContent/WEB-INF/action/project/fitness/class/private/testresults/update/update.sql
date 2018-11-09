update cc_testresult 
set 
	height = ${fld:height},
	weight =  ${fld:weight},
	fat = ${fld:fat},
	weight_index = ${fld:weight_index},
	thigh_circumference = ${fld:thigh_circumference},
	crus_circumference = ${fld:crus_circumference},
	lung_capacity = ${fld:lung_capacity},
	static_heart = ${fld:static_heart},
	muscle = ${fld:muscle},
	bone = ${fld:bone},
	moisture_content = ${fld:moisture_content},
	body_fat = ${fld:body_fat},
	systolic = ${fld:systolic},
	pressure = ${fld:pressure},
	cardiopulmonary_test = ${fld:cardiopulmonary_test},
	abdomen_muscles = ${fld:abdomen_muscles},
	upper_limb_muscles = ${fld:upper_limb_muscles},
	lower_limb_muscles = ${fld:lower_limb_muscles},
	flexibility = ${fld:flexibility},
	equilibria = ${fld:equilibria}
where code = ${fld:testcode}  and org_id = ${def:org}
