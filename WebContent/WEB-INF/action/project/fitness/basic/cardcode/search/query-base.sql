SELECT 
	concat('<input type="checkbox" name="cardcodelist" value="' , tuid , '" />') AS check_link ,
	incode,
	cardcode,
	remark
FROM cc_cardcode 
WHERE org_id = ${def:org} AND status = 1 
${filter} 
${orderby}
