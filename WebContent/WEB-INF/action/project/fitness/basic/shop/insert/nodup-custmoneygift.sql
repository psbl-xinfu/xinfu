select 1 from cc_customer
where ${fld:othertype}='2' and code = ${fld:custcode} and ${fld:othermoney} = '2'
and (moneygift<${fld:getmoney} or moneygift is null) and org_id = ${def:org}