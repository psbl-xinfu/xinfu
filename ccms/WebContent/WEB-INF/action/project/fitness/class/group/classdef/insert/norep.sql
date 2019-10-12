select 1 from cc_classroom where code=${fld:classroomcode} and org_id=${def:org}
and limit_num<${fld:mincount}