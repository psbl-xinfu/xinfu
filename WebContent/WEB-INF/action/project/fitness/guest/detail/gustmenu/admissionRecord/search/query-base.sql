select
(case when itemtype=0 then '区域' when itemtype=1 then '健身' when itemtype=2 then '游泳' when itemtype=3 then '洗浴' 
		  when itemtype=4	 then '团操' else '私教' end
) as itemtype,
cardcode,
(case when bringother=0 then '本人入场' else '带朋友入场' end)  as bringother,
indate,
intime,
inuser,
lefttime,
leftuser,
remark,
signednumber
from 
cc_inleft
where customercode=${fld:id} 
and indate::date >= ${fld:startdate}::date
and indate::date <= ${fld:enddate}::date
and (case when ${fld:cardcode} is null then 1=1 else cardcode = ${fld:cardcode} end)

