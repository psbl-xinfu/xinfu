select 1 from cc_losscard
where org_id = ${def:org} and code = ${fld:vc_code}
and (status =2
or (select count(1) from cc_fillcard where cardcode = ${fld:cardcode} and org_id = ${def:org}
		and created>(select startdate from cc_losscard where org_id = ${def:org} and code = ${fld:vc_code}))=1)