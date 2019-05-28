SELECT
	tuid as inettemptuid,
	cabinettempcode as inettemptname,
	(case when
		status = 0 then '空闲'
		else '占用'
	end) as inettemptstatus,
	status as binstatus
FROM
	cc_cabinettemp
WHERE
	org_id=${def:org} and status!=2
	order by tuid  desc