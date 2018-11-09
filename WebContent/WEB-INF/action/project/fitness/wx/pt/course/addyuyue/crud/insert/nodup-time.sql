SELECT 1 FROM dual 
WHERE to_date('${def:timestamp}','yyyy-MM-dd') > to_date(${fld:preparedate},'yyyy-MM-dd')

