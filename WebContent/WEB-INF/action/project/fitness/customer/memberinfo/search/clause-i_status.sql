  AND (
  	case when ${fld:i_status} = 1 
  		then exists(
				select 1 from cc_card where isgoon=0 and  status = 1 
				and customercode = r.code
			)
  	when ${fld:i_status} = 2 
  		then exists(
				select 1 from cc_card where isgoon=0 and status = 2 
				and customercode = r.code
			)
  	when ${fld:i_status} = 3 
  		then exists(
				select 1 from cc_card where isgoon=0 and status = 3 
				and customercode = r.code
			)
  	when ${fld:i_status} = 4 
  		then exists(
				select 1 from cc_card where isgoon=0 and status = 5 
				and customercode = r.code
			)
  	when ${fld:i_status} = 5 
  		then exists(
				select 1 from cc_card where isgoon=0 and status = 4 
				and customercode = r.code
			)
  	when ${fld:i_status} = 6 
  		then exists(
				select 1 from cc_card where isgoon=0 and status = 6 
				and customercode = r.code
			)
  	when ${fld:i_status} = 7 
  		then exists(
				select 1 from cc_card where isgoon=0 and status = 1 
				and customercode = r.code and  enddate BETWEEN ${fld:_start_date} and ${fld:_end_date}
			)
	when ${fld:i_status} = 0 
  		then exists(
				select 1 from cc_card where isgoon=0 and status = 0 
				and customercode = r.code
			)
  	else true end
  )