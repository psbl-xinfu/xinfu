--zyb 2019如果值相等就可以修改否则不可以修改
select 1 from dual where
(select (case when isgroup=${fld:isgroup} then 0 
else 1 end) from cc_ptdef where  
code=${fld:code} and org_id=${def:org}) =1	