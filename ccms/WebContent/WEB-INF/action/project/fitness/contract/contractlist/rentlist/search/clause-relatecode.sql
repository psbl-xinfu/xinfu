and
	(c.code in ( ${fld:relatecode} , 
		(select (case when ct.relatecode is not null then ct.relatecode else ${fld:relatecode}  end) from 
cc_contract ct where ct.code=${fld:relatecode} and ct.org_id=c.org_id))
or c.relatecode=${fld:relatecode})