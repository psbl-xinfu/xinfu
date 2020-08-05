select 
	g.code,
	g.officename,
	g.mc
from cc_guest g
where
${filter}