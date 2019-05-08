--zyb 20190505  查找储值卡金额 
select moneycash from cc_customer 
where  code = (select t.customercode from cc_contract t where t.code = ${fld:contractcode} and t.org_id = ${def:org} ) and org_id = ${def:org}
