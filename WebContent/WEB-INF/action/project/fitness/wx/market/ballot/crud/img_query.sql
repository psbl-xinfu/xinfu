select tuid 
from t_attachment_files 
where pk_value=
(
select c.code from cc_customer c 
inner join cc_market_campaign_enroll e on c.mobile = SUBSTR (e.createdby, 3, 20) and c.org_id = e.org_id 
where e.code = ${fld:id}
)
and table_code='cc_customer' 


