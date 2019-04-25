insert into cc_operatelog(
code
,opertype
,status
,remark
,createdby
,createdate
,createtime
,org_id
,customercode
)values(
NEXTVAL('seq_cc_operatelog')
,106
,1
,concat('删除场馆key：',(select appid from cc_atube where code=${fld:cnfg_id}))
,'${def:user}'
,'${def:date}'
,'${def:timestamp}'
,'${def:org}'
,(select appid from cc_atube where code=${fld:cnfg_id})
)