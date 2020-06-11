 
 
  and (string_to_array(g.custclass,',') @> array[(select concat('',split_part(${fld:custcation2}, ',', 1),''))]

  or    string_to_array(g.custclass,',') @> array[(select concat('',split_part(${fld:custcation2}, ',', 2),''))]
 or    string_to_array(g.custclass,',') @> array[(select concat('',split_part(${fld:custcation2}, ',', 3),''))]
 or    string_to_array(g.custclass,',') @> array[(select concat('',split_part(${fld:custcation2}, ',', 4),''))]
 or    string_to_array(g.custclass,',') @> array[(select concat('',split_part(${fld:custcation2}, ',', 5),''))]
 or    string_to_array(g.custclass,',') @> array[(select concat('',split_part(${fld:custcation2}, ',', 6),''))]
 or    string_to_array(g.custclass,',') @> array[(select concat('',split_part(${fld:custcation2}, ',', 7),''))]
)