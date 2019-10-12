delete from cc_trainplan_detail_group
where detailcode in (select code from cc_trainplan_detail
where trainplancode = ${fld:code} and org_id=${def:org})
 and org_id=${def:org}

