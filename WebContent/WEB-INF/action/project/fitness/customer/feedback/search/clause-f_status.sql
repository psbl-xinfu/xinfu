AND (case when ${fld:f_status}='5' 
then (select count(1) from cc_feedback_follow where feedback_id = f.tuid and org_id = ${def:org})<1
else w.status=${fld:f_status} end)
