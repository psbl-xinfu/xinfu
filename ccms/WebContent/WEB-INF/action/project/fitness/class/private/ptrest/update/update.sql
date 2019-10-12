update cc_ptrest set
    ptlevelcode=${fld:vc_ptlevelcode},
    ptleftcount=${fld:f_ptleftcount},
    ptenddate=${fld:vc_ptenddate},
    cardcode=${fld:vc_usercode},
    ptid=${fld:vc_iuser},
    ptfee=${fld:f_ptfee},
    ptfactfee=${fld:f_ptfactfee},
    scale=${fld:f_scale},
    pttype=${fld:i_pttype},
    pttotalcount=${fld:f_pttotalcount},
    ptnormalmoney=${fld:f_ptnormalmoney},
    ptmoney=${fld:f_ptmoney}
where
	code = ${fld:vc_code} and org_id = ${def:org}
