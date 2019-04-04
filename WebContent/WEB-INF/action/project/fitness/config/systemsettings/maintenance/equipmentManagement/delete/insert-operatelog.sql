insert into cc_operatelog(
code
,opertype
,status
,remark
,createdby
,createdate
,createtime
,org_id
)values(
NEXTVAL('seq_cc_operatelog')
,100
,1
,concat('删除设备号：',(select deviceid from cc_device where code='2'))
,'${def:user}'
,'${def:date}'
,'${def:timestamp}'
,'${def:org}'
)