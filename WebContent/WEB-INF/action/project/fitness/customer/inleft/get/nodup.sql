SELECT 1 FROM cc_cabinettemp
WHERE tuid = ${fld:getcabinettempcode}
AND status = 2 and org_id = ${def:org}
