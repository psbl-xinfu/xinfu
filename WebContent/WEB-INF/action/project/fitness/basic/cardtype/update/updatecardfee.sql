update cc_cardtype_fee set 
   cardfee=${fld:vc_cardfee},
   minfee= ${fld:vc_minfee}
where
 cardtype= ${fld:vc_code} and org_id=${def:org}
