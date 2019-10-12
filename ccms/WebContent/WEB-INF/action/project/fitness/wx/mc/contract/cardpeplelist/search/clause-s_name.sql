AND (
g.name like CONCAT('%',${fld:s_name},'%') or g.mobile like CONCAT('%',${fld:s_name},'%')
)
