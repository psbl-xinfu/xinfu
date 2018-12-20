select
	pr.code as prid,
	c.code as contractcode,
  get_arr_value(c.relatedetail,0) as relatedetailyi,
get_arr_value(c.relatedetail,1) as relatedetailer,
get_arr_value(c.relatedetail,2) as relatedetailsan,
get_arr_value(c.relatedetail,3) as relatedetailsi,
get_arr_value(c.relatedetail,4) as relatedetailwu,
get_arr_value(c.relatedetail,5) as relatedetailliu,
get_arr_value(c.relatedetail,6) as relatedetailqi,
get_arr_value(c.relatedetail,7) as relatedetailba,
get_arr_value(c.relatedetail,8) as relatedetailjiu,
get_arr_value(c.relatedetail,9) as relatedetailshi,
get_arr_value(c.relatedetail,10) as relatedetailshiyi,
get_arr_value(c.relatedetail,11) as relatedetailshier,
get_arr_value(c.relatedetail,12) as relatedetailshisan,
get_arr_value(c.relatedetail,13) as relatedetailshisi,
	pr.ptlevelcode,
	pr.ptid,
	pr.org_id,
	pd.ptlevelname,--私教类型
	pr.pttotalcount::int,--私教课总节数
	pr.ptleftcount::int,--私教课剩余节数
	(select name from hr_staff where userlogin = pr.ptid and org_id = ${def:org}) as ptname,--私教
	pr.ptenddate,--结束日期
	(case when pr.pttype=1 then '新买课'
	 	when pr.pttype=3 then '续课'
	  	when pr.pttype=4 then '转课' end) as pttype--来源
from cc_contract c 
left join cc_ptrest pr on c.code=pr.contractcode
left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
where  pr.customercode = ${fld:custcode} and pr.org_id = ${def:org} and c.type=2



