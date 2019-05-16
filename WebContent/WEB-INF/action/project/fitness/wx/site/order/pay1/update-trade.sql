update
ws_sale_order
set
state='20'
where
trade_order_id=${fld:out_trade_no}::integer
