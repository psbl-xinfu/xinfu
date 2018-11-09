select 
   tenantry_id AS vc_code,
   vc_fullname
from t_tenantry 
WHERE grade != 1 AND is_closed = '0' AND enabled = '1' 