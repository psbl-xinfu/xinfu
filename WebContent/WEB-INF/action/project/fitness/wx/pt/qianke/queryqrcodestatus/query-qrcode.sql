SELECT 
	tuid,
	resultcode,
	resultmsg 
FROM wx_qrcode 
WHERE tuid = ${fld:qrcodeid}
AND resultcode > 0 AND status != 0 
