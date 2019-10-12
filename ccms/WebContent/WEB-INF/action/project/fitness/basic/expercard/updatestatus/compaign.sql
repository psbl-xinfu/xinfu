update  cc_market_campaign set
expercardcode=case when ${fld:c_status}=2 then null else ${fld:id} end
where
code=${fld:code}

