select org_name as club_name from hr_org 
where org_id in (select club_id from t_union_club where union_id::varchar = ${fld:id}::varchar)