select
	t.*,
	pd.ptlevelname as ptname,
	hs.name as pt
from
(SELECT
	concat (
		'<label class="am-checkbox"><input type="checkbox"  data-am-ucheck name="datalist" code="',c.status,
		'" value="',c.code,'','" code-cust="',c.customercode,'" code-relate="',COALESCE (c.relatecode, ''),
		'" code-cttype="',c.contracttype,'" code-type="',c. TYPE,'" ></label>'
	) AS application_id,
	c.code,
	m.name,
	m.mobile,
	(
		CASE WHEN isaudit = 1 THEN '未审批'
		WHEN isaudit = 3 THEN '审批拒绝'
		WHEN c.status = 1 THEN '未付款'
		WHEN c.status = 2 THEN '已付款' END
	)::VARCHAR AS i_status,
	get_arr_value(c.relatedetail, 1) as ptdefcode,
	get_arr_value(c.relatedetail, 8) as ptuserlogin,
	get_arr_value(c.relatedetail, 2) AS pttotalcount,--总节数
	c.normalmoney AS normalmoney,
	c.factmoney AS factmoney,
	c.createdate AS created,--签约日期
	 get_arr_value(c.relatedetail, 3) AS ptenddate,--截止日期   
	(SELECT name FROM hr_staff WHERE userlogin = c.salemember) AS salemember,--销售员
	(SELECT name FROM hr_staff WHERE userlogin = c.salemember1) AS salemember1,--销售员
	(SELECT name FROM hr_staff WHERE userlogin = c.createdby) AS createdby,--录入人
	(
		CASE WHEN (c.status = 2 AND c.contracttype != 3 AND c.normalmoney != c.factmoney) THEN '定金'
		WHEN (c.contracttype = 3 AND c.relatecode IS NOT NULL AND c.relatecode != '') THEN '还款'
		ELSE '私教' END
	) AS contracttype,
	c.org_id
FROM cc_contract c 
LEFT JOIN cc_customer m ON m.code = c.customercode AND m.org_id = ${def:org}
WHERE c.org_id = ${def:org}
AND c.type = 2
AND (contracttype = 0 OR contracttype = 3)
AND c.status != 0 

	${filter}

AND (
	CASE WHEN EXISTS (
		SELECT 1 FROM hr_staff_skill hss
		INNER JOIN hr_skill hs ON hss.skill_id = hs.skill_id
		WHERE (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
		AND hss.userlogin = '${def:user}'
		AND hs.data_limit = 1
	) THEN 1 = 1
	ELSE c.salemember = '${def:user}' OR c.salemember1 = '${def:user}' END
)
ORDER BY (CASE WHEN c.updated IS NULL THEN c.createdate ELSE c.updated END) DESC, c.createtime DESC
) as t
left join cc_ptdef pd on pd.code = t.ptdefcode and pd.org_id = t.org_id
left join hr_staff hs on hs.userlogin = t.ptuserlogin
