update cc_cardcode set org_id=${fld:orgcode} where cardcode in
( select code from cc_card where customercode=${fld:customercode} )