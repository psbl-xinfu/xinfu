select
    tuid,
    begintime,
    endtime,
    remark
from hr_org_holiday
where tuid = ${fld:id} and org_id = ${def:org}