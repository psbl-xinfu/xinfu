insert into cc_operatelog(
code
,opertype
,status
,remark
,createdby
,createdate
,createtime
,org_id,
customercode
)values(
NEXTVAL('seq_cc_operatelog')
,101
,1
,concat('修改设备号：',(select deviceid from cc_device where code=${fld:cnfg_id}))
,'${def:user}'
,'${def:date}'
,'${def:timestamp}'
,'${def:org}',
${fld:dev_deviceid}
)