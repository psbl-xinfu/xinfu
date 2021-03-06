INSERT INTO
	t_form_filter_field
(
	tuid
	,form_id
	,item_id
	,field_id
	,show_order
	,show_type
	,width
	,colspan
	,rowspan
	,filter_type
	,is_mandatory
)
VALUES
(
	${seq:nextval@${schema}seq_default}
	,${fld:form_id}
	,${fld:filter_item_id}
	,${fld:filter_field}
	,${fld:filter_show_order}
	,${fld:filter_show_type}
	,${fld:filter_width}
	,${fld:filter_colspan}
	,${fld:filter_rowspan}
	,${fld:filter_filter_type}
	,${fld:filter_is_mandatory}
)
