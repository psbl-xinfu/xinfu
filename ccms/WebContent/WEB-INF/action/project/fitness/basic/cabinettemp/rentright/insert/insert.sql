insert into cc_cabinettemp
(
tuid,
cabinettempcode,
createdby,
created,
groupid,
org_id
)
values
(
${seq:nextval@seq_cc_cabinettemp},
${fld:startcode_r},
'${def:user}',
{ts'${def:timestamp}'},
${fld:group_r},
${def:org}
)