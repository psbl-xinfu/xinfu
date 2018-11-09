select 1 from cc_expercard where name=${fld:c_cardname} 
and market_campaign_code=${fld:m_code} and org_id=${def:org}
and code !=${fld:c_code}