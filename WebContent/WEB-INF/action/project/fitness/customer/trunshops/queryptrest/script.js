
var ptrestlist = "", count = 0;
var ids="";
<rows>
	count++;
	
	ptrestlist+="<tr>"
		+"<input id='ids"+count+"' name='ids'  type='hidden' value='${fld:prid}'/>"+
		"<input id='ptlevelcode"+count+"' name='ptlevelcode'  type='hidden' value='${fld:ptlevelcode}'/>"+
		"<input id='ypid"+count+"' name='ypid'  type='hidden' value='${fld:ptid}'/>"+
		"<input id='prid"+count+"' name='prid'  type='hidden' value='${fld:prid}'/>"+
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
	     			$.ajax({
	    	          url : bin,
	    	          type : "get",
	    	          success : function(data) {
	    	        	  var ptstr = "<option value=''>全部教练</option>";
	    	        	  ptstr+=data;
	    	        	  $("#"+"jiao"+count).html(ptstr);
	    	          	}
	     		});
	 }
	


ccms.util.renderRadio("ptrestcode");





