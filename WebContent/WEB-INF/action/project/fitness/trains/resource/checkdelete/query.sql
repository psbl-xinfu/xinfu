select count(1) as class_num 
from et_class 
where resourceid = ${fld:tuid} 
and status = 1
