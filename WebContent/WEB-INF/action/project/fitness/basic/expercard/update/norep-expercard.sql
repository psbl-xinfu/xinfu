select 1 from cc_market_campaign
where validatetype = 1 and not(${fld:c_startdate}>=startdate and ${fld:c_enddate}<=enddate)
and code = ${fld:m_code}