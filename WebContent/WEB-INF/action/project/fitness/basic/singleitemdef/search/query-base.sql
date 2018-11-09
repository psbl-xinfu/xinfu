select
    concat('<input type="checkbox" class="duoxuan" name="danxuan" value="', code, '">') as application_id,
	code,
    fastcode,
    name,
    type,
    unit,
    price,
    remark,
    status,
    isliliao,
    commission,
    (CASE type WHEN 0 THEN '收入'  WHEN 1 THEN '税收' WHEN 2 THEN '未分类' END) as type,
    (CASE unit WHEN 0 THEN '次'  WHEN 1 THEN '张' END) as unit,
    (CASE status WHEN 0 THEN '无效'  WHEN 1 THEN '有效' END) as status,
    (CASE isliliao WHEN 0 THEN '否'  WHEN 1 THEN '是' 	 END) as isliliao
from cc_singleitemdef
where 1=1 
	and org_id = ${def:org}
${filter}
order by code desc
