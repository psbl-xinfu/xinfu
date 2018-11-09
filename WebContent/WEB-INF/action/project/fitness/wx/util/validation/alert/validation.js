var msg = "${fld:message@js}";
msg = msg.replace(/<b>/g, "").replace(/<\/b>/g, "");
alert(msg);

//校验失败后的回调函数
if(typeof(afterValidationSetting)!="undefined" && afterValidationSetting!=null){
	afterValidationSetting();
}