--zyb 20190505  查找储值卡金额 
select moneycash from cc_customer 
where  code = (select t.customercode from cc_ptrest t where t.code = ${fld:code} and t.org_id = ${def:org} ) and org_id = ${def:org}
