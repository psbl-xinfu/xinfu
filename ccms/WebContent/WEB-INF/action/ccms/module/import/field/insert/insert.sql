INSERT	INTO
t_import_field
(
	tuid
	,tab_id
	,field_id
	,field_code
	,col_name
	,domain_namespace
	,update_mode
	,field_type
	,field_length
	,is_mandatory
	,show_order
	,is_virtual_type
	,default_value
	,fk_schema
	,fk_tab
	,fk_fld_code
	,fk_fld_name
	,remark
	,created
	,createdby
	,is_formula 
	,is_save_code
	,regex_rule
	,regex_tip
	,show_align
)
VALUES
(
	${seq:nextval@seq_import_field}
	,${fld:tab_id}
	,${fld:field_id}
	,${fld:field_code}
	,${fld:col_name}
	,${fld:domain_namespace}
	,${fld:update_mode}
	,${fld:field_type}
	,${fld:field_length}
	,${fld:is_mandatory}
	,${fld:show_order}
	,${fld:is_virtual_type}
	,${fld:default_value}
	,${fld:fk_schema}
	,${fld:fk_tab}
	,${fld:fk_fld_code}
	,${fld:fk_fld_name}
	,${fld:remark}
	,{ts '${def:timestamp}'}
	,'${def:user}'
	,${fld:is_formula} 
	,${fld:is_save_code}
	,${fld:regex_rule}
	,${fld:regex_tip}
	,${fld:show_align}
)

