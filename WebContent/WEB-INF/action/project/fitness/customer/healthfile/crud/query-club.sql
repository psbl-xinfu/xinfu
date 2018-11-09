select 
   tenantry_id AS vc_code,
   vc_fullname
from t_tenantry 
WHERE is_closed = '0'