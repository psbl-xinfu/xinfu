  AND (
  	case when ${fld:daochui_status} = 1 
  		then exists(
				select 1 from cc_card where status = 1 
				and customercode = r.code
			)
  	when ${fld:daochui_status} = 2 
  		then exists(
				select 1 from cc_card where status = 2 
				and customercode = r.code
			)
  	when ${fld:daochui_status} = 3 
  		then exists(
				select 1 from cc_card where status = 3 
				and customercode = r.code
			)
  	when ${fld:daochui_status} = 4 
  		then exists(
				select 1 from cc_card where status = 4 
				and customercode = r.code
			)
  	when ${fld:daochui_status} = 5 
  		then exists(
				select 1 from cc_card where status = 5 
				and customercode = r.code
			)
  	when ${fld:daochui_status} = 6 
  		then exists(
				select 1 from cc_card where status = 6 
				and customercode = r.code
			)
  	when ${fld:daochui_status} = 0 
  		then exists(
				select 1 from cc_card where status = 0 
				and customercode = r.code
			)
  	else true end
  )