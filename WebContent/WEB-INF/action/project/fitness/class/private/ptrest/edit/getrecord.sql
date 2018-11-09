select
   code,
   ptlevelcode,--'类型名称'
   ptleftcount,--余额
   ptenddate,--有效日期
   cardcode,--用户账号 
   ptid as iuser,--教练姓名  
   created 阿三itime,--销售日期
   ptfee,--原价
   ptfactfee,--成交价
   scale,--提成金额
   name,--会员姓名
   pttype,--购课类型 1新买课、2场地开发、3续课、4转课、5赠课';
   pttotalcount,--原始节数
   ptnormalmoney,--总原价金额
   ptmoney--总成交金额
from cc_ptrest
where code=${fld:id} and org_id = ${def:org}