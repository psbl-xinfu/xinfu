INSERT	INTO
t_form_item
(
	tuid, form_id, item_name_cn, item_name_en, col_num, show_order, created, createdby, 
       updated, updatedby,  remark, item_code, linkage_document_id,fieldset_style,plugin_top,plugin_bottom
)
select
	${item_id}
	,${form_id}
	,item_name_cn, item_name_en, col_num, show_order, created, createdby, 
       updated, updatedby,  remark, item_code, linkage_document_id,fieldset_style,plugin_top,plugin_bottom
from
	t_form_item
where
	tuid = ${old_item_id}