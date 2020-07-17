insert into cc_cardtype
(
   code,
   name,
   type,
   cardcategory,
   bgcolor,
   giveday,
   ptcount,
   mealdiscount,
   drinkdiscount,
   jsdiscount,
   swimdiscount,
   singlediscount,
   classdiscount,
   count,
   daycount,
   remark,
   opencarddeadline,
   moneyleft, --储值金额
   org_id,
   maxusernum --几人
)
values 
(
	${seq:nextval@seq_cc_cardtype},
    ${fld:vc_name},
    ${fld:vc_cardcategory},
    ${fld:vc_type},
    ${fld:vc_color},
    ${fld:vc_giveday},
    ${fld:vc_ptcount},
    (case when ${fld:vc_mealdiscount} is null then 0 else ${fld:vc_mealdiscount}/100.0 end),
    (case when ${fld:vc_drinkdiscount} is null then 0 else ${fld:vc_drinkdiscount}/100.0 end),
    (case when ${fld:vc_jsdiscount} is null then 0 else ${fld:vc_jsdiscount}/100.0 end),
    (case when ${fld:vc_swimdiscount} is null then 0 else ${fld:vc_swimdiscount}/100.0 end),
    (case when ${fld:vc_singlediscount} is null then 0 else ${fld:vc_singlediscount}/100.0 end),
    (case when ${fld:vc_classdiscount} is null then 0 else ${fld:vc_classdiscount}/100.0 end),
    ${fld:count},
    ${fld:daycount},
    ${fld:vc_remark},
    ${fld:opencarddeadline},
    ${fld:moneyleft},
	${def:org},
	${fld:vc_maxusernum}
	
)
