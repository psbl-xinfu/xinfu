update cc_report_subject
set showorder = ${fld:showorder}
where tuid = ${fld:exchange_tuid} and org_id = ${def:org}
