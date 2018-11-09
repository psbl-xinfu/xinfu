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
(
select  
  ${seq:nextval@seq_cc_cabinet},
  ${fld:cabinetcode},
 '${def:user}',
 {ts'${def:timestamp}'},
 ${fld:groupid},
  ${fld:price},
  ${def:org}
from
dual
where  (select count(1) from cc_cabinet where  cabinetcode=${fld:cabinetcode}) =0
)