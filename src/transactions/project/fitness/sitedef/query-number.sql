select sum(case when ccsite.guestgroupid is null then 1 else 
 ccgroup.numbergroup end) as theumber
from cc_siteusedetail ccsite
LEFT JOIN ( select ccguestgroup.tuid,count(ccgroupmenber.groupid) as numbergroup from cc_guest_group ccguestgroup
LEFT JOIN cc_guest_group_member ccgroupmenber on ccgroupmenber.groupid = ccguestgroup.tuid GROUP BY ccguestgroup.tuid )
 as ccgroup on ccgroup.tuid = ccsite.guestgroupid where 
ccsite.prepare_date=${prepare_date} and  prepare_type = ${choose_way} and  ${numtime} BETWEEN  ccsite.prepare_starttime   and   ccsite.prepare_endtime  
