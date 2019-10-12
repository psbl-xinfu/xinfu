update cc_cabinet_group set 
  groupname= ${fld:groupname},
 groupcode= ${fld:groupcode}
where
  tuid = ${fld:groupid};
