
if("${fld:type}"=="1"){
	if(parseInt("${fld:count}")!=parseInt("${fld:nowcount}")){
		$Dialog().confirm("该卡为次卡，已使用"
				+(parseInt("${fld:count}")-parseInt("${fld:nowcount}"))+"次,确定要升级吗？", function(){
			saveContract();
		});
	}else{
		saveContract();
	}
}else{
	saveContract();
}

