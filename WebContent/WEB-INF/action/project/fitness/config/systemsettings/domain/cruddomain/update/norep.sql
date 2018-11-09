select 1 from t_domain where domain_value=${fld:domain_value}
and "namespace" = ${fld:namespace} and tuid != ${fld:tuid}