SELECT 
name,
mobile,
guestcode,
(SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =cc_customer.user_id
		 )as headpic
FROM cc_customer
where code=${fld:code}
and org_id=${def:org}

