var follow_target=0.0,orderfee_target=0.0;
<rows>
	//会籍
	follow_target="${fld:follow_target}";
	orderfee_target="${fld:orderfee_target}";
</rows>

<num>
 if("${fld:num}"==3){
	$('#genjin_monnum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==11){
	$('#contractprice_monnum').text(Number("${fld:guest_daynum}").toFixed(2));
}
</num>
chengjiaobi();

function chengjiaobi(){
	if(follow_target!=0){
	var b2=Number($('#genjin_monnum').text()/follow_target);
	b2=rect(b2);
	$('#follow_target').text(b2+'%');
	}
	
	if(orderfee_target!=0){
	var b6=Number($('#contractprice_monnum').text()/orderfee_target);
	b6=rect(b6);
	$('#orderfee_target').text(b6+'%');
	}
}

function rect(num){
	if(num>1){
		num=1;
	}
	num=num*100
	num=num.toFixed(2);
	return num;
}
	
