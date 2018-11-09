update cc_market_campaign set 
  campaign_name= ${fld:c_campaign_name},
 	
 

  validatetype= ${fld:c_validatetype},
  startdate= ${fld:c_startdate},
  enddate= ${fld:c_enddate},
  
  status= ${fld:c_status},
  link= ${fld:c_link},
  campaignrules= ${fld:c_campaignrules},
  createdby='${def:user}',
  created= {ts'${def:timestamp}'}
where
  code = ${fld:c_code};
  
