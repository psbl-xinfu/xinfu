 and
	 (select t.code
	 from 	cc_card d
	 left join cc_cardtype t on t.code=d.cardtype
	 where d.code=get_arr_value(c.relatedetail,1) and d.isgoon=0 and d.org_id=${def:org}) =${fld:daochu_type}
	
