select
	t.*,
	(case when ct.name is null then t.cardtypename else ct.name end) as cardtypename,
	card.code as cardcode
from
(select
 	concat('<label class="am-checkbox"><input type="checkbox"  data-am-ucheck name="datalist" code="',
 		c.status,
 		'" value="',
 		c.code,'',
 		'" code-card="', get_arr_value(c.relatedetail,1),'" code-cust="',c.customercode,'" code-relate="',COALESCE(c.relatecode,''),'" code-cttype="',c.contracttype,'" code-type="',c.type,'" ></label>') as application_id,
 	c.code, --合同编号
 	c.createdate,	
		(case when c.contracttype=0 and c.status =1 and c.isaudit=1 then '未审批' when c.contracttype=0 and c.status =1 and c.isaudit=3 then '审批拒绝' 
 	when c.contracttype=0 and c.status = 1 then '未付款' when c.contracttype!=3 and c.status =2 and c.normalmoney=c.factmoney then  '已付款'
 when  c.contracttype!=3 and COALESCE(c.normalmoney, 0) = 
 COALESCE( (select (ct.factmoney+c.factmoney) from cc_contract ct 
		where ct.relatecode = c.code and ct.org_id = c.org_id and ct.status =2 ), 0)
 then '已还款'
 when c.contracttype!=3 and  COALESCE(c.normalmoney, 0) != COALESCE( (select (ct.factmoney+c.factmoney) from cc_contract ct 
		where ct.relatecode = c.code and ct.org_id = c.org_id and ct.status =2 ), 0)
then '未还款'
	when c.contracttype=3 and COALESCE(c.normalmoney, 0) != COALESCE(c.factmoney, 0) then '未付清'
	when c.contracttype=3 and COALESCE(c.normalmoney, 0) = COALESCE(c.factmoney, 0) then '已付清'
	
 	end)::varchar as i_status, --状态
 	get_arr_value(c.relatedetail,1) as card_code,
 	m.name,
 	m.mobile,
 	round(normalmoney::NUMERIC(10, 2), 2) as normalmoney,
 	round(factmoney::NUMERIC(10, 2), 2) as factmoney,
 	c.collectdate as c_idate, --签约
 	(select enddate from cc_card where contractcode=c.code and isgoon=0 and org_id=${def:org} limit 1) as enddate,--截止
 	(select name from hr_staff where userlogin=c.salemember) as salemember,--销售员
 	(select name from hr_staff where userlogin=c.salemember1) as salemember1,--销售员
 	(select name from hr_staff where userlogin=c.recommendcode) as vc_iuser,--推荐人
 	(select name from hr_staff where userlogin=c.createdby) as createdby,--录入人
 	(case 
 		when (c.status=2 and c.contracttype!=3 and c.normalmoney!=c.factmoney) then '定金' 
 		when (c.contracttype=3 and c.relatecode is not null and c.relatecode!='') then '还款' 
 		else '办卡' 
 	end) as contracttype,
 	c.org_id,
 	get_arr_value(c.relatedetail,7) as cardtypename
from cc_contract c 
left join cc_customer m on m.code= c.customercode  and m.org_id=${def:org}
where /** 普通会籍只能查看自己的会员合同 */
c.org_id=${def:org}
and (c.type=0 or c.type = 5) 
and
(
contracttype=0
or
contracttype=3
) 
and c.status != 0 
${filter} 
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.salemember = '${def:user}' or c.salemember1 = '${def:user}' end)
order by (case when c.updated is null then c.createdate else c.updated end) desc,c.createtime desc
) as t
left join cc_card card on t.card_code = card.code and card.isgoon = 0 and card.org_id = t.org_id
left join cc_cardtype ct on card.cardtype = ct.code and card.org_id = ct.org_id
order by t.code desc
 
