update cc_cabinettemp  set
status = ${fld:status2_r},
physics_status = ${fld:physics_status_r},
cabinettempcode = ${fld:cabinetcode2_r}
where
tuid=${fld:cab_tuid}
--zzn190320