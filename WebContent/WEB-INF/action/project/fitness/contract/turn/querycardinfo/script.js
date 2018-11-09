<card-rows>
	$("#cardcontractcode").val("${fld:contractcode}");
	$("#cardtypespan").text("${fld:cardtypename@js}");
	$("#startdatespan").text("${fld:startdate}");
	$("#enddatespan").text("${fld:enddate}");
	$("#newstartdatespan").text(new Date().format("yyyy-MM-dd"));
	$("#newenddatespan").text("${fld:enddate}");
	$("#startdate").val(new Date().format("yyyy-MM-dd"));
	$("#enddate").val("${fld:enddate}");
	$("#oldmcname").text("${fld:mcname@js}");
	$("#starttypespan").text("${fld:starttypename@js}");
	$("#supportorgsspan").text("${fld:supportorgs@js}");
</card-rows>
