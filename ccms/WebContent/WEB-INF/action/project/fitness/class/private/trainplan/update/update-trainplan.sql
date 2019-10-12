update cc_trainplan
set warmup_mins = ${fld:warmup_mins},
aerobic_mins = ${fld:aerobic_mins},
run_mileage = ${fld:run_mileage}
where code = ${fld:traincode} and org_id = ${def:org}
