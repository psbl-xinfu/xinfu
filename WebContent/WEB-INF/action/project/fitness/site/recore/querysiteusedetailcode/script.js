
$("#hccode").val("${fld:code}");
$("#hcsiteusedetail").html("${fld:sitename}-${fld:prepare_date@yyyy-MM-dd}"
		+" ${fld:prepare_starttime}-${fld:prepare_endtime}");

$("#cddatagridTemplate").html("<tr><td>${fld:customertype}</td><td>${fld:name}</td><td>${fld:mobile}</td></tr>");


