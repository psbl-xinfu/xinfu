INSERT INTO et_term_item(
tuid,
questionid,
item_name,
item_score,
showorder,
createdby,
created,
updatedby,
updated
	) VALUES(
	${seq:nextval@seq_et_term_item},
	${fld:questionid},
	${fld:item_name},
	${fld:item_score},
	${fld:showorder},
	'${def:user}',
	{ts '${def:timestamp}'},
	null,
	null
	)