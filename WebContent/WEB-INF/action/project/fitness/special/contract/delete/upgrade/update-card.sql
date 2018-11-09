update cc_card set
	vc_cardtype=h.vc_cardtype,
	f_factmoney=h.f_factmoney,
	i_giveday=h.i_giveday,
	i_totalday=h.i_totalday,
	i_count=h.i_count,
	c_enddate = (case when 
		(SELECT get_arr_value(relatedetail, 2) from cc_operatelog where opertype='05' and  ${fld:card_code}=get_arr_value(relatedetail, 0) and org_id = ${def:org} order by code desc LIMIT 1)
		is not null 
		then
		(SELECT get_arr_value(relatedetail, 2) from cc_operatelog where opertype='05'  and ${fld:card_code}=get_arr_value(relatedetail, 0) and org_id = ${def:org} order by code desc LIMIT 1)::date
		else
		h.c_enddate
		end )

from (
	SELECT cardtype,factmoney,giveday,totalday,count,enddate,code
	from e_card_history where vc_code=${fld:card_code} order by created desc limit 1
) as h

where h.vc_code=e_card.vc_code
and e_card.vc_code=${fld:card_code} and isgoon = 0