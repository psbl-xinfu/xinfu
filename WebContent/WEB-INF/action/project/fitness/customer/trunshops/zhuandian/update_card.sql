update cc_card  set  cardtype=${fld:cardtypeid},org_id=${fld:cardorgid} where code=${fld:cardcode}
 and org_id=${def:org}