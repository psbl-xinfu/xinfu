UPDATE cc_cardcode 
SET
	incode = ${fld:incode}
	,cardcode = ${fld:cardcode}
	,remark = ${fld:remark} 
WHERE tuid = ${fld:tuid} and org_id = ${def:org}
