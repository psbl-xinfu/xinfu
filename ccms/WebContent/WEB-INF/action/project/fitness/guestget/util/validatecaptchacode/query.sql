select count(1) as num 
from cc_captcha 
where mobile = ${fld:mobile} 
and captcha_code = ${fld:captcha_code} 
and continue_time >= {ts '${def:timestamp}'}
