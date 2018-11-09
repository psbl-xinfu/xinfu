UPDATE cc_feedback SET
	customercode=${fld:customer_code},
	fbtype=${fld:fbtype},
	isanonymous=${fld:isanonymous},
	complainttype=${fld:complainttype},
	complaint_userid=${fld:complaint_userid},
	complaint_skill=${fld:complaint_skill},
	complaint_item=${fld:complaint_item},
	complaint_envir=${fld:complaint_envir},
	fbremark=${fld:fbremark}
WHERE tuid=${fld:tuid};

