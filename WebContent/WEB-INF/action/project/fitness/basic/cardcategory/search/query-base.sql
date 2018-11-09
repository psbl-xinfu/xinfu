select
    	concat('
	  <label class="am-checkbox">
	  <input type="checkbox"  data-am-ucheck name="datalist" 
	   value="',code,'','" >
	   </label>
') as application_id,
 	category_name as vc_name,
    showorder  as  i_priority,
    remark as  vc_remark
from cc_cardcategory
where 1=1 and status != 0 
and org_id=${def:org}
${filter}
${orderby}