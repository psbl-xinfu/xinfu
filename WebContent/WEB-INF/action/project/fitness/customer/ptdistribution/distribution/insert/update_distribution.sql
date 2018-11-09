update cc_customer set
  pt= ${fld:pt},     ---------私人教练
  ---c_ptdistributetime='${def:timestamp}',       ------ '私教分配时间';
   ptdistributetime={ts '${def:timestamp}'},  
  ptfp= 1    -------私教分配状态：0待分配、1已分配、2作废、3过期、4成交';
where
  code = ${fld:customercode}
