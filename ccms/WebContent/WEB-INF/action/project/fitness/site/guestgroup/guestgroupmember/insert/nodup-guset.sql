select 1 from cc_guest_group_member 
where pkvalue = ${fld:pkvalue} and guesttype=${fld:guesttype} and org_id = ${def:org}
and groupid = ${fld:groupid}