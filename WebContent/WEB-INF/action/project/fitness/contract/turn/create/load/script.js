<contract-rows>
if( Number("${fld:status}") >= 2 ){
	topay("${fld:code}");
}
$("#contractcode").val("${fld:code}");
$("#customercode").val("${fld:oldcustomercode}");
$("#custnamespan").text("${fld:custname}");
$("#mobilespan").text("${fld:custmobile}");

$("#pickcustname").val("${fld:newcustname}");
$("#newcustcode").val("${fld:newcustcode}");

setSelectValue($("#cardcode"), "${fld:cardcode}");
$("#startdate").val("${fld:startdate}");
$("#enddate").val("${fld:enddate}");
$("#newstartdatespan").text("${fld:startdate}");
$("#newenddatespan").text("${fld:enddate}");

setSelectValue($("#salemember1"), "${fld:salemember1}");
setSelectValue($("#salemember"), "${fld:salemember}");
$("#remark").val("${fld:remark@js}");

$("#normalmoney").val("${fld:normalmoney}");
$("#normalmoneyspan").text("${fld:normalmoney}");

//等于空说明转给资源
if("${fld:customercode}"==""){
	ccms.util.setCheckboxValue("custtype","0","contractForm");
}

getAjaxCall("/action/project/fitness/contract/upgrade/querycardinfo?cardcode=${fld:cardcode}", true);

</contract-rows>