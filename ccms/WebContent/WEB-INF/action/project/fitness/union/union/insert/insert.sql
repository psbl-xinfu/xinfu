insert into t_union
(
    tuid,
    group_name,
    status,
    remark
)
values 
(
	${seq:nextval@seq_t_union},
    ${fld:group_name},
    1,
    ${fld:remark}
)
