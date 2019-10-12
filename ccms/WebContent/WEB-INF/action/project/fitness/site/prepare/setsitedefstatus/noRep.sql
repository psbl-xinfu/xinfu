select 1 from cc_site_timelimit where sitecode=${fld:sitecode} 
and limittime::varchar in (select regexp_split_to_table(${fld:timelimitcode},',') from dual) 
