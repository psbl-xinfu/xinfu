select
	pd.ptlevelname,
	(select name from hr_staff where userlogin = ptp.ptid) as staff_name,
	pd.ptfee,
	pr.ptenddate,
	pr.ptleftcount::int,
	(case when ptp.status=0 then '无效' 
			when ptp.status=1 then '预约中'
			when ptp.status=2 then '已上课'
			when ptp.status=3 then '爽约'
	end) as status,
	concat(ptp.preparedate, ' ', to_char(ptp.starttime, 'HH24:MI'), '-', to_char(ptp.endtime, 'HH24:MI')) as preparedate,
	(case when pr.pttype=1 then '新买课' 
			when pr.pttype=2 then '场地开发'
			when pr.pttype=3 then '续课'
			when pr.pttype=4 then '转课'
			when pr.pttype=5 then '赠课'
	end) as pttype,
	(select name from hr_staff where userlogin = ptp.createdby) as createdby
from cc_ptprepare ptp
left join cc_ptrest pr on ptp.ptrestcode = pr.code and ptp.org_id = pr.org_id
left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
where
	ptp.org_id = ${def:org} and ptp.code = ${fld:ptpcode}
