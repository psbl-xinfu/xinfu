update cc_campaign set
  campaign_name= ${fld:camp_name},
  startdate= ${fld:startdate},
  enddate= ${fld:enddate},
  discount= ${fld:discount},
  org_id= ${def:org},
  cardtype= ${fld:vc_cardtype},
  remark= ${fld:vc_remark}
where
  code = ${fld:vc_code}
  and org_id = ${def:org}