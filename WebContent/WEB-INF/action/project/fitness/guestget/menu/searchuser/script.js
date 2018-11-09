
var userstr = "";
<user-rows>
	userstr+="<label><input type='checkbox' name='groupuser' value='${fld:userlogin}' class='checkbox-tag' >"
			+"<span class='checkbox-checked'>${fld:username}</span></label>";
</user-rows>
$("#groupuser").html(userstr);
$("#groupusercheckbox").show();
