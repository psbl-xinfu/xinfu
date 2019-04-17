select code as uid,name,(case when sex=0 then '女' when sex=1 then '男' else 'null' end) as sex from 
cc_customer where code=${fld:uid} and status!=0