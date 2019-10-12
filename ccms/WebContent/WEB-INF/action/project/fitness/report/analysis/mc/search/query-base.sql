SELECT 
	name
	,guestnum
	,custnum
	,visitnum
	,msnum
	,yynum
	,finishnum
	,totalfee
	,rate
	,income 
	,avgfee
FROM (
	SELECT 
		name
		,guestnum
		,custnum
		,visitnum
		,msnum
		,yynum
		,finishnum
		,totalfee
		,(totalfee::numeric(10,2)/(CASE WHEN finishnum IS NULL OR finishnum <= 0 THEN 1 ELSE finishnum END)::numeric(10,2))::numeric(10,2) AS avgfee
		,(case when visitnum IS NULL OR visitnum <= 0 then 0 else 
			(finishnum::numeric(10,2)/(CASE WHEN visitnum IS NULL OR visitnum <= 0 THEN 1 ELSE visitnum END)::numeric(10,2)*100)::numeric(10,2) end) AS rate
		,(visitnum::numeric(10,2)*(
			totalfee::numeric(10,2)/(CASE WHEN finishnum IS NULL OR finishnum <= 0 THEN 1 ELSE finishnum END)::numeric(10,2)
		)*(
			finishnum::numeric(10,2)/(CASE WHEN visitnum IS NULL OR visitnum <= 0 THEN 1 ELSE visitnum END)::numeric(10,2)
		))::numeric(10,2) AS income 
	FROM (
		SELECT 
			f.name
			,(
				SELECT COUNT(1) FROM cc_guest g 
				WHERE g.mc = f.userlogin AND g.status != 0 AND g.status != 99 
				and g.created::date >= ${fld:listfdate} AND g.created::date <= ${fld:listtdate}
			) AS guestnum
			,(
				SELECT COUNT(1) FROM cc_customer c 
				WHERE c.mc = f.userlogin AND c.status != 0 AND EXISTS(
					SELECT 1 FROM cc_card d 
					WHERE d.customercode = c.code AND d.org_id = c.org_id 
					AND d.status != 0 AND d.status != 6 
				) and c.created::date >= ${fld:listfdate} AND c.created::date <= ${fld:listtdate} 
			) AS custnum
			,(
				SELECT count(1) FROM cc_guest_visit v 
				WHERE v.created::date >= ${fld:listfdate} AND v.created::date <= ${fld:listtdate} 
				AND f.userlogin = v.mc AND v.org_id = f.org_id AND v.status != 0 
			) AS visitnum
			,(
				select count(1) from cc_guest_visit gv
				where gv.org_id = ${def:org}
				and gv.visitdate::date >= ${fld:listfdate} AND gv.visitdate::date <= ${fld:listtdate} 
				and (gv.preparecode is null or gv.preparecode = '') and gv.status!=0
				AND f.userlogin = gv.mc
			) AS msnum
			,(
				select count(1) from cc_guest_visit gv
				where gv.org_id = ${def:org}
				and gv.visitdate::date >= ${fld:listfdate} AND gv.visitdate::date <= ${fld:listtdate} 
				and gv.preparecode is not null and gv.status!=0
				AND f.userlogin = gv.mc
			) AS yynum
			,(
				SELECT COUNT(1) FROM cc_contract t 
				WHERE t.createdate >= ${fld:listfdate} AND t.createdate <= ${fld:listtdate} 
				AND t.contracttype = 0 AND t.type IN (0,5) 
				AND (f.userlogin = t.salemember OR f.userlogin = t.salemember1) 
				AND t.org_id = f.org_id AND t.status >= 2
			) AS finishnum
			,COALESCE((
				SELECT SUM(normalmoney) FROM cc_contract t 
				WHERE t.createdate >= ${fld:listfdate} AND t.createdate <= ${fld:listtdate} 
				AND t.contracttype = 0 AND t.type IN (0,5) 
				AND (f.userlogin = t.salemember OR f.userlogin = t.salemember1) 
				AND t.org_id = f.org_id AND t.status >= 2 
			),0.0) AS totalfee 
		FROM hr_staff f 
		WHERE 1=1 
		
		${filter}
		
		AND f.org_id = ${def:org} and f.status = 1 AND EXISTS(
			SELECT 1 FROM hr_staff_skill fk 
			INNER JOIN hr_skill k ON k.skill_id = fk.skill_id 
			WHERE f.user_id = fk.user_id AND k.skill_scope IN ('2','4') 
		)
	) AS t1
) AS t2 
ORDER BY income DESC
