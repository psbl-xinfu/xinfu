UPDATE cc_card 
SET
	code = ${fld:cardcode}
	
WHERE code = (select cardcode from cc_cardcode where tuid = ${fld:tuid} and org_id = ${def:org}) and org_id = ${def:org}
