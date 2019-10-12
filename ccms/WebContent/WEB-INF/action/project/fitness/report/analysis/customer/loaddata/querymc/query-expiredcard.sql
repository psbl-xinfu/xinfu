select count(1) as expiredcardnum
from cc_card where isgoon = 0 and status!=0
and enddate>${fld:fdate} and enddate<${fld:tdate}
and org_id = ${def:org}