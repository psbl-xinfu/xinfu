update cc_cardtype set 
	cardcategory=${fld:vc_name1},
 	name=${fld:vc_name},
	membercount=${fld:i_membercount},
	isoffseason=${fld:vc_isoffseason},
	type=${fld:i_type},
	item=${fld:vt},
	daycount=${fld:i_daycount},
	allowcount=${fld:i_allowcount},
	limitswimtime=${fld:f_limitswimtime},
	freebathcount=${fld:i_freebathcount},
	scale=${fld:f_scale},
	giveday=${fld:i_giveday},
	ptcount=${fld:i_ptcount},
	savedaycount=${fld:i_savedaycount},
	remark=${fld:vc_remark},
	count=${fld:i_count},
	moneyleft=${fld:f_moneyleft}
  where
 	code= ${fld:vc_code} and org_id = ${def:org}
 
 
