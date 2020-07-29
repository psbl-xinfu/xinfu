select
	concat('<label class="am-checkbox"><input type="checkbox"  data-am-ucheck name="datalist" 
 value="',the.code::varchar,'','" > </label>') as application_id,
  the.code as vc_code
	,the.name as vc_name
	,(case the.sex when
    	'0' then '女'
    	 when '1' then '男'
    	 when '2' then '未知'
    end) as i_sex
	,the.mobile as vc_mobile
	,the.mobile2 as vc_mobile2
	,(select posname from cc_position where code=the.positioncode ) as position
	,(select storename from cc_branch where code=the.branchcode ) as branchname
	,(case cc.commresult when 
		'1' then '未建立关系'
		when '2' then '建立关系'
		when '3' then '了解需求'
		when '4' then '对接产品价值'
		when '5' then '要承诺'
		when '6' then '暂时搁置'
		when '7' then '成交'
		when '8' then '未成交'
	end) as gj_commresult
	,cc.remark
	
from  cc_thecontact the
left join
(select code,thecontactcode,commresult,remark 
from cc_comm  where code in (select max(code) as code from cc_comm  where guestcode=${fld:ttid} and org_id='${def:org}'  GROUP BY thecontactcode)  ) as cc  on cc.thecontactcode=the.code

where the.guestcode=${fld:ttid}
  
 ${filter} 

