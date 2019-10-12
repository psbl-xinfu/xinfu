select 1 from dual where
((
select count(1) from cc_return_log
where (case 
	when ${fld:cust_type}='0' then pk_value = ${fld:guestcode}
	when ${fld:cust_type}='1' then pk_value = ${fld:customercode}
	end)
and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
and (commcode is null or commcode='') and org_id =${def:org})=0
or
(select count(1) from cc_return_log
where (case 
	when ${fld:cust_type}='0' then pk_value = ${fld:guestcode}
	when ${fld:cust_type}='1' then pk_value = ${fld:customercode}
	end) and org_id = ${def:org})<1
)