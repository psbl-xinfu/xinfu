select DISTINCT
	code as sitecode,
	sitename,
	${fld:bcorpc} as bcorpc,
	${fld:guestgroup} as guestgroup,
	${fld:pkvalue} as pkvalue,
	${fld:customername} as customername,
	(case when ${fld:customertype}='0' then (select mobile from cc_guest where code=${fld:pkvalue}) 
	when ${fld:customertype}='1' then (select mobile from cc_customer where code=${fld:pkvalue})
	when ${fld:customertype}='3' then ${fld:mobile} end) as mobile,
	${fld:prepare_date} as prepare_date,
	${fld:yyinputprice} as yyinputprice,
	${fld:customertype} as customertype,
	${fld:yyarr} as yyarr,
	${fld:bcstarttime} as bcstarttime,
	${fld:bcendtime} as bcendtime,
	(case when  ${fld:guestgroupname}='请选择'then '' 
	else ${fld:guestgroupname} end) as guestgroupname 
	 from cc_sitedef 
	 where code=${fld:yyarr}  

