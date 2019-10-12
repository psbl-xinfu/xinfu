select 1 
from dual 
where (select count(1) from cc_card 
where code = ${fld:cardcode} and org_id = ${def:org} and isgoon=0)=0