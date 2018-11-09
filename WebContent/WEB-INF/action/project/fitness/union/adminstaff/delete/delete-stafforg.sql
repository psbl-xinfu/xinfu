delete from  hr_staff_org
where user_id::varchar in (
	select regexp_split_to_table(${fld:id}, ';')
)