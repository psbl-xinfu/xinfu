select
 	concat('
	  <label class="am-checkbox">
	  <input type="checkbox"  data-am-ucheck name="datalist" 
	   value="',code,'','" >
	   </label>
	') as application_id,
	code,
    campaign_name,
    startdate,
    enddate,
    (case when a.is_enabled=1 then '已启用'  else '已禁用' end) as is_enabled,
    ((case when a.discount is null then '0' else a.discount end)*10) as discount,
    (select org_name from hr_org where a.org_id = org_id) as vc_clubcode,
    (case when cardtype is null then '全部' else
	    (select 
	  	    	name
	  	  from cc_cardtype where code=a.cardtype and org_id = ${def:org} order by code limit 1
	    )
    end)as vc_cardtype,
    remark
from cc_campaign a
where 1=1
and a.org_id = ${def:org}
${filter}
${orderby}