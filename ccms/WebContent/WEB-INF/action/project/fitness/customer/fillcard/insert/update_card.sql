update cc_card set
	status=0,   
	isgoon=-1   --zzn 应该设为-1 ，1是续卡isgoon=1
where
	code=${fld:cardcode} and org_id = ${def:org} and isgoon = 0
