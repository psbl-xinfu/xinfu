select 1 from dual where
(select reatetype from cc_ptdef where reatetype=${fld:reatetype} 
and org_id=${def:org} limit 1)=1	