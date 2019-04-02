 SELECT
  --zzn 增加了合同类型 
  --concat('<input type="radio" name="contractcode" value="', c.code, '" code="', r.code, '" />') AS radiolink,
  	concat('<input type="radio" name="contractcode" value="', c.code, '" code="', r.code, '" contracttype="',c.contracttype,'" contype="',c.type ,'" />') AS radiolink,
	null::varchar as vc_code,	/** 卡号 */
	c.code AS vc_contractcode,
	r.name as vc_name,
	(CASE r.sex WHEN 0 THEN '女' WHEN 1 THEN '男' WHEN 2 THEN '保密' ELSE '' END) AS i_sex,
	null AS i_age,
	(CASE c.discounttype WHEN 1 THEN '正价合同' WHEN 2 THEN '活动折扣合同' WHEN 3 THEN '特批折扣合同' ELSE '' END) AS i_discounttype,
	c.type as i_type,
	r.mobile as vc_mobile,
	(select name from hr_staff where userlogin=c.salemember) as vc_newsale,
	r.birth as c_birthdate,
	c.contracttype as i_contracttype,
	(CASE c.status WHEN 1 THEN '未付款' WHEN 2 THEN '已付款' ELSE '' END) AS i_status,
	null::varchar as vc_cardtype,
	c.relatedetail as vc_relatecode,
	(CASE WHEN c.type = 1 OR c.type = 12 THEN '租柜合同'
		WHEN c.type = 2 THEN (select ptlevelname from cc_ptdef where cc_ptdef.code =get_arr_value(c.relatedetail, 1))
		WHEN c.type = 4 THEN ( select name from cc_cardtype where code=(SELECT  cardtype from  cc_card where cc_card.code =get_arr_value(c.relatedetail, 1)))
		ELSE get_arr_value(relatedetail, 7)
	END)::varchar AS cardtype_name,	
	(CASE WHEN c.contracttype = 1 OR c.contracttype = 2 OR c.type = 6 THEN '升级合同' 
		WHEN c.contracttype = 3 THEN '还款合同' 
		WHEN c.type = 5 THEN '定金合同' 
		WHEN c.type = 0 THEN '办卡合同'
		WHEN c.type = 7 OR c.type = 9 OR c.type = 11 THEN '续卡合同' 
		WHEN c.type = 10 THEN '转卡合同' 
		WHEN c.type = 1 OR c.type = 12 THEN '租柜合同' 
		WHEN c.type = 2 THEN '私教合同' 
		WHEN c.type = 4 THEN '退卡合同' END) AS vc_contracttype,
	c.contracttype,
	c.type
FROM cc_contract c 
INNER JOIN cc_customer r on c.customercode = r.code
WHERE c.status >= 2 and c.org_id = ${def:org}
${filter}
 order by c.createdate desc,c.createtime desc
