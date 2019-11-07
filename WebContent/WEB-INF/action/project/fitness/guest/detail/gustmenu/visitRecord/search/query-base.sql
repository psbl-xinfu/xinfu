select
	concat('<label class="am-checkbox"><input type="checkbox"  data-am-ucheck name="datalist" 
 value="',the.code::varchar,'','" > </label>') as application_id,
	the.name as vc_name
	,(case the.sex when
    	'0' then '女'
    	 when '1' then '男'
    	 when '2' then '未知'
    end) as i_sex
	,the.mobile as vc_mobile
	,(case when the.position =1 then '投资人'
	when the.position =2 then '总监'
	when the.position =3 then '会籍经理'
	when the.position =4 then '私教经理'
	when the.position =5 then '会籍'
	when the.position =6 then '私教'
	end) as cc_position
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
	,lathe.lablgcode
	,lathe.lablgname
from  cc_thecontact the
left join
(select code,thecontactcode,commresult,remark 
from cc_comm  where code in (select max(code) as code from cc_comm  where guestcode=${fld:ttid} and org_id='${def:org}'  GROUP BY thecontactcode)  ) as cc  on cc.thecontactcode=the.code
left join (select lt.thecode,string_agg(la.name,';') as lablgname,
string_agg(lt.labelcode,';'order by lt.labelcode asc) as lablgcode
from cc_label_the lt
left join cc_label la on lt.labelcode=la.code where lt.org_id='${def:org}'  group by lt.thecode ) as lathe on lathe.thecode=the.code
where the.guestcode=${fld:ttid}
 and the.org_id='${def:org}' 
 ${filter} 

