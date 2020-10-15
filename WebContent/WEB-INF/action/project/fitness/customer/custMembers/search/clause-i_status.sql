and (case ${fld:i_status} when '1' then bin.status='正常'
		when '2' then bin.status='未启用'
		when '3' then bin.status='存卡中'
		when '4' then bin.status='挂失中'
		when '5' then bin.status='停卡中'
		when '6' then bin.status='过期'
		else bin.status='无效'
	end) 

