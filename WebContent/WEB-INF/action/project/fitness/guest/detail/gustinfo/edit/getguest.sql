select
  code
	,officename --公司名称
	,othertel  --电话
	,email 
	,remark  --公司备注
	,mc --顾问
	,initmc
	,province2 --省
	,city2  --市
	,customtype   --公司类型
	,communication --客户分类
	,custclass  --客户详细分类
	,createdby  --操作人
	,created  --操作时间
	,org_id
	,guestnum --公司数量
	,thepublic --公众号
	,channel --获客渠道
	,possibility--可能性
from 
	cc_guest
where 
	code = ${fld:code} and org_id=${def:org}
