--zyb 20190424 该会员不能签到，请确认时间或状态
SELECT code,ptid,customercode
FROM cc_ptprepare 
WHERE code = ${fld:reservationID}
AND preparedate = '${def:date}' and status = 1  and org_id = ${fld:org}


