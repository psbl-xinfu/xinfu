select
code,
enrollname,
(select count(1) from cc_market_campaign_votelog log where  log.enrollcode=cc_market_campaign_enroll.code and org_id=${def:org})as num,
(SELECT 
			case when headpic is  null then '/images/icon_head.png' else headpic end
 FROM hr_staff WHERE user_id =(select user_id from cc_customer where mobile=cc_market_campaign_enroll.mobile )
 )as headpic
from
cc_market_campaign_enroll
where
 status=2 and org_id=${def:org} 
 
 order by num desc