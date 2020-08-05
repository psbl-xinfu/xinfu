insert into cc_thecontact_log
(
 	code 
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
values 
(
	${seq:nextval@seq_cc_thecontact_log},
   	
	'${def:user}',
	{ts '${def:timestamp}'},
)


