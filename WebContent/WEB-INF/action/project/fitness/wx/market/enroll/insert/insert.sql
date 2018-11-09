insert into cc_market_campaign_enroll
(
code,
campaigncode,
cusstname,

mobile,
enrollname,
descr,
status,

createdby,
created,
org_id
)
values 
(
${seq:nextval@seq_cc_market_campaign_enroll},
(select code  from  cc_market_campaign where campaigntype=3 and org_id=${def:org} and status=1 ),
${fld:cusstname},

${fld:mobile},
${fld:enrollname},
${fld:descr},
 2,
 
'${def:user}',
{ts'${def:timestamp}'},
${def:org}
)
