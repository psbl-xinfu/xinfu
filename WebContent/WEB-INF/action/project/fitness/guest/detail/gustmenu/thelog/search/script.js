var strhtml = "";
var count = 0;
var possibilitystr="";
var possibilityarr="";
var thecoursestr="";
var thecoursearr="";

<list-rows>
	var possibilitynamestr="";
	var thecoursenamestr="";
	count++;
	strhtml+="<tr id='list'>";
		strhtml+="<td>${fld:officename}</td>";
		strhtml+="<td>${fld:posname}</td>";
			
			possibilitystr="${fld:possibility}";
			possibilityarr=possibilitystr.split(",");
			thecoursestr="${fld:thecourse}";
			thecoursearr=thecoursestr.split(",");
			<isgood-rows>
			 	for (var i = 0; i < possibilityarr.length; i++) {
					if(possibilityarr[i]=="${fld:coucodeis}"){
						possibilitynamestr+="${fld:counameis}；";
					}
				}
			 	for (var i = 0; i < thecoursearr.length; i++) {
					if(thecoursearr[i]=="${fld:coucodeis}"){
						thecoursenamestr+="${fld:counameis}；";
					}
				}
			 </isgood-rows>
			 
			 strhtml+="<td>"+possibilitynamestr.substr(0, possibilitynamestr.length - 1)+"</td>";
			 strhtml+="<td>"+thecoursenamestr.substr(0, thecoursenamestr.length - 1)+"</td>";
			 strhtml+="<td>${fld:storename}</td>";
			 strhtml+="<td>${fld:created}</td>";
			 strhtml+="<td>${fld:createdby}</td>";
			 strhtml+="</tr>";
			
</list-rows>
if(count==0){
	strhtml+="<tr>";
	strhtml+="<td class='text-center' colspan=12><span style='color:red;font-size:large;'>没有记录</span></td>";
	strhtml+="</tr>";
}
$("#datagrid").html(strhtml);
