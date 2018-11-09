var skill_scope=$('#skill_scope').val();
//会籍
var follow_target=0.0,site_target=0.0,test_target=0.0,unpayclass_target=0.0,allclass_target=0.0,ordernum_target=0.0,orderfee_target=0.0;
<rows>
	//pt
	follow_target="${fld:follow_target}";
	site_target="${fld:site_target}";
	test_target="${fld:test_target}";
	unpayclass_target="${fld:unpayclass_target}";
	allclass_target="${fld:allclass_target}";
	ordernum_target="${fld:ordernum_target}";
	orderfee_target="${fld:orderfee_target}";
</rows>

<num>
if("${fld:num}"==0){
	$('#genjin_daynum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==1){
	$('#genjin_monnum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==2){
	$('#site_daynum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==3){
	$('#site_monnum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==4){
	$('#test_daynum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==5){
	$('#test_monnum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==6){
	$('#unpayclass_daynum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==7){
	$('#unpayclass_monnum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==8){
	$('#allclass_daynum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==9){
	$('#allclass_monnum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==10){
	$('#contract_daynum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==11){
	$('#contract_monnum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==12){
	$('#contractprice_monnum').text("${fld:guest_daynum}");
}else if("${fld:num}"==13){
	$('#contractprice_monnum').text("${fld:guest_daynum}");
}
</num>
chengjiaobi();


function chengjiaobi(){
	if(follow_target!=0){
		var b1=Number($('#genjin_monnum').text()/follow_target);
		b1=rect(b1);
		$('#follow_target').text(b1+'%');
	}else{
		$('#follow_target').text(100+'%');
	}
	
	if(site_target!=0){
		var b2=Number($('#site_monnum').text()/site_target);
		b2=rect(b2);
		$('#site_target').text(b2+'%');
	}else{
		$('#site_target').text(100+'%');
	}
	
	if(test_target!=0){
		var b3=Number($('#test_monnum').text()/test_target);
		b3=rect(b3);
		$('#test_target').text(b3+'%');
	}else{
		$('#test_target').text(100+'%');
	}
	
	if(unpayclass_target!=0){
		var b4=Number($('#unpayclass_monnum').text()/unpayclass_target);
		b4=rect(b4);
		$('#unpayclass_target').text(b4+'%');
	}else{
		$('#unpayclass_target').text(100+'%');
	}
	
	if(allclass_target!=0){
		var b5=Number($('#allclass_monnum').text()/allclass_target);
		b5=rect(b5);
		$('#allclass_target').text(b5+'%');
	}else{
		$('#allclass_target').text(100+'%');
	}
	
	if(ordernum_target!=0){
		var b6=Number($('#contract_monnum').text()/ordernum_target);
		b6=rect(b6);
		$('#ordernum_target').text(b6+'%');
	}else{
		$('#ordernum_target').text(100+'%');
	}
	
	if(orderfee_target!=0){
		var b7=Number($('#contractprice_monnum').text()/orderfee_target);
		b7=rect(b7);
		$('#orderfee_target').text(b7+'%');
	}else{
		$('#orderfee_target').text(100+'%');
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
	
