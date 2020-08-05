SELECT code as branchcode,storename as branchname
FROM cc_guest 
where guestcode=${fld:guestcode}
