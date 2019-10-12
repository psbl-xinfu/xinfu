AND 
(case
when ${fld:daochu_type}=0 then    c.contracttype =1  OR c.contracttype =2 
when ${fld:daochu_type}=1 then    c.contracttype =3
when ${fld:daochu_type}=2 then    c.type =5
when ${fld:daochu_type}=3 then    c.type =0
when ${fld:daochu_type}=4 then    c.type =7 OR c.type=9 OR c.type=11  
when ${fld:daochu_type}=5 then    c.type =10
when ${fld:daochu_type}=6 then    c.type =4  
when ${fld:daochu_type}=7 then    c.type =2
when ${fld:daochu_type}=8 then    c.type = 1 OR c.type = 12
end)
