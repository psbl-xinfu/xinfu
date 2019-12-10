select
	the.code as the_code,
	the.name as the_name
	,(case the.sex when
    	'0' then '女'
    	 when '1' then '男'
    	 when '2' then '未知'
    end) as i_sex
	,the.mobile as vc_mobile
	,(select posname from cc_position where code=the.positioncode ) as position
	,cc.remark --跟进备注
	,cc.created::date--最后一次的跟进时间
from  cc_thecontact the
left join
(select code,thecontactcode,commresult,remark,created 
from cc_comm  where code in (select max(code) as code from cc_comm  where guestcode=${fld:guestcode} and org_id='${def:org}'  GROUP BY thecontactcode)  ) as cc  on cc.thecontactcode=the.code
where the.guestcode=${fld:guestcode}
 and the.org_id='${def:org}' 
 ${filter} 

