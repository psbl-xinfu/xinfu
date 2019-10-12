 select
 	concat('
	  <label class="am-checkbox">
	  <input type="checkbox"  data-am-ucheck name="datalist" 
		code="',status,'','" 
	   value="',code,'','" >
	   </label>
	') as application_id,
	name,
 	(case when expertype=0 then '时效卡' when expertype=1 then '计次卡'  else '私教免费课' end)  as cardtype,
	experlimit,
	(case when validatetype=0 then '长期有效' when validatetype=1 then '活动期间有效'  else '指定时间有效' end)  as validatetype,
	(case when status=0 then '无效' when status=1 then '已启用'  else '未启用' end)  as status
from cc_expercard 
where org_id=${def:org}
and market_campaign_code=${fld:s_code}
${filter}
${orderby}



