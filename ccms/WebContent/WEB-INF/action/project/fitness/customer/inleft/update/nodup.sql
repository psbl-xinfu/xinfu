SELECT 1 FROM cc_cabinettemp
WHERE cabinettempcode = ${fld:newcabinettempcode}
AND status = 2 and org_id = ${def:org}
