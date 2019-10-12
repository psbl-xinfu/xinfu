
<row>
	var yearmonth = "${fld:month}".split("-");
	if( yearmonth.length >= 2 ){

		$("td[code-month="+yearmonth[1]+"]").text("${fld:visit_num}");
	}
</row>

