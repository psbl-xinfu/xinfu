insert into cc_thecontact_log
(
 	code 
 	,thecode
  	,guestcode 
 	,positioncode 
	,possibility
	,thecourse 
	,branchcode 
	
   	,yguestcode 
	 ,ypositioncode 
	 ,ypossibility 
	 ,ythecourse
	 ,ybranchcode 
	
	 ,createdby 
    ,created 
)
select 
	${seq:nextval@seq_cc_thecontact_log}
	,${fld:cc_thecode} 
   	,guestcode 
 	,positioncode 
	,possibility
	,thecourse 
	,branchcode 
	,${fld:cc_guestcode}
	,${fld:cc_position}
	,${fld:cc_possibilitys}
	,${fld:cc_thecourses}
	,${fld:cc_branchcode}
	,'${def:user}'
	,{ts '${def:timestamp}'}

from cc_thecontact
where code=${fld:cc_thecode}
