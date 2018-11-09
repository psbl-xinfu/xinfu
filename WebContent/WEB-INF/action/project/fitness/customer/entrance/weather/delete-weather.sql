delete from cc_weather
where wdate = '${def:date}'::date
and org_id = ${def:org}