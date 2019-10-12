insert into t_union_club
(
	tuid,
	club_id,
	union_id
)
values 
(
	${seq:nextval@seq_t_union_club},
    ${fld:org_id},
    ${fld:unionid}
)
