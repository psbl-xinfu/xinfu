insert into cc_thecontact_log(
code,
guestcode,
thecode,
branch_dellogcode,
createdby,
created
)
select 
NEXTVAL('seq_cc_thecontact_log'),
${fld:guestcode},
code,
${seq:currval@seq_cc_branch_dellog},
'${def:user}',
	{ts '${def:timestamp}'}
from cc_thecontact where guestcode=${fld:guestcode} and branchcode=${fld:branchcode}
	