select
code,
created
from 
cc_testresult
where (
customercode=${fld:customercode}
or
guestcode=(select guestcode from cc_customer where code =${fld:customercode})
)
order by created  desc




