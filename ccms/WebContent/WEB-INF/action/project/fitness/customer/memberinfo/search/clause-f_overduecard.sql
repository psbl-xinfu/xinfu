and
	(select max(enddate) from cc_card  where cc_card.customercode = r.code and cc_card.isgoon = 0)::date>='${def:date}'::date
and 
	(select max(enddate) from cc_card  where cc_card.customercode = r.code and cc_card.isgoon = 0)::date<=(select '${def:date}'::date+interval ${fld:f_overduecard}' month')::date