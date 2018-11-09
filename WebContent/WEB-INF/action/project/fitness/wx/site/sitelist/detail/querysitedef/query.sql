select
	(case when block_price=0 then group_price else block_price end) as price,
	to_char(opening_date::time, 'HH24:mi') as hour
from cc_sitedef st
where st.org_id = ${fld:org_id} and st.sitetype = ${fld:sitetype}
