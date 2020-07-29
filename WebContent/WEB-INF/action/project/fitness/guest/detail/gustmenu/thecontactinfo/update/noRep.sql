select 1 from dual where
(select (case when officename=${fld:company} then 0 
else 1 end) from cc_guest where  
code=${fld:cc_code}) =1	