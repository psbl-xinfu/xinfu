--zyb 20190510 查询修改课时记录

select 
	pts.name,--会员姓名
	pts.mobile,--会员手机号
	(select name from hr_staff where userlogin= pts.ptid) as ptname,--教练名字
	(select ptlevelname from cc_ptdef where code=pts.ptlevelcode and org_id=${def:org}) as ptkm ,--课程名字
	pts.code,
	ptclass.createdby,--修改时间
	ptclass.created,--修改人
	ptclass.oldpt,--修改前剩余节数
	ptclass.newpt,--修改后的剩余节数
	ptclass.remark,
	ptclass.ptfee,
	ptclass.ptfactfee
from cc_ptrest_class  ptclass
	left join (   
	select cust.name,cust.mobile,
	(case when ptrest.ptlevelcode=(select code from cc_ptdef where reatetype=1 and org_id=${def:org}) then cust.pt
		 when ptrest.ptlevelcode=(select code from cc_ptdef where reatetype=1 and org_id=${def:org}) and cust.pt is null then null
		 else ptrest.ptid
	end) as ptid,
	ptrest.ptlevelcode,
	ptrest.code
	from 
	cc_ptrest ptrest
	left join cc_customer cust on ptrest.customercode=cust.code
) as pts on pts.code=ptclass.ptrestcode
where  ptclass.org_id=${def:org}

${filter} 

order by ptclass.created desc
