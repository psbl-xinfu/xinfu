DELETE FROM cc_cabinet_rent 
WHERE customercode =  (SELECT get_arr_value(relatedetail,11) FROM cc_contract WHERE code = ${fld:vc_code} and org_id = ${def:org}) 
AND cabinetcode = (SELECT get_arr_value(relatedetail,1) FROM cc_contract WHERE code = ${fld:vc_code} and org_id = ${def:org})
