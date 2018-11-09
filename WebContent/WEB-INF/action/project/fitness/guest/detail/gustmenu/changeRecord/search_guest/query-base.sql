select
table_code,--" IS '表代码';
field_code,--" IS '字段代码';
(case field_code when 'name' then '姓名' when 'sex' then '性别' when 'othertel' then '其他电话' when 'mobile' then '手机号码' else field_code end) as field_name,
(case field_code when 'sex' then (case before_value when '0' then '女' when '1' then '男' else '未知' end) else before_value end) as before_value,
(case field_code when 'sex' then (case after_value when '0' then '女' when '1' then '男' else '未知' end) else after_value end) as after_value,
t.createdby,--" IS '操作人';
(select s.name from hr_staff s where s.userlogin = t.createdby) as createdby,
t.created,--" IS '操作时间';
pk_value,--" IS '主键值';
t.remark as t_remark--" IS '操作类型(0-新增,1-修改)';
from  t_table_data_log t
left join cc_guest g on t.pk_value=g.code and g.org_id = '${def:org}' 
where pk_value=${fld:id}
and t.org_id = '${def:org}' 
order by t.tuid desc