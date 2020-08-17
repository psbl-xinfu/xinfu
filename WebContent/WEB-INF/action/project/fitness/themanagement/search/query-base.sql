select 
	the.code as thecode
	,the.name as thename
	,the.mobile as  themobile
	,g.code as gcode
	,g.officename as  gofficename
	,b.storename
	,p.posname
	,c.remark
	,to_char(c.created,'yyyy-MM-dd hh:MM:ss') as created
from 
cc_thecontact the 
left join cc_guest g on the.guestcode = g.code
left join cc_branch b on the.branchcode = b.code
left join cc_position p on the.possibility= p.code
left join 
(select thecontactcode,remark,created from cc_comm 
left join ( select max (code)as code from cc_comm group by thecontactcode)  cc on cc.code =cc_comm.code) c on c.thecontactcode=the.code
 
order by created
