insert into cc_thecontact
(
 	code
 	,guestcode
 	,name
 	,sex
 	,mobile
 	,positioncode
	,createdby  --操作人
	,created  --操作时间
	,org_id
	,status
	,birthday
	,remark
	,possibility
	,thecourse
	,mobile2
	,branchcode
	,email
	,trill
	,wechat
)
values 
(
	${seq:nextval@seq_cc_thecontact},
   	${fld:guestttcode},
	${fld:cc_name},
	${fld:cc_sex},
	${fld:cc_mobile},
	${fld:cc_position},
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org},
	0,
	${fld:cc_birth},
	${fld:remark},
	${fld:cc_possibilitys},
	${fld:cc_theproducts},
	${fld:cc_mobile2},
	${fld:cc_branchcode},
	${fld:cc_email},
	${fld:cc_trill},
	${fld:cc_wechat}
)


