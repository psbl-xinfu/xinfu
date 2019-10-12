insert into cc_market_campaign
(
code,
campaign_name,
expercardcode,
totalnum,
personnum,
validatetype,
startdate,
enddate,
rankrules,
link,
campaignrules,
status,
createdby,
created,
org_id,
campaigntype
)
values 
(
${seq:nextval@seq_cc_market_campaign},
${fld:c_campaign_name},
${fld:c_expercardcode},
${fld:c_totalnum},
 ${fld:c_personnum},
 ${fld:c_validatetype},
 ${fld:c_startdate},
 ${fld:c_enddate}, 
  ${fld:c_rankrules}, 
 ${fld:c_link}, 
  ${fld:c_campaignrules}, 
 2,
'${def:user}',
{ts'${def:timestamp}'},
${def:org},
0
)
