select 1 from dual where
(select (case when proname=${fld:vc_name} then 0 
else 1 end) from cc_product where  
code=${fld:vc_code} and org_id=${def:org}) =1	