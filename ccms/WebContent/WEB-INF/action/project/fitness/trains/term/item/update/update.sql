UPDATE et_term_item SET 
item_name=${fld:item_name},
item_score=${fld:item_score},
showorder=${fld:showorder},
updatedby='${def:user}',
updated={ts '${def:timestamp}'}
WHERE tuid=${fld:tuid};