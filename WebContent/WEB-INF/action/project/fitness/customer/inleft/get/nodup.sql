SELECT 1 FROM cc_cabinettemp
WHERE cabinettempcode = ${fld:getcabinettempcode}
AND status = 2 and org_id = ${def:org}
