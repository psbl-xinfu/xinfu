--zzn 同一店下员工手机号不允许重复
select 1 from hr_staff where mobile=${fld:mobile} and org_id=${fld:org_id} and is_member='0'


