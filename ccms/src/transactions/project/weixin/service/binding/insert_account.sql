INSERT	INTO
	ws_account
(
	 account_id
	,account_name
	,account_balance
	,created
	,createdby
	,userlogin
)
VALUES
(
	 ${seq:nextval@seq_ws_account}
	,${fld:name}
	,'0'
	,current_timestamp
	,${fld:userlogin}
	,${fld:userlogin}
)               