and
case 
 when ${fld:s_status_r}=0 then b.status=0
 when ${fld:s_status_r}=1 then b.status=1
 when ${fld:s_status_r}=2 then b.status=2
 when ${fld:s_status_r}=3 then b.status=3
 when ${fld:s_status_r}=4 then b.physics_status=1
 when ${fld:s_status_r}=5 then b.physics_status=0
end