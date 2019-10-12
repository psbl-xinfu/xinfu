AND (
c.name like CONCAT('%',${fld:s_name},'%') or c.mobile like CONCAT('%',${fld:s_name},'%')
)
