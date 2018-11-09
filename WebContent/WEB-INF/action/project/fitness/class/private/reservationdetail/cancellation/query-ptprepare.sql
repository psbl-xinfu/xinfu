select 
	concat(preparedate, ' ', preparetime) as preparedate
from cc_ptprepare 
where code = ${fld:id}::varchar and org_id = ${def:org}
