insert into cc_cabinettemp
(
tuid,
cabinettempcode,
createdby,
created,
groupid,
org_id
)
(
select  
  ${seq:nextval@seq_cc_cabinettemp},
  ${fld:cabinetcode},
 '${def:user}',
 {ts'${def:timestamp}'},
 ${fld:groupid},
  ${def:org}
from
dual
where  (select count(1) from cc_cabinettemp where  cabinettempcode=${fld:cabinetcode} and org_id=${def:org}) =0
)