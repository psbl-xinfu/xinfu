SELECT 
	tuid
	,incode
	,cardcode
	,status
	,remark
	,org_id 
FROM cc_cardcode 
WHERE tuid = ${fld:id} and org_id = ${def:org}
