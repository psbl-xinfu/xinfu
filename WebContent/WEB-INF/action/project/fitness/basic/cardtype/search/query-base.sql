select
    	concat('
	  <label class="am-checkbox">
	  <input type="checkbox"  data-am-ucheck name="datalist" 
	   value="',c.code,'','" >
	   </label>
') as application_id,
 	c.proname as vc_name,
 	(case c.status when 0 then '禁用'  when 1 then '启用' end) as status
 from cc_product c
where 1=1 and
 c.org_id=${def:org}
${filter}
${orderby}