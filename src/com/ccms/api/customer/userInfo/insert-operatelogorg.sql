insert into cc_operatelog(
code
,opertype
,status
,remark
,createdby
,createdate
,createtime
,customercode
)values(
NEXTVAL('seq_cc_operatelog')
,103
,1
,${fld:remark}
,${fld:createdby}
,${fld:createdate}
,${fld:createtime}
,${fld:mobile}
)