select
created,
COALESCE(body_fat,0) as  body_fat,
COALESCE(weight,0)as weight,
COALESCE(lung_capacity,0)as lung_capacity,
COALESCE(weight_index,0)as weight_index ,
COALESCE(static_heart,0)as static_heart,
COALESCE(muscle,0) as muscle,
customercode,
(select name from cc_customer where code=cc_testresult.customercode and cc_customer.org_id=cc_testresult.org_id limit 1) as name,
(SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE user_id =(select user_id from cc_customer where code=customercode and  cc_customer.org_id=cc_testresult.org_id )
		 )as headpic

from 
cc_testresult
where
	code in (
		select regexp_split_to_table(${fld:codes}, ';')
	) 
order by created  desc




