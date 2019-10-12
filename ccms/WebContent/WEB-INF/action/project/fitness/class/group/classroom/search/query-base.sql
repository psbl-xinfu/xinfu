select
	concat('<input type="checkbox" class="duoxuan" name="danxuan" value="', code, '">') as application_id,
	code,
	classroom_name,
	area,
	room_type,
	limit_num,
	remark,
	(case status when 1 then '已启用' when 0 then '已禁用' else '' end) status,
	(case ispreparedevice when 1 then '<button type="button" class="btn btn-info btn-md btn_ispreparedevice" code="'||code||'" >预约设备</button>' else ' ' end) ispreparedevice,      
	created
from cc_classroom
where  1=1 and org_id = ${def:org}
${filter}
${orderby}

