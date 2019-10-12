
var count = 0;
<rows>
count++;
$("#name").html("${fld:name}");
$("#mobile").html("${fld:mobile}");
$("#created").html("${fld:created@yyyy-MM-dd HH:mm:ss}");
$("#carddate").html("${fld:startdate@yyyy-MM-dd}~${fld:enddate@yyyy-MM-dd}");
</rows>
	
if(count==0){
	ccms.dialog.notice("该卡号不存在！", 2000);
}
	
	