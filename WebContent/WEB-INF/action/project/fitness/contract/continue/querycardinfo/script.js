<card-rows>
	currentDate = addDate("${fld:enddate}",1);
	$("#cardcontractcode").val("${fld:contractcode}");
	$("#cardtypespan").text("${fld:cardtypename@js}");
	$("#startdatespan").text("${fld:startdate}");
	$("#enddatespan").text("${fld:enddate}");
	$("#startdate").val(currentDate.format("yyyy-MM-dd"));
	setendate();
	$("#oldmcname").text("${fld:mcname@js}");
	$("#starttypespan").text("${fld:starttypename@js}");
	$("#supportorgsspan").text("${fld:supportorgs@js}");
</card-rows>
