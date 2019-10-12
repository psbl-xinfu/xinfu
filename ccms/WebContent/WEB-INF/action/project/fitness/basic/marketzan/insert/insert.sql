insert into cc_market_campaign
(
code,
startdate,
enddate,
votetype,
votenum,
campaignrules,
campaign_name,
remark,

enrollfdate,
enrolltdate,
voteremark,
totalnum,
logoid,

status,
createdby,
created,
org_id,
campaigntype
)
values 
(
${seq:nextval@seq_cc_market_campaign},
${fld:startdate},
${fld:enddate},
${fld:votetype},
 ${fld:votenum},
 ${fld:campaignrules},
 ${fld:campaign_name},
 ${fld:remark}, 
 
 
 ${fld:enrollfdate}, 
 ${fld:enrolltdate}, 
 ${fld:voteremark}, 
 ${fld:totalnum}, 
 ${fld:logoid}, 
  
 2,
'${def:user}',
{ts'${def:timestamp}'},
${def:org},
3
)
