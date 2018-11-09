update cc_cardcode set 
	incode=${fld:incode}
where
	cardcode = ${fld:vc_code} and org_id = ${def:org}
