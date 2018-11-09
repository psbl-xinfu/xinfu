select 1 from cc_expercard_list
where code = ${fld:cardcode} and org_id = ${fld:unionorgid}
and experlimit<${fld:nowcount} and expertype = 1
