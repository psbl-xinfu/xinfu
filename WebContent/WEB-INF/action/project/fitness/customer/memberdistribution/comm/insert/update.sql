update cc_public
set grabtime={ts '${def:timestamp}'}
 where customercode=${fld:custode} and org_id=${def:org}