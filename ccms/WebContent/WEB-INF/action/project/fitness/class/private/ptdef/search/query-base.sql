select
    concat('<input type="checkbox" class="duoxuan" name="danxuan" value="', code, '">') as application_id,
	code,
	ptlevelname,
	ptfee,
	(case reatetype when 0 then '否' when 1 then '是' end) as reatetype,
	(case status when 0 then '已禁用' else '已启用' end) as status
from cc_ptdef
where 1=1 and org_id = ${def:org}
${filter}
${orderby}
