SELECT 
	f.tuid,
	(CASE f.fbtype WHEN 0 THEN '意见建议' WHEN 1 THEN '投诉' END) AS fbtype,
   COALESCE(c.name,'匿名') AS name,
   (CASE c.sex WHEN 0 THEN '女' WHEN 1 THEN '男' ELSE '未知' END) AS sex,
   COALESCE(c.mobile,'未知') AS mobile,
   (CASE f.complainttype WHEN '1' THEN '人'
     WHEN '2' THEN '部门'
     WHEN '3' THEN '项目'
     WHEN '4' THEN '环境'
   	 WHEN '5' THEN '其他'
   	 ELSE '未知' END
   ) AS complainttype,
   (CASE w.status WHEN 0 THEN '无效' WHEN 1 THEN '未处理' WHEN 2 THEN '已处理' 
        WHEN 3 THEN '未成功' WHEN 4 THEN '不做处理' ELSE '未分配' END) AS status,
   (CASE w.evalstar WHEN 1 THEN '不满意' WHEN 2 THEN '一般' WHEN 3 THEN '比较满意'
        WHEN 4 THEN '非常满意' ELSE '未知' END) AS evalstar,
   w.remark,
   w.updated,
   w.tuid AS followupid,
   c.code AS customercode,
   (select name from hr_staff where org_id = ${def:org} and userlogin =
   (select followstaff from cc_feedback_follow where feedback_id = f.tuid and org_id = ${def:org} order by created desc limit 1)) as kefu
FROM cc_feedback f 
LEFT JOIN (
	SELECT max(t.tuid) AS tuid, t.feedback_id 
	FROM cc_feedback_follow t WHERE t.org_id = ${def:org} AND t.status > 0 GROUP BY t.feedback_id
) AS p ON f.tuid = p.feedback_id 
LEFT JOIN cc_feedback_follow w ON w.tuid = p.tuid AND f.org_id = w.org_id 
LEFT JOIN cc_customer c ON c.code=f.customercode AND f.org_id = c.org_id 
WHERE f.org_id = ${def:org} AND f.status=1 
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else w.followstaff = '${def:user}' end)
${filter}

    