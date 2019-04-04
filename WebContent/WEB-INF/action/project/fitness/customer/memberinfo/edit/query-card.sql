select 
cd.code as cardcode,
ct.name as cardname 
from cc_card cd
LEFT JOIN cc_cardtype ct on cd.cardtype=ct.code
WHERE cd.customercode=${fld:code} and cd.org_id=${def:org}
and cd.isgoon=0 and cd.status=1

