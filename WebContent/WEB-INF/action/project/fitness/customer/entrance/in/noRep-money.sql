select 1 from cc_customer cust
left join cc_card card on cust.code = card.customercode and cust.org_id = card.org_id
left join cc_cardtype ct on card.cardtype = ct.code and card.org_id = ct.org_id
where card.code = ${fld:cardcode} and card.org_id = ${fld:unionorgid}
and cust.moneycash<=0 and cust.moneygift<=0
and ct.type = 2

