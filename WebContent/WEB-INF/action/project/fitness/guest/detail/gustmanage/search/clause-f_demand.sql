AND 
	EXISTS(
	select dem from (select regexp_split_to_table(${fld:f_demand},',') as dem from dual) as d
	WHERE g.demand like concat('%', d.dem, '%')
)