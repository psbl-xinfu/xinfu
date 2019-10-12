SELECT 
	name
	,concat((case when totalnums=0 then 0.00 else ((freenum+feenum)/totalnums*100)::NUMERIC(10, 2) end), '%') as haokelv--耗课率
	,concat((case when finishnum=0 then 0 else cknum*100/finishnum end)::NUMERIC(10, 2), '%') as cknum--场开成交率
	,expernum
	,p1custnum
	,p1num
	,p2custnum
	,p2num
	,finishnum
	,totalfee
	,avgfee
	,(case when rate>100 then 100.00 when rate<-100 then -100.00 else rate end) as rate
	,(case when pos>100 then 100.00 when pos<-100 then -100.00 else pos end) as pos
	,(case when p1>100 then 100.00 when p1<-100 then -100.00 else p1 end) as p1
	,(case when p2>100 then 100.00 when p2<-100 then -100.00 else p2 end) as p2
	,income 
	,(case when firstcttn>100 then 100.00 when firstcttn<-100 then -100.00 else firstcttn end) as firstcttn
FROM (
	SELECT 
		name
		,COALESCE(freenum,0) as freenum--体验课
		,COALESCE(feenum,0) as feenum--收费课
		,COALESCE(totalnums,0) as totalnums--总课时
		,expernum
		,p1custnum
		,p1num
		,p2custnum
		,p2num
		,finishnum
		,totalfee
		,COALESCE(cknum, 0) as cknum--场开量
		,(totalfee::numeric(10,2)/(CASE WHEN finishnum IS NULL OR finishnum <= 0 THEN 1 ELSE finishnum END)::numeric(10,2))::numeric(10,2) AS avgfee
		,(finishnum::numeric(10,2)/(CASE WHEN expernum IS NULL OR expernum <= 0 THEN 1 ELSE expernum END)::numeric(10,2)*100)::numeric(10,2) AS rate
		,(finishnum::numeric(10,2)/(CASE WHEN expernum IS NULL OR expernum <= 0 THEN 1 ELSE expernum END)::numeric(10,2)*100)::numeric(10,2) AS pos
		,(p1custnum::numeric(10,2)/(CASE WHEN p1num IS NULL OR p1num <= 0 THEN 1 ELSE p1num END)::numeric(10,2)*100)::numeric(10,2) AS p1
		,(p2custnum::numeric(10,2)/(CASE WHEN p2num IS NULL OR p2num <= 0 THEN 1 ELSE p2num END)::numeric(10,2)*100)::numeric(10,2) AS p2
		,(finishnum::numeric(10,2)*(
			finishnum::numeric(10,2)/(CASE WHEN expernum IS NULL OR expernum <= 0 THEN 1 ELSE expernum END)::numeric(10,2)
		)*(
			totalfee::numeric(10,2)/(CASE WHEN finishnum IS NULL OR finishnum <= 0 THEN 1 ELSE finishnum END)::numeric(10,2)
		))::numeric(10,2) AS income,
		firstcttn
	FROM (
		SELECT 
			f.name
			,(
				SELECT COUNT(1) 
				FROM cc_ptlog g 
				INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
				WHERE g.created::date >= ${fld:listfdate} AND g.created::date <= ${fld:listtdate} 
				AND p.pttype = 5 AND f.userlogin = g.ptid AND g.org_id = ${def:org} 
			) AS expernum
			,(
				SELECT COUNT(1)
				FROM cc_ptlog g 
				INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
				WHERE g.created::date >= ${fld:listfdate} AND g.created::date <= ${fld:listtdate} 
				AND p.pttype = 5 AND f.userlogin = g.ptid AND g.org_id = ${def:org} 
				AND NOT EXISTS(
					SELECT 1 FROM cc_ptlog g2 
					WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
					AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
				) 
			) AS p1custnum
			,(
				SELECT COUNT(1) 
				FROM cc_contract  
				WHERE createdate >= ${fld:listfdate} AND createdate <= ${fld:listtdate} 
				AND contracttype = 0 AND type = 2 
				AND (f.userlogin = salemember OR f.userlogin = salemember1) 
				AND org_id = ${def:org} AND status >= 2
			) AS p1num
			,(
				SELECT COUNT(1) 
				FROM cc_ptlog g 
				INNER JOIN cc_ptrest p ON p.code = g.ptrestcode AND g.org_id = p.org_id 
				WHERE g.created::date >= ${fld:listfdate} AND g.created::date <= ${fld:listtdate} 
				AND p.pttype = 5 AND f.userlogin = g.ptid AND g.org_id = ${def:org} 
				AND EXISTS(
					SELECT 1 FROM cc_ptlog g2 
					WHERE g2.customercode = g.customercode AND g2.org_id = g.org_id 
					AND g2.ptrestcode = g.ptrestcode AND g2.code != g.code
				) 
			) AS p2custnum
			,(
				SELECT COUNT(1) 
				FROM cc_contract  
				WHERE createdate >= ${fld:listfdate} AND createdate <= ${fld:listtdate} 
				AND contracttype = 0 AND type = 2 
				AND (f.userlogin = salemember OR f.userlogin = salemember1) 
				AND org_id = ${def:org} AND status >= 2
			) AS p2num
			,(
				SELECT COUNT(1) FROM cc_contract t 
				WHERE t.createdate >= ${fld:listfdate} AND t.createdate <= ${fld:listtdate} 
				AND t.contracttype = 0 AND t.type = 2 
				AND (f.userlogin = t.salemember OR f.userlogin = t.salemember1) 
				AND t.org_id = f.org_id AND t.status >= 2
			) AS finishnum
			,COALESCE((
				SELECT SUM(normalmoney) FROM cc_contract t 
				WHERE t.createdate >= ${fld:listfdate} AND t.createdate <= ${fld:listtdate} 
				AND t.contracttype = 0 AND t.type = 2
				AND (f.userlogin = t.salemember OR f.userlogin = t.salemember1) 
				AND t.org_id = f.org_id AND t.status >= 2 
			),0.0) AS totalfee 
			,(
				select 
					sum(case when d.reatetype = 1 then 1 else 0 end) as freenum--体验课
				from cc_ptlog p 
				inner join cc_ptdef d on d.code = p.ptlevelcode and p.org_id = d.org_id
				where p.status != 0 and p.org_id = ${def:org} and p.ptid=f.userlogin
			) AS freenum
			,(
				select 
					sum(case when d.reatetype = 0 then 1 else 0 end) as feenum--收费课
				from cc_ptlog p 
				inner join cc_ptdef d on d.code = p.ptlevelcode and p.org_id = d.org_id
				where p.status != 0 and p.org_id = ${def:org} and p.ptid=f.userlogin
			) AS feenum
			,(select sum(t.totalnum) from(
					select 
						sum(COALESCE(get_arr_value(c.relatedetail,2)::int,0)) as totalnum 
					from cc_contract c 
					where c.contracttype = 0 and c.type = 2 and c.status >= 2 and c.org_id = ${def:org} and c.salemember = f.userlogin
					union all 
					select 
						sum(COALESCE(get_arr_value(c.relatedetail,2)::int,0)) as totalnum 
					from cc_contract c 
					where c.contracttype = 0 and c.type = 2 and c.status >= 2 and c.org_id = ${def:org} 
					and c.salemember1 is not null and c.salemember1 != '' and c.salemember1 = f.userlogin
				) t
			) AS totalnums
			,(
				SELECT COUNT(1) FROM cc_contract t 
				WHERE t.createdate >= ${fld:listfdate} AND t.createdate <= ${fld:listtdate} 
				AND t.contracttype = 0 AND t.type = 2 
				AND (f.userlogin = t.salemember OR f.userlogin = t.salemember1) 
				AND t.org_id = f.org_id AND t.status >= 2
				AND t.source = '3'
			) AS cknum
			,( 
				select 
					(case when count(1)=0 then 0 else sum(case when cttn.iscttn = 1 then 1 else 0 end)*100/count(1) end)::NUMERIC(10, 2)
				from
				(SELECT 
					t.customercode,
					(
						CASE WHEN (
							SELECT p1.created::date FROM cc_ptrest p1 
							INNER JOIN cc_ptdef d1 ON d1.code = p1.ptlevelcode AND d1.org_id = p1.org_id 
							WHERE p1.customercode = t.customercode AND p1.org_id = t.org_id AND d1.reatetype != 1 
							and p1.ptid = f.userlogin
							ORDER BY p1.created OFFSET 1 LIMIT 1
						) BETWEEN ${fld:listfdate} AND ${fld:listtdate} THEN 1 ELSE 0 END
					) AS iscttn 
				FROM (
					SELECT DISTINCT p.customercode, p.org_id  
					FROM cc_ptrest p 
					INNER JOIN cc_ptdef d ON d.code = p.ptlevelcode AND d.org_id = p.org_id 
					WHERE p.created::date <= ${fld:listtdate} 
					and p.ptid = f.userlogin
					AND d.reatetype != 1 AND p.org_id = ${def:org}
				) AS t) as cttn) as firstcttn
		FROM hr_staff f 
		WHERE 1=1 
		
		${filter}
		
		AND f.org_id = ${def:org} and f.status = 1 AND EXISTS(
			SELECT 1 FROM hr_staff_skill fk 
			INNER JOIN hr_skill k ON k.skill_id = fk.skill_id 
			WHERE f.user_id = fk.user_id AND k.skill_scope IN ('1','4') 
		)
	) AS t1
) AS t2 
ORDER BY income DESC
