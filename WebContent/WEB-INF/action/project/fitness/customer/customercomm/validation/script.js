var commurl = '${def:context}${def:actionroot}/custcomm?'
	+'guestcode=${fld:guestcode}&customercode=${fld:customercode}&cust_type=${fld:cust_type}&specialtype=${fld:specialtype}';
top.ccms.dialog.open({url : commurl, width:'1170',height:'600'});