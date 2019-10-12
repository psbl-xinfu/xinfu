delete from cc_cardtype_timelimit
where
 cardtype= ${fld:vc_code} and org_id=${def:org}
