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
,104
,1
,${fld:remark}
,${fld:createdby}
,${fld:createdate}
,${fld:createtime}
,${fld:org_id}
,${fld:employeeId}
)