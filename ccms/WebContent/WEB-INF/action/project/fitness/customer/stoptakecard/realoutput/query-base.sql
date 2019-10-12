SELECT
	(SELECT param_text FROM cc_config WHERE category = 'MaxStopMonth' and org_id =${def:org} LIMIT 1) AS maxstopmonth,	-- 最大允许停卡月数
(case when (SELECT param_text FROM cc_config WHERE category = 'IsStopCardDays' and org_id =${def:org} LIMIT 1)='1'
then (SELECT param_text FROM cc_config WHERE category = 'StopCardMonthFee' and org_id =${def:org} LIMIT 1)::integer*(${fld:i_prestopdays})::integer/30
	  when (SELECT param_text FROM cc_config WHERE category = 'IsStopCardDays' and org_id =${def:org} LIMIT 1)='0'
then (SELECT param_text FROM cc_config WHERE category = 'StopCardMonthFee' and org_id =${def:org} LIMIT 1)::integer*((${fld:i_prestopdays})::integer/31+1)
end) as realoutput
FROM dual