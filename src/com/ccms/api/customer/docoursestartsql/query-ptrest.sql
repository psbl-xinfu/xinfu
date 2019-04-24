--zyb 20190424 获取ptrest的code为了减课程
SELECT ptrestcode 
FROM cc_ptprepare 
WHERE code = ${fld:reservationID}
 and org_id = ${fld:org}


