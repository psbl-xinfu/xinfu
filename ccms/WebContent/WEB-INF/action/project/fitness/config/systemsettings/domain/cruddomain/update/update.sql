update t_domain set 
	domain_value= ${fld:domain_value},
	domain_text_cn= ${fld:domain_text_cn},
	domain_text_en= ${fld:domain_text_en},
	remark= ${fld:remark}
where tuid = ${fld:tuid};
