select 
	(	
		(select count(1) from cc_hkb_notice
			where status = 2 and org_id = ${def:org})
		+
		(select count(1) from cc_hkb_faq
			where status = 2 and org_id = ${def:org})
	)as favoritesnum 
from dual

