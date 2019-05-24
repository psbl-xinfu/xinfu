var stabin=0;
var bin="";
var fttuid="";
<emp-list>
	bin="${fld:ftcardcode}";
	stabin="${fld:ftstatus}";
	fttuid="${fld:fttuid}";
</emp-list>
if(stabin==1){
	$("#custall").val(bin);
}
