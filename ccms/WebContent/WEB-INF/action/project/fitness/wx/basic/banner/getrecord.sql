select
   attachid as id
from hr_org_banner where org_id = ${def:org} and bannertype = 10 and status = 1 order by showorder