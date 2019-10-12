SELECT 
(select  name from cc_customer where code=${fld:customercode} and org_id=${def:org}) as name,
(select  mobile from cc_customer where code=${fld:customercode} and org_id=${def:org}) as mobile,
 COALESCE((select name from cc_customer where code=recommend and org_id=${def:org}),'') as recommend,
salemember,
salemember1,
get_arr_value(relatedetail,3) as cardtype,
get_arr_value(relatedetail,9) as starttype,
get_arr_value(relatedetail,11) as giveday,
get_arr_value(relatedetail,8) as ptnum,
inimoney,
 COALESCE(campaigncode,'') as campaigncode,
get_arr_value(relatedetail,16) as campaignprice,
 COALESCE(stage_times,0) as stage_times,
normalmoney,
COALESCE(factmoney,0) as factmoney,
 COALESCE(remark,'') as remark,
 
  COALESCE(stage_times_pay,0) as stage_times_pay,
  COALESCE(stagemoney,0) as stagemoney,
  
  (
  select COALESCE(sum(factmoney),0) from cc_contract c where  c.relatecode=cc_contract.code and c.org_id=${def:org}
  )as sumprice,
  
  
  (SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =(select user_id from cc_customer where code=${fld:customercode} and  cc_customer.org_id=${def:org} )
		 )as headpic
  
FROM cc_contract
where code=${fld:contractcode}
and org_id=${def:org}

