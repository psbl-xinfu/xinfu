AND (g.name like CONCAT('%',${fld:s_name},'%') or tt.mobile like CONCAT('%',${fld:s_name},'%')
)
