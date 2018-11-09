insert into cc_market_campaign_votelog 
(
code,
campaigncode,
votedate,


createdby,
created,
org_id,
enrollcode
)
values 
(
${seq:nextval@seq_cc_market_campaign_votelog},
(select code  from  cc_market_campaign where campaigntype=3 and org_id=${def:org} and status=1 ),
'${def:date}',

 
${fld:wxuserid},
{ts'${def:timestamp}'},
${def:org},
${fld:enrollcode}
)
