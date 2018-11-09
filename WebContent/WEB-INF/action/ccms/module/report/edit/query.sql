SELECT
    f.tuid
    ,f.subject_id
    ,f.table_id
    ,f.report_name_cn
    ,f.report_name_en
    ,f.report_type
    ,f.show_total_type
    ,f.show_sub_total_type
    ,f.show_percent_type
    ,f.if_customer_design
    ,f.is_sql_phrase
    ,f.report_sql
    ,f.col_num_filter
    ,f.remark
    ,t.table_alias
    ,f.url
    ,f.is_merge_zero
    ,f.is_merge_vertical
    ,f.is_show_zero
    ,f.form_js
    ,f.loadfilter_js
    ,f.searchpre_js
    ,f.searchback_js
    ,f.engine_type
    ,f.jor_file_name
    ,f.is_drill
    ,f.group_type
    ,f.filter_showtype 
FROM
	t_report f
	left join t_table t on f.table_id = t.tuid
WHERE
	f.tuid=${fld:id}
