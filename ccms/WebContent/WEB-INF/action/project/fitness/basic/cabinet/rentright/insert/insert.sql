insert into cc_cabinet
(
tuid,
cabinetcode,
createdby,
created,
groupid,
price,
org_id
)
values
(
${seq:nextval@seq_cc_cabinet},
${fld:startcode_r},
'${def:user}',
{ts'${def:timestamp}'},
${fld:group_r},
${fld:price_r},
${def:org}
)