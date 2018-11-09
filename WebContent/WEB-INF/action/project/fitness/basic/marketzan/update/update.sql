update cc_market_campaign set 

startdate=${fld:startdate},
enddate=${fld:enddate},
votetype=${fld:votetype},
votenum=${fld:votenum},
campaignrules=${fld:campaignrules},
campaign_name=${fld:campaign_name},
remark=${fld:remark},

enrollfdate=${fld:enrollfdate},
enrolltdate=${fld:enrolltdate},
voteremark=${fld:voteremark},
totalnum=${fld:totalnum},
logoid=${fld:logoid},

  createdby='${def:user}',
  created= {ts'${def:timestamp}'}
where
  code = ${fld:tuid};
  
