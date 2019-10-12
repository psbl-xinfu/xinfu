update cc_market_campaign set 
  campaign_name= ${fld:c_campaign_name},
  totalnum= ${fld:c_totalnum},
  personnum= ${fld:c_personnum},
  validatetype= ${fld:c_validatetype},
  startdate= ${fld:c_startdate},
  enddate= ${fld:c_enddate},
  
  rankrules= ${fld:c_rankrules},
  link= ${fld:c_link},
  campaignrules= ${fld:c_campaignrules},
  createdby='${def:user}',
  created= {ts'${def:timestamp}'}
where
  code = ${fld:c_code};
  
