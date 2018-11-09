select 1 from dual where 1=1 and
(case when ${fld:new_vc_code} is null then 1=2 else (
	select count(1) from cc_cardcode where cardcode = ${fld:new_vc_code} and cardcode!=${fld:cardcode} and org_id = ${def:org}
) > 0 end)
