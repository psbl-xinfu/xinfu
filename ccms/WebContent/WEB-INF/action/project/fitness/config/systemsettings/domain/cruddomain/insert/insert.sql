insert into t_domain
(
    tuid,
    domain_value,
    domain_text_cn,
    domain_text_en,
    is_enabled,
    "namespace",
    show_order,
    remark
)
values 
(
	${seq:nextval@seq_domain},
    ${fld:domain_value},
    ${fld:domain_text_cn},
    ${fld:domain_text_en},
    1,
    ${fld:namespace},
    1,
    ${fld:remark}
)
