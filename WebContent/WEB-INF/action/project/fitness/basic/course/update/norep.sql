select 1 from dual where
(select (case when courname=${fld:vc_name} then 0 
else 1 end) from cc_course where  
code=${fld:vc_code} and org_id=${def:org}) =1	