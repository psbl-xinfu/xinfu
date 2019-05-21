select userlogin as uid,name,(case when sex=0 then '女' when sex=1 then '男' else 'null' end) as sex from 
hr_staff where userlogin=${fld:uid} and org_id=${fld:org} and is_member=0 and status=1