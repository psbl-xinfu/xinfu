SELECT COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),'')
		||to_char({ts'${def:date}'},'yyMMdd')
		||lpad(nextval('seq_cc_contract')::varchar, 4, '0') 
	AS newcontractcode 
FROM dual
