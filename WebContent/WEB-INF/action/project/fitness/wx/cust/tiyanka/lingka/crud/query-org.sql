select
h.org_name,
i.address,
i.contact_phone
 from
hr_org h 
 left join hr_org_info i on  i.org_id=h.org_id
 where 
 i.org_id = (select org_id from  cc_expercard_list where code=${fld:expercardcode}  )

