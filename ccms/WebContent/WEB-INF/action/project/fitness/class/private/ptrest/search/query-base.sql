select
   code,
   ptlevelcode,--'类型名称'
   (select pd.ptlevelname from cc_ptdef pd where pd.code=ptlevelcode and org_id = ${def:org}) as vc_ptlevelname,
   ptleftcount::INTEGER,--余额
   ptenddate,--有效日期
   cardcode,--用户账号 
   (select name from hr_staff where userlogin=ptid) as vc_iuser,--教练姓名  
   created as itime,--销售日期
   ptfee,--原价
   ptfactfee,--成交价
   scale,--提成金额
   (select cust.name from cc_customer cust where cust.code = customercode and cust.org_id = ${def:org}) as name,--会员姓名
   (case pttype when 1 then '新买课'
   when 2 then '场地开发'
   when 3 then '续课'
   when 4 then '转课'
   when 5 then '赠课' else '' end) as i_pttype,--购课类型 1新买课、2场地开发、3续课、4转课、5赠课';
   pttotalcount::INTEGER,--原始节数
   ptnormalmoney,--总原价金额
   ptmoney--总成交金额
from cc_ptrest
where cardcode=${fld:vc_cardcode} and ptleftcount>0 
AND cc_ptrest.org_id = ${def:org}