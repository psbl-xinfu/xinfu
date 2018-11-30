update cc_ptrest set ptlevelcode=${fld:courseid},ptid=${fld:ptid},org_id=${fld:orgid}
 where code=${fld:codeid} and org_id = ${def:org}