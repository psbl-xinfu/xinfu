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
,102
,1
,${fld:remark}
,${fld:employeeId}
,${fld:createdate}
,${fld:createtime}
,${fld:org_id}
,${fld:userId}
)