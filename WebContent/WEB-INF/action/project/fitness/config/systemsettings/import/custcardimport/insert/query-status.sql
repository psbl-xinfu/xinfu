SELECT (case when count(1)>0 then '1' else '0' end) as thestatus
FROM cc_thecontact tt 
left join cc_guest gt on tt.guestcode=gt.code
WHERE  gt.${field_name}= '${field_value}'
and gt.org_id = ${def:org} and tt.status=1