insert into t_table_data_log 
(
    tuid,
    table_code,--" IS '表代码';
    field_code,
    before_value,--" IS '修改前值';
    after_value,--" IS '修改后值';
    createdby,--" IS '操作人';
    created,--" IS '操作时间';
    pk_value,--" IS '主键值';
    remark,
    org_id
)
select
	${seq:nextval@seq_t_table_data_log},
    'cc_guest',
    'sex',
	sex::varchar,
	${fld:cc_sex}::varchar,
	'${def:user}',
	{ts '${def:timestamp}'},
	code,
	NULL,
	'${def:org}'
from cc_guest 
where code = ${fld:cc_code} 
and sex != ${fld:cc_sex}
and org_id='${def:org}'
