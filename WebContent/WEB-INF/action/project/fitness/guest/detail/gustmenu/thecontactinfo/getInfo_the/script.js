<rows>
$('#thename').text("${fld:name}");
$('#thei_sex').text("${fld:i_sex}");
$('#themobile').text("${fld:mobile}");
$('#themobile2').text("${fld:mobile2}");
/*if("${fld:birth}"!=''&&"${fld:birthday}"!=''){
	$('#birth').text("${fld:birth}月${fld:birthday}日");
}*/
$('#theposition').text("${fld:position}");
$('#thebirthday').text("${fld:birthday}");
$('#theemail').text("${fld:email}");
$('#thetrill').text("${fld:trill}");
$('#thewechat').text("${fld:wechat}");

$('#thebranchname').text("${fld:branchname}");


$('#theremark').text("${fld:remark}");

var thecourse="${fld:thecourse}";
var arr=thecourse.split(",");
/* var custcationsarry =custclass.split(",").length ;*/
 var thecourses="";
 <course-rows>
 	for (var i = 0; i < arr.length; i++) {
		if(arr[i]=="${fld:coursecode}"){
			thecourses+="${fld:courname};";
		}
		
	}
 </course-rows>

$('#thethecourse').text(thecourses.substr(0, thecourses.length - 1) );

var possibility="${fld:possibility}";
var arr=possibility.split(",");
/* var custcationsarry =custclass.split(",").length ;*/
 var possibilitys="";
 <courseps-rows>
 	for (var i = 0; i < arr.length; i++) {
		if(arr[i]=="${fld:coursecode}"){
			possibilitys+="${fld:courname};";
		}
		
	}
 </courseps-rows>

$('#thepossibility').text(possibilitys.substr(0, possibilitys.length - 1) );



</rows>






