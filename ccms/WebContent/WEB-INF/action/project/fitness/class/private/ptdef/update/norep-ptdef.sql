--zyb 20190428 体验课验证修改
select 1 from dual where
(select reatetype from cc_ptdef where reatetype=${fld:reatetype} 
and org_id=${def:org} and (case when 
(select reatetype from cc_ptdef where code=${fld:code} and org_id=${def:org})='1' then null=null 
else 1=1
 end) limit 1)=1	