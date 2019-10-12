select
votenum
from
cc_market_campaign
where status=1  and campaigntype=3 and org_id=${def:org}
