select 
    cust.code as cust_code,
    cust.name,
    get_arr_value(p.relatedetail,0) as moneycashone,--赠送前储值金额
    get_arr_value(p.relatedetail,1) as moneycashtwo,--赠送金额
    get_arr_value(p.relatedetail,2) as moneygiftone,--赠送前运动基金金额
    get_arr_value(p.relatedetail,3) as moneygifttwo,--赠送运动基金金额
    (select name from hr_staff where userlogin = p.createdby) as createdby,
    concat(p.createdate, ' ', p.createtime) as createdate,
    p.remark
from cc_operatelog p
left join cc_customer cust on p.customercode = cust.code and p.org_id = cust.org_id
where opertype = '67' and p.org_id = ${def:org}
${filter}
${orderby}

