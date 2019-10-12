(SELECT 
	g.name as guestname,	-- 潜在会员姓名
	c.name,	-- 会员姓名
	t.code AS contractcode, -- 合同号
	c.mobile,	-- 手机号
	to_char(t.createdate, 'yyyy-MM-dd') || ' ' || to_char(t.createtime,'hh24:mi') AS idate,-- 成交日期
	u2.name AS guest_mc,	-- 潜在客户会籍
	u1.name AS customer_mc,	-- 成交会籍
	g.code AS guestcode,	-- 潜在客户编号
	c.code AS customercode,	-- 客户编号
	t.createdate
FROM cc_customer c 
INNER JOIN cc_guest g ON c.guestcode = g.code and c.org_id = g.org_id
INNER JOIN cc_contract t ON c.code = t.customercode AND (t.type = 0 OR t.type = 5) and c.org_id = t.org_id
LEFT JOIN hr_staff u1 ON c.mc = u1.userlogin and c.org_id = u1.org_id
LEFT JOIN hr_staff u2 ON g.mc = u2.userlogin and g.org_id = u2.org_id
where c.mc != g.mc 
AND (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where hs.org_id = ${def:org} and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.mc = '${def:user}' end)
AND c.org_id = ${def:org}
${filter}
AND t.status >= 2 

union

SELECT 
	g.name as guestname,	-- 潜在会员姓名
	c.name,	-- 会员姓名
	t.code AS contractcode, -- 合同号
	c.mobile,	-- 手机号
	to_char(t.createdate, 'yyyy-MM-dd') || ' ' || to_char(t.createtime,'hh24:mi'),-- 成交日期
	u2.name AS guest_mc,	-- 潜在客户会籍
	u1.name AS customer_mc,	-- 成交会籍
	g.code AS guestcode,	-- 潜在客户编号
	c.code AS customercode,	-- 客户编号
	t.createdate
FROM cc_contract t 
INNER JOIN cc_guest g ON t.relatecode LIKE '%;' || g.code || ';%' and t.org_id = g.org_id
INNER JOIN cc_customer c ON t.customercode = c.code and t.org_id = c.org_id
LEFT JOIN hr_staff u1 ON c.mc = u1.userlogin and c.org_id = u1.org_id
LEFT JOIN hr_staff u2 ON g.mc = u2.userlogin and g.org_id = u2.org_id
where c.mc != g.mc AND (t.type = 0 OR t.type = 5) AND t.status >= 2 
AND (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where hs.org_id = ${def:org} and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else (c.mc = '${def:user}' OR g.mc = '${def:user}') end)
AND t.org_id = ${def:org}
${filter})
${orderby}
