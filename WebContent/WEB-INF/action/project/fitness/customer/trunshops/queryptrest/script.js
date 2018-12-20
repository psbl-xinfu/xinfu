
var ptrestlist = "", count = 0;
var ids="";
<rows>
	count++;
	
	ptrestlist+="<tr>"
		+"<input id='ids"+count+"' name='ids'  type='hidden' value='${fld:prid}'/>"+
		"<input id='ptlevelcode"+count+"' name='ptlevelcode'  type='hidden' value='${fld:ptlevelcode}'/>"+
		"<input id='ypid"+count+"' name='ypid'  type='hidden' value='${fld:ptid}'/>"+
		"<input id='prid"+count+"' name='prid'  type='hidden' value='${fld:prid}'/>"+
		"<input id='relatedetailyi"+count+"' name='relatedetailyi'  type='hidden' value='${fld:relatedetailyi}'/>"+
		"<input id='relatedetailer"+count+"' name='relatedetailer'  type='hidden' value='${fld:relatedetailer}'/>"+
		"<input id='relatedetailsan"+count+"' name='relatedetailsan'  type='hidden' value='${fld:relatedetailsan}'/>"+
		"<input id='relatedetailsi"+count+"' name='relatedetailsi'  type='hidden' value='${fld:relatedetailsi}'/>"+
		"<input id='relatedetailwu"+count+"' name='relatedetailwu'  type='hidden' value='${fld:relatedetailwu}'/>"+
		"<input id='relatedetailliu"+count+"' name='relatedetailliu'  type='hidden' value='${fld:relatedetailliu}'/>"+
		"<input id='relatedetailqi"+count+"' name='relatedetailqi'  type='hidden' value='${fld:relatedetailqi}'/>"+
		"<input id='relatedetailba"+count+"' name='relatedetailba'  type='hidden' value='${fld:relatedetailba}'/>"+
		"<input id='relatedetailjiu"+count+"' name='relatedetailjiu'  type='hidden' value='${fld:relatedetailjiu}'/>"+
		"<input id='relatedetailshi"+count+"' name='relatedetailshi'  type='hidden' value='${fld:relatedetailshi}'/>"+
		"<input id='relatedetailshiyi"+count+"' name='relatedetailshiyi'  type='hidden' value='${fld:relatedetailshiyi}'/>"+
		"<input id='relatedetailshier"+count+"' name='relatedetailshier'  type='hidden' value='${fld:relatedetailshier}'/>"+
		"<input id='relatedetailshisan"+count+"' name='relatedetailshisan'  type='hidden' value='${fld:relatedetailshisan}'/>"+
		"<input id='relatedetailshisi"+count+"' name='relatedetailshisi'  type='hidden' value='${fld:relatedetailshisi}'/>"+
			"<td>"+count+"</td>" +
			"<td>${fld:ptlevelname}</td>" +
			"<td>${fld:ptname}</td>" +
			"<td class='course'>" +
			"<select id='course"+count+"' onchange='courseid("+count+")' name='course' style='background: #282e34 !important;border: none!important;outline: none!important;color: #969da4 !important;box-shadow: none!important;width:60%'>"+
					"<course-rows>"+
							"<option value='${fld:code}'>${fld:ptlevelname}</option>"+    
					"</course-rows>"+
			"</select></td>"+
			"<td>" +
			"<select id='jiao"+count+"' class='jiao' style='background: #282e34 !important;border: none!important;outline: none!important;color: #969da4 !important;box-shadow: none!important;width:100%'>"+
			"</select></td>"+
			"<td>${fld:pttotalcount}</td>" +
			"<td>${fld:ptleftcount}</td>"+
			"<td>${fld:ptenddate}</td>" +
			"<td>${fld:pttype}</td>"+
			"</tr>";
</rows>
// searchSelectInit($("#course"));
$("#ptrestlist").html(ptrestlist);
$("#org_id").change(function(){
	var url = "${def:actionroot}/queryorgpt?org_id="+$(this).val();
	ajaxCall(url,{
		method:"get",
		progress:true,
		dataType:"script",
		success:function(){	
			$("#newcustcode,#newcustname").val("");
			pickcustCallback();
			pickcardCallback();
		}
	});
	
});



function courseid(count){
	     var bin = "${def:context}${def:actionroot}/coursept?org_id="+$("#org_id").val()+
			"&code=" + $("#"+"course"+count).val();
	     			ajaxCall(bin,{
	    	          type : "get",
	    	          progress:true,
	    	      	  dataType:"json",
	    	          success : function(data) {
	    	        	  var actionhtml = "<option value=''>请选择</option>";
	    	        		for(var i=0;i<data.length;i++){
	    	        			if(data[i].code!=undefined)
	    	        				actionhtml += "<option value='"+data[i].code+"'>"+data[i].actions+"</option>";
	    	        		}
	    	        		$("#"+"jiao"+count).html(actionhtml);
	    	          	}
	     		});
	 }
	


ccms.util.renderRadio("ptrestcode");





