select staff.userlogin as ptuserlogin,staff.name as yuanptname from hr_staff staff
INNER JOIN cc_ptdef_limit ptdeflimit on  ptdeflimit.pt=staff.userlogin
INNER JOIN cc_ptdef ptdef on ptdef.code=ptdeflimit.ptdefcode
where  staff.org_id = ${fld:org_id}  and ptdef.code =${fld:code}