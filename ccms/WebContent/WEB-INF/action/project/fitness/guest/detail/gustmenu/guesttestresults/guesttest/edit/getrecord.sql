select
    height,
    weight,
    fat,
    weight_index,
    thigh_circumference,
    crus_circumference,
    lung_capacity,
    static_heart,
    muscle,
    bone,
    moisture_content,
    body_fat,
    systolic,
    pressure,
    cardiopulmonary_test,
    abdomen_muscles,
    upper_limb_muscles,
    lower_limb_muscles,
    flexibility,
    equilibria
from 
	cc_testresult 	
where 
	code = ${fld:code} and org_id = ${def:org}
