select g.code AS guestcode, NULL::VARCHAR AS customercode, g.org_id, g.mc,1 as datatype  from cc_guest g
where g.org_id = ${fld:org_id} and g.status!=99 and not EXISTS(
		select 1 from cc_public where org_id=${fld:org_id} 
)

UNION

select NULL::VARCHAR AS guestcode, c.code AS customercode, c.org_id, c.mc,2 as datatype from cc_customer c
where c.org_id= ${fld:org_id} and c.status!=0 and not EXISTS(
	select 1 from cc_public where org_id=${fld:org_id}
)
