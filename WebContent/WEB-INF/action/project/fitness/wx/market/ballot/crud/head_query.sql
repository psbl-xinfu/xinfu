  SELECT 
		(case when headpic is null then '/images/icon_head.png' else headpic end
 )as headpic
 FROM hr_staff WHERE user_id =(select user_id from cc_market_campaign_enroll where code=${fld:id})
