select code as uid,name,(case when sex=0 then '女' when sex=1 then '男' else 'null' end) as sex from 
cc_customer where code=(
select customercode from cc_card where code=${fld:userCode} and isgoon=0 and status=1) and status!=0