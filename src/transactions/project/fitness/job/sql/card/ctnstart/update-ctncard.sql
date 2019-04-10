--zzn 2019-04-10取俱乐部编号
with title as 
(select hr_org.memberhead from hr_org  where hr_org.org_id= ${fld:org_id} )

UPDATE cc_card a 
SET 
	passwd = b.passwd
	,startdate = (
		CASE WHEN a.starttype = 0 THEN b.enddate + interval '1 day' ELSE a.startdate END
	)
	,enddate = (
		CASE WHEN a.starttype = 0 THEN b.enddate + concat((1 + a.totalday + COALESCE(a.giveday,0)),' day')::interval ELSE a.enddate END
	)
	,status = 1
	,isgoon = 0 
FROM cc_card b 
WHERE a.code = ${fld:code} AND a.org_id = ${fld:org_id} AND a.code = b.code AND a.org_id = b.org_id 
AND a.isgoon = 1 AND b.isgoon = -1 
--zzn 2019-04-10 取待续卡合同编号中最小的
and a.contractcode= 
(select concat((select * from title), min(substring(cd.contractcode from E'([0-9]+)')::NUMERIC)::VARCHAR) from cc_card cd where cd.code= a.code and cd.isgoon = 1)
--zzn 2019-04-10 取已续卡合同编号中最小的
and b.contractcode= 
(select concat((select * from title), max(substring(cd.contractcode from E'([0-9]+)')::NUMERIC)::VARCHAR) from cc_card cd where cd.code= a.code and cd.isgoon = -1)
