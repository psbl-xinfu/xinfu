AND (c.name like CONCAT('%',${fld:cust_search},'%') or c.mobile like CONCAT('%',${fld:cust_search},'%')
or cd.code =${fld:cust_search})
