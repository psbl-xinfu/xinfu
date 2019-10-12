document.formEditor.money.value = "${fld:realoutput}";
var maxstopmonth = 3;
if( "" != "${fld:maxstopmonth}" && isNumber("${fld:maxstopmonth}") ){
	maxstopmonth = Number("${fld:maxstopmonth}");
}
maxstopdays = maxstopmonth*30;
