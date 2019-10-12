select 1 from dual
where (select (factmoney+(select (case when sum(factmoney) is null then 0 else sum(factmoney) end) from cc_chargecard where parentcode = f.code and org_id = ${def:org})) from cc_chargecard f 
	where f.code = ${fld:vc_code} and f.org_id = ${def:org})<${fld:moneycash}
