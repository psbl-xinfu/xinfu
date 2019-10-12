select 
	r.vc_classfeecode
	,r.vc_classname
	,r.c_classdate
	,r.vc_weekday
	,r.vc_classtime
	,r.i_count
	,r.f_perclassmoney
	,r.vc_kqcontact
	,r.f_factmoney
from e_classfee f 
inner join e_classfeerow r on f.vc_code = r.vc_classfeecode 
where f.vc_code = ${fld:vc_code}
