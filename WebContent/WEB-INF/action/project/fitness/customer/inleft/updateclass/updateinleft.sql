UPDATE cc_inleft set
	callparparecode=${fld:cpcode},
	classdefcode=(select code from  cc_classdef
	where code=(select classcode from cc_classlist where code=
	(select classlistcode from cc_classprepare where code =${fld:cpcode}))
	and org_id=${def:org}
	)
WHERE
	code = ${fld:incode} and org_id = ${def:org}