insert into cc_branch_dellog(
	code,
  	guestcode,
	branchcode,
	storename,
	address,
	ystorename,
	yaddress,
	states,
	createdtime, --人的id
  	createdby, --操作人
  	created--操作时间
)
select NEXTVAL('seq_cc_branch_dellog'),
	${fld:guestcode},
	${fld:branchcode},
	cc_branch.storename ,
	cc_branch.address ,
	cc_branch.storename,
	cc_branch.address ,
	0,
	cc_branch.created,
    '${def:user}',
	{ts '${def:timestamp}'}
from cc_branch where code=${fld:branchcode}