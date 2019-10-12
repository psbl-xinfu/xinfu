
var faqstr = "";
<faq-rows>
var title = "${fld:title}";
if(title.length>20){
	title = title.substring(0, 20)+"...";
}
faqstr+="<li onclick='detailfaq(${fld:tuid})'><h1>"+title+"</h1>"
			+"<p class='nfoot'><span class='n-name'>${fld:created@yyyy-MM-dd}</span></p></li>";
</faq-rows>

$("#wordsList").html(faqstr);

function detailfaq(tuid){
	var url="${def:actionroot}/searchfaqdetail?tuid="+tuid;
	ajaxCall(url,{
		method:"get",
		progress:true,
		dataType:"script",
		success:function(){
		}
	});
}
