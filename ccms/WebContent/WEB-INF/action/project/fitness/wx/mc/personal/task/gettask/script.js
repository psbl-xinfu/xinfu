//会籍
var guest_target=0.0,follow_target=0.0,prepare_target=0.0,visit_target=0.0,ordernum_target=0.0,orderfee_target=0.0;
<rows>
	//会籍
	guest_target="${fld:guest_target}";
	follow_target="${fld:follow_target}";
	prepare_target="${fld:prepare_target}";
	visit_target="${fld:visit_target}";
	ordernum_target="${fld:ordernum_target}";
	orderfee_target="${fld:orderfee_target}";
</rows>

<num>
if("${fld:num}"==0){
	$('#guest_daynum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==1){
	$('#guest_monnum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==2){
	$('#genjin_daynum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==3){
	$('#genjin_monnum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==4){
	$('#pre_daynum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==5){
	$('#pre_monnum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==6){
	$('#precome_daynum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==7){
	$('#precome_monnum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==8){
	$('#contract_daynum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==9){
	$('#contract_monnum').text(Number("${fld:guest_daynum}"));
}else if("${fld:num}"==10){
	$('#contractprice_daynum').text("${fld:guest_daynum}");
}else if("${fld:num}"==11){
	$('#contractprice_monnum').text("${fld:guest_daynum}");
}
</num>
chengjiaobi();

function chengjiaobi(){
	if(guest_target!=0){
		var b1=Number($('#guest_monnum').text()/guest_target);
		b1=rect(b1);
		$('#guest_target').text(b1+'%');
	}else{
		$('#guest_target').text(100+'%');
	}
	
	if(follow_target!=0){
	var b2=Number($('#genjin_monnum').text()/follow_target);
	b2=rect(b2);
	$('#follow_target').text(b2+'%');
	}else{
	$('#follow_target').text(100+'%');
	}
	
	if(prepare_target!=0){
	var b3=Number($('#pre_monnum').text()/prepare_target);
	b3=rect(b3);
	$('#prepare_target').text(b3+'%');
	}else{
	$('#prepare_target').text(100+'%');
	}
	
	if(visit_target!=0){
	var b4=Number($('#precome_monnum').text()/visit_target);
	b4=rect(b4);
	$('#visit_target').text(b4+'%');
	}else{
	$('#visit_target').text(100+'%');
	}
	
	if(ordernum_target!=0){
	var b5=Number($('#contract_monnum').text()/ordernum_target);
	b5=rect(b5);
	$('#ordernum_target').text(b5+'%');
	}else{
	$('#ordernum_target').text(100+'%');
	}
	
	if(orderfee_target!=0){
	var b6=Number($('#contractprice_monnum').text()/orderfee_target);
	b6=rect(b6);
	$('#orderfee_target').text(b6+'%');
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
	
