  AND 
  (CASE WHEN v.vc_lastdate IS NOT NULL THEN (current_date - v.vc_lastdate::date) ELSE NULL END) >= ${fld:date}