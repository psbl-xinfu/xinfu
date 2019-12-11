SELECT

gt.code as guestcode
,tt.code as thecode
,tt.name as thename
,tt.mobile as themobile
,gt.officename 
, pt.posname
,gt.org_id as orgid

FROM cc_thecontact AS tt

LEFT JOIN  cc_guest AS gt ON tt.guestcode = gt.code

LEFT JOIN cc_position AS pt ON tt.positioncode = pt.code
where gt.mc='${def:user}' and  (
	tt.name like concat('%', ${fld:pickcustname}, '%') or
	tt.mobile like concat('%', ${fld:pickcustname}, '%') or 
	pt.posname like concat('%', ${fld:pickcustname}, '%') or
	gt.officename like concat('%', ${fld:pickcustname}, '%') )