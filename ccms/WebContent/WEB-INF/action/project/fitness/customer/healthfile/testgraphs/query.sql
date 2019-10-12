select to_date(testdate,'yyyy-mm-dd') as c_idate,
       max(jkpg) as i_health
from smtec_health
where 1=1
and
(select code from cc_card where customercode=${fld:vc_custcode} and org_id = ${def:org} and isgoon = 0 )=smtec_health.cardid
and   to_date(testdate,'yyyy-mm-dd')>= (CASE WHEN ${fld:fdate} IS NULL OR ${fld:fdate} = '' THEN NULL ELSE ${fld:fdate} END)::date
GROUP BY to_date(testdate,'yyyy-mm-dd')
ORDER BY to_date(testdate,'yyyy-mm-dd')
