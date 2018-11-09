insert into et_term_score
(
    tuid,
    termid,
    term_date,
    term_score,
    userlogin
)
values 
(
	${seq:nextval@seq_et_term_score},
    ${fld:termid},
    '${def:date}',
    ${fld:term_score},	
    '${def:user}'
)
