update cc_cardtype_timelimit set
  starttime1= ${fld:c_starttime1},
  endtime1= ${fld:c_endtime1},
  starttime2= ${fld:c_starttime2},
  endtime2= ${fld:c_endtime2}
where
 	cardtype= ${fld:in_vc_code}
 AND
 	weekday = ${fld:i_weekday} and org_id = ${def:org}
