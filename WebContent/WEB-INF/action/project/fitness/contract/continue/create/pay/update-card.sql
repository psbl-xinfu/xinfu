update cc_card ka set    
 enddate= date( ka.enddate +  b.chadate),
count=(ka.count + b.count),
nowcount=(ka.nowcount + b.count)
from (select get_arr_value(t.relatedetail, 1) as cardcode,
(age(((CASE get_arr_value(t.relatedetail, 6) WHEN '' THEN NULL ELSE get_arr_value(t.relatedetail, 6) END)::TIMESTAMP ),
 ((CASE get_arr_value(t.relatedetail, 5) WHEN '' THEN NULL ELSE get_arr_value(t.relatedetail, 5) END)::TIMESTAMP)))as chadate,
(SELECT d.count FROM cc_cardtype d WHERE d.code = get_arr_value(t.relatedetail, 3) AND d.org_id = t.org_id) as count
 FROM cc_contract t where t.code = ${fld:contractcode} AND t.org_id = ${def:org} ) as b 
where ka.isgoon='0' and b.cardcode=ka.code