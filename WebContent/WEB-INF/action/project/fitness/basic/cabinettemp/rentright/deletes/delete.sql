--update cc_cabinettemp 
--set status = 2
--where
--	tuid::varchar in (
--		select regexp_split_to_table(${fld:id}, ',')
--	)

DELETE FROM cc_cabinettemp WHERE tuid::varchar in (
		select regexp_split_to_table(${fld:id}, ',')
	)