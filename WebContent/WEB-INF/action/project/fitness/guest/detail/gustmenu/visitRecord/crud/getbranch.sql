SELECT code as branchcode,storename as branchname
FROM cc_branch 
where guestcode=${fld:guestcode}
