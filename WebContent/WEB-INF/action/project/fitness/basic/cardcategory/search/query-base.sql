select
    	concat('
	  <label class="am-checkbox">
	  <input type="checkbox"  data-am-ucheck name="datalist" 
	   value="',code,'','" >
	   </label>
') as application_id,
 	posname as vc_name
from cc_position
where 1=1 and
 org_id=${def:org}
${filter}
${orderby}