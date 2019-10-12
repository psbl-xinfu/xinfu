
var cust_code = "${fld:customercode@js}";
var cust_name = "${fld:name@js}";
var rudge_code ="${fld:inlefttempcode@js}";
var cardcode = "${fld:cardcode@js}";
var cardtype = "${fld:cardtype@js}";

//退场刷卡
var url = "${def:context}/action/project/fitness/customer/entrance/out"
	+"?cust_code="+cust_code+"&cust_name="+cust_name+"&rudge_code="+rudge_code
	+"&cardcode="+cardcode+"&cardtype="+cardtype+"&unionorgid=${fld:unionorgid}";
ajaxCall(url,{
	method : "get",
	progress : true,
	dataType : "script",
	success : function() {
		search.searchData(1);
	}
});

