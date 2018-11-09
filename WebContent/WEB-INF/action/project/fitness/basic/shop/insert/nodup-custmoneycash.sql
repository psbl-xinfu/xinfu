select 1 from cc_customer
where ${fld:othertype}='2' and code = ${fld:custcode} and ${fld:othermoney} = '1'
and (moneycash<${fld:total} or moneycash is null) and org_id = ${def:org}