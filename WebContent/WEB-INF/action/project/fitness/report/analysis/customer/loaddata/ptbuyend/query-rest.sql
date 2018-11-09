SELECT 
	(
		select 
			count(1)
		from cc_customer cust
		where org_id = ${def:org} and 
		EXISTS(
			select 1 from cc_ptrest rest
			left join cc_ptdef pd on rest.ptlevelcode = pd.code and rest.org_id = pd.org_id
			where (rest.ptenddate is null or (rest.ptenddate>=${fld:fdate} and rest.ptenddate<=${fld:tdate}))
			and pd.reatetype=0 and rest.customercode = cust.code and rest.ptleftcount>0 and cust.org_id = rest.org_id
		)
	) AS inperformcust--在执行私教会员
	,(
		select 
			count(1)
		from cc_customer cust
		where org_id = ${def:org} and 
		EXISTS(
			select 1 from cc_ptrest rest
			left join cc_ptdef pd on rest.ptlevelcode = pd.code and rest.org_id = pd.org_id
			where (rest.ptenddate is null or (rest.ptenddate>=${fld:fdate} and rest.ptenddate<=${fld:tdate}))
			and pd.reatetype=0 and rest.customercode = cust.code and rest.ptleftcount>0 and cust.org_id = rest.org_id
			and rest.ptenddate<'${def:date}'::date
		)
	) AS overduecust--私教过期会员
	,(
		select 
			count(1)
		from cc_customer cust
		where org_id = ${def:org} and 
		NOT EXISTS(
			select 1 from cc_ptrest rest
			left join cc_ptdef pd on rest.ptlevelcode = pd.code and rest.org_id = pd.org_id
			where (rest.ptenddate is null or (rest.ptenddate>=${fld:fdate} and rest.ptenddate<=${fld:tdate}))
			and pd.reatetype=0 and rest.customercode = cust.code and cust.org_id = rest.org_id
		)
	) AS nobuycust --未购买私教会员
FROM dual