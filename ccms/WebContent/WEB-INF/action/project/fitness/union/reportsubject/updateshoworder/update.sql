update cc_report_subject
set showorder = ${fld:exchange_showorder}
where tuid = ${fld:tuid} and org_id = ${def:org}

