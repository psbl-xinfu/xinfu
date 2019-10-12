update cc_cabinettemp_group set 
  groupname= ${fld:groupname},
 groupcode= ${fld:groupcode}
where
  tuid = ${fld:groupid};
