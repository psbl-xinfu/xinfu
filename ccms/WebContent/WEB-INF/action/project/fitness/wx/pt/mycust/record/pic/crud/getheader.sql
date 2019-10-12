 SELECT 
	case when headpic is null then '/images/icon_head.png' else headpic end as  headpic,
	(select name from cc_customer where code=${fld:customercode}) as name
	 FROM hr_staff 
	 WHERE user_id =(select user_id from cc_customer where code=${fld:customercode} )
