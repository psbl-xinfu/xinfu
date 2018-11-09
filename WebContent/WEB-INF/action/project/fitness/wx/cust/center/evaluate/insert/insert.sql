insert into cc_ptlog_evaluation
(
    tuid,
    ptlogcode,--私教上课记录编号
    ptlevelcode,--私教课编号
    customercode,
    ptid,
    
    
    service_attitude	,--服务态度
    technical_guidance,--技术指导
    teach_length,--授课时长
    final_eval,
    
    remark,
    created,
	org_id
)
values 
(
	${seq:nextval@seq_cc_ptlog_evaluation},
    ${fld:ptlogcode},
    ${fld:ptlevelcode},
    ${fld:customercode},
    ${fld:ptid},
    
     ${fld:service_attitude},
     ${fld:technical_guidance},
     ${fld:teach_length},
     ${fld:final_eval},   
    
 ${fld:remark},   
 {ts'${def:timestamp}'},
 ${def:org}
)
