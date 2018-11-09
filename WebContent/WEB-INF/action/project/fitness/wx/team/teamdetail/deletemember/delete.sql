delete from cc_guest_group_member
where tuid::varchar = ${fld:memberid}
and org_id = ${fld:org_id}
