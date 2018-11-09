<code>
gettask("${fld:tuid}");
</code>

function gettask(code){
	getAjaxCall("/action/project/fitness/wx/mc/home/gettask/gettask?tuid="+code, false);
}
