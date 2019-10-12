
document.formEditor.warmup_mins.value = "${fld:warmup_mins}";
document.formEditor.aerobic_mins.value = "${fld:aerobic_mins}";
document.formEditor.run_mileage.value = "${fld:run_mileage}";

<rows>
	var url = "${def:context}${def:actionroot}/editquerytrainactioninfo?code=${fld:tdcode}";
	ajaxCall(url,{
	   	method: "get",
	   	progress: true,
	   	dataType: "script",
	   	success: function() {
		}
	});
</rows>
