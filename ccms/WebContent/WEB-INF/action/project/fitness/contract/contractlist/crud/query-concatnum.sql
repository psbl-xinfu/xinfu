select 	
	(select count(1) from cc_contract c where  c.org_id=${def:org}
	and (c.type=0 or c.type = 5) 
	and
	(
	contracttype=0
	or
	contracttype=3
	) 
	and c.status != 0 
	) as cardnum,
	
	(select count(1)  from cc_contract c where  c.org_id=${def:org}
	and c.contracttype in (1,2) 	and c.status != 0 ) as upgradenum,
	
	(select count(1)  from cc_contract c where  c.org_id=${def:org}
	and c.type =2
	and
	(
	contracttype=0
	or
	contracttype=3
	)
	and c.status != 0 
	) as ptnum,

	(select count(1) from cc_contract c where  c.org_id=${def:org}
		and c.type=4
		and
		(
		contracttype=0
		or
		contracttype=3
		)
		and c.status!=0
	) as retreatnum,
	
	(select count(1) from cc_contract c where  c.org_id=${def:org}
	and 
	(c.type = 7 OR c.type = 9 OR c.type = 11))as continuenum,

	(select count(1)  from cc_contract c where  c.org_id=${def:org}	
		and c.type=10
		and
		(
		contracttype=0
		or
		contracttype=3
		)
		and c.status != 0 )as turnnum,
		
	(select count(1) from cc_contract c where  c.org_id=${def:org}
		and
		(
		c.type=1
		or
		c.type=12
		)
		and
		(
		contracttype=0
		or
		contracttype=3
		)
		and c.status!=0
		)as rentnum
from dual