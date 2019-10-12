var rand_code = "${fld:rand_code}";
var verify_code = "${fld:verify_code}";
verify_code = verify_code.toLowerCase();
if( verify_code == rand_code && "" != rand_code ){
	isverify = true;
}else{
	isverify = false;
}
