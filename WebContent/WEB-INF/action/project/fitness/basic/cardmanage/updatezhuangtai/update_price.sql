update cc_cardtype_fee
set cardfee=${fld:f_cardfee}
where cardtype=${fld:vc_code} and org_id = ${def:org}
