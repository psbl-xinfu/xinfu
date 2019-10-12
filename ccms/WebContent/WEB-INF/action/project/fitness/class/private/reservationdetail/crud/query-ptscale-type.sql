SELECT param_text as vc_content 
FROM cc_config 
WHERE category = 'PTScaleType' and org_id = ${def:org} LIMIT 1
/** 私教提成方式 0-固定金额  1-比例 */