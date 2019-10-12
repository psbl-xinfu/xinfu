UPDATE et_term SET 
term_name=${fld:term_name},
total_score=${fld:total_score},
standard_score=${fld:standard_score},
updatedby='${def:user}',
updated={ts '${def:timestamp}'}
WHERE tuid=${fld:tuid};