 AND (r.name LIKE '%'||${fld:daochu_vc_all}||'%' or ${fld:daochu_vc_all} = (
 	CASE WHEN c.type = 2 THEN get_arr_value(relatedetail,6) 
	WHEN c.type IN (7,9,11) THEN get_arr_value(relatedetail,1) 
	WHEN c.type IN (1,12) THEN get_arr_value(relatedetail,11) 
	ELSE get_arr_value(relatedetail,1) END
 )
 or
			exists(
				select 1 from cc_card card
				where card.isgoon = 0 and card.status!=0
				and card.customercode = r.code 
				and card.code in (select cardcode from cc_cardcode where incode = ${fld:daochu_vc_all} and org_id = ${def:org})
			)
 )
