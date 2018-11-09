insert into cc_cardtype
(
   code,
   name,
   type,
   cardcategory,
   giveday,
   ptcount,
   maxusernum,
   count,
   daycount,
   remark,
   org_id,
   mealdiscount,
   drinkdiscount,
   jsdiscount,
   swimdiscount,
   singlediscount,
   classdiscount
)
values 
(
	${seq:nextval@seq_cc_cardtype},
    ${fld:name},
    ${fld:type},
    ${fld:cardcategory},
    ${fld:giveday},
    ${fld:ptcount},
    ${fld:maxusernum},
    ${fld:count},
    ${fld:daycount},
    ${fld:remark},
	${def:org},
	0,
	0,
	0,
	0,
	0,
	0
)
