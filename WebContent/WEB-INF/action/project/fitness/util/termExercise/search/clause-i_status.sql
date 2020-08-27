and (case when (select count(status) from cc_card where cc_card.customercode =cust.code and isgoon='0' and status='1') >0 then '1' 
	when  (select count(status) from cc_card where cc_card.customercode =cust.code and isgoon='0' and status='2') >0 	then '2' 
	when  (select count(status) from cc_card where cc_card.customercode =cust.code and isgoon='0' and status='3') >0 	then '3' 
	when  (select count(status) from cc_card where cc_card.customercode =cust.code and isgoon='0' and status='4') >0 	then '4' 
	when  (select count(status) from cc_card where cc_card.customercode =cust.code and isgoon='0' and status='5') >0 	then '5' 
	when  (select count(status) from cc_card where cc_card.customercode =cust.code and isgoon='0' and status='6') >0 	then '6' 
	else  '0'
	end) = ${fld:i_status}
