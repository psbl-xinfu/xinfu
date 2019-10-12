SELECT 
	tuid,
	resultcode,
	resultmsg 
FROM wx_qrcode 
WHERE tuid = ${fld:qrcodeid}
AND resultcode > 0 AND status != 0 and org_id=${def:org}
