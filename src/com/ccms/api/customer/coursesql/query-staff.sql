select userlogin as uid,name,(case when sex='0' then '女' when sex='1' then '男' else 'null' end) as sex,status from 
hr_staff where  userlogin=${fld:userlogin} and org_id=${fld:org} and status=1 and is_member = 0 
