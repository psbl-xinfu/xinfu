update cc_cabinettemp  set
status = ${fld:status2_r},
physics_status = ${fld:physics_status_r}
where
  cabinettempcode = ${fld:cabinetcode2_r}
