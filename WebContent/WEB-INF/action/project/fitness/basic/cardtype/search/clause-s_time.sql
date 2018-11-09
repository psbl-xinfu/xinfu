and 
(
case when ${fld:s_time}=1  then
	exists (
		(select 1 from cc_cardtype_timelimit t  
			where t.cardtype=c.code and t.org_id=${def:org} and c.status=1    )
	)
else 
	not exists (
		(select 1 from cc_cardtype_timelimit t  
			where t.cardtype=c.code and t.org_id=${def:org} and c.status=1 )
	)
end
)