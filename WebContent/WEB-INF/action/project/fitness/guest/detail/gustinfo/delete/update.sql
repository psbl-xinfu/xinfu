update cc_thecontact 
set branchcode = (select code from cc_branch where guestcode=${fld:guestcode} and states=0)
where branchcode=${fld:branchcode}