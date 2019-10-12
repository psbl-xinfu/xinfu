select 
	card.code as cardcode,
    cust.name as cust_name,
    (select name from cc_cardtype where code = card.cardtype and org_id = ${def:org}) as cardtype,
    card.startdate as cardstartdate,
    card.enddate as cardenddate,
    get_arr_value(p.relatedetail,1) as beforedate,--延期前截止日期
    card.created as cardcreated,--办卡日期
    get_arr_value(p.relatedetail,2) as adjourndays,--延期天数
    (select name from hr_staff where userlogin = cust.mc) as mc,
    concat(p.createdate, ' ', p.createtime) as createdate,
    (select name from hr_staff where userlogin = p.createdby) as createdby,
    (case
    	when get_arr_value(p.relatedetail,3)='0' then '无效'
    	when get_arr_value(p.relatedetail,3)='1' then '正常'
    	when get_arr_value(p.relatedetail,3)='2' then '未启用'
    	when get_arr_value(p.relatedetail,3)='3' then '存卡中'
    	when get_arr_value(p.relatedetail,3)='4' then '挂失中'
    	when get_arr_value(p.relatedetail,3)='5' then '停卡中'
    	when get_arr_value(p.relatedetail,3)='6' then '过期'
    end) as status,--会员卡当时状态
    p.remark,
    get_arr_value(p.relatedetail,4) as adjourndate
from cc_operatelog p
left join cc_card card on get_arr_value(p.relatedetail,0) = card.code and p.org_id = card.org_id
left join cc_customer cust on p.customercode = cust.code and p.org_id = cust.org_id
where opertype = '05' and p.org_id = ${def:org} and card.isgoon = 0
${filter}
order by p.createdate desc,p.createtime desc
