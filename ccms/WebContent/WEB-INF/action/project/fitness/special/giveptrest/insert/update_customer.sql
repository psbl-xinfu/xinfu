UPDATE cc_customer
SET pt = (
	SELECT
		(
			CASE
			WHEN cm.pt IS NULL THEN
				(
					SELECT
						(
							CASE
							WHEN pd.reatetype = 1 THEN
								pl.pt
							ELSE
								NULL
							END
						)
					FROM
						cc_ptdef pd
					LEFT JOIN cc_ptdef_limit pl ON pd.code = pl.ptdefcode
					AND pd.org_id = pl.org_id
					WHERE
						pd.org_id = ${def:org}
					AND pl.pt = ${fld:pt}
					AND pd.code = ${fld:defcode}
				)
			ELSE
				cm.pt
			END
		)
	FROM
		cc_customer cm
	WHERE
		cm.org_id = ${def:org}
	AND cm.code = ${fld:customercode}
)
WHERE
	org_id = ${def:org}
AND code = ${fld:customercode}