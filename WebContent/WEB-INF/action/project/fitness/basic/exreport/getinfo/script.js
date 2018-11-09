	$('#campaign_name').text("${fld:campaign_name}");
 	$('#expertype').text("${fld:expertype}");
 	$('#personnum').text("${fld:personnum}");
 	$('#totalnum').text("${fld:totalnum}");
 	$('#day').text("${fld:day}天");
 	if("${fld:day}"==""){
 		$('#day').text("无限制");
 	}else{
 		$('#day').text("${fld:day}天");
 	}
 	
 	if("${fld:startdate}"==""){
 		$('#startdate').text("无限制");
 	}else{
 		$('#startdate').text("${fld:startdate} ~ ");
 	}
 	
	if("${fld:enddate}"!=""){
		$('#enddate').text("${fld:enddate}");
 	}
 	
	
