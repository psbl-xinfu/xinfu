update cc_cabinet 
set status = ${fld:status2_r},
physics_status = ${fld:physics_status_r}
where
  cabinetcode = ${fld:cabinetcode2_r}
