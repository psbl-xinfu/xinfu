﻿$("#passwd").val("");
$("#confirm").val("");
$("#oldPasswd").val("");
$Dialog().notice("修改成功", 1000,function(){
	ccms.dialog.close();
});
