select 1 from cc_guest where  
(case when officename=${fld:company} then 1=1 
else 1=null end)