select 1 from cc_savestopcard
where cardcode = ${fld:cardcode} and org_id = ${def:org}
and status=10