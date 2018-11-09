update cc_contract
set relatedetail = concat(get_arr_value(relatedetail,0),';',get_arr_value(relatedetail,1),';',
get_arr_value(relatedetail,2),';',get_arr_value(relatedetail,3),';',
get_arr_value(relatedetail,4),';','${def:date}',';',
('${def:date}'::date+((select totalday from cc_card WHERE code = ${fld:cardcode} 
and org_id = ${fld:unionorgid} and status=2 and starttype=1 and isgoon=0)||' d')::interval+((select giveday from cc_card WHERE code = ${fld:cardcode} 
and org_id = ${fld:unionorgid} and status=2 and starttype=1 and isgoon=0)||' d')::interval)::date,';',get_arr_value(relatedetail,7),';',
get_arr_value(relatedetail,8),';',get_arr_value(relatedetail,9),';',
get_arr_value(relatedetail,10),';',get_arr_value(relatedetail,11),';',
get_arr_value(relatedetail,12),';',get_arr_value(relatedetail,13),';',
get_arr_value(relatedetail,14),';',get_arr_value(relatedetail,15),';',
get_arr_value(relatedetail,16),';',get_arr_value(relatedetail,17),';',
get_arr_value(relatedetail,18),';',get_arr_value(relatedetail,19),';',
get_arr_value(relatedetail,20),';',get_arr_value(relatedetail,21),';',
get_arr_value(relatedetail,22),';',get_arr_value(relatedetail,23),';',
get_arr_value(relatedetail,24),';',get_arr_value(relatedetail,25),';',
get_arr_value(relatedetail,26),';',get_arr_value(relatedetail,27),';',
get_arr_value(relatedetail,28))
where code =
(select contractcode from cc_card WHERE code = ${fld:cardcode} 
and org_id = ${fld:unionorgid} and status=2 and starttype=1 and isgoon=0)
and org_id = ${fld:unionorgid}