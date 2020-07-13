insert into t_table_data_log 
(
    tuid,
    table_code,--" IS '表代码';
    before_value,--" IS '修改前值';
    after_value,--" IS '修改后值';
    createdby,--" IS '操作人';
    created,--" IS '操作时间';
    pk_value,--" IS '主键值';
    org_id
)

select
	${seq:nextval@seq_t_table_data_log},
    'cc_guest',
    concat(officeaddr,';',email,';'
			,officetel,';',officename,';'
			,province2,';',city2,';'
			,customtype,';',postcode,';'
			,remark,';'
		),
		concat(${fld:address},';',${fld:cc_email},';'
			,${fld:cc_officetel},';',${fld:company},';'
			,${fld:province2},';',${fld:city2},';'
			,${fld:cc_birth},';',${fld:postalcode},';'
			, ${fld:cc_remark},';'),
	'${def:user}',
	{ts '${def:timestamp}'},
	code,
	'${def:org}'
from cc_guest 
where code = ${fld:cc_code} 

and org_id='${def:org}'
