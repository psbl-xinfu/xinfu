select
    tuid
    ,tab_id
    ,rule_name
    ,rule_order
    ,remark
    ,version
    ,filter_type
from
	 t_import_rule
where
	tuid=${fld:id}
