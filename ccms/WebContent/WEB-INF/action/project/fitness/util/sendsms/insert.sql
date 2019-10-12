insert into cc_sms 
(
   tuid,--"."tuid" IS '短信任务编号';
   msg_type,--" IS '信息类型(0短信1彩信)';
   cust_code,--" IS '客户编号';
   receiver,--" IS '接受人手机号码';
   status,--" IS '发送状态(0-未发送,1-成功发送,2-发送失败)';
   created,--" IS '创建时间';
   createdby,--" IS '创建人代码';
   account_id,--" IS '发送帐号代码';
   template_id,--" IS '模版ID';
   subject_id
)
select
    ${seq:nextval@seq_cc_sms},
	0,
	t.vc_custcode,
    c.mobile,
	0,
	'${def:timestamp}',
	'${def:user}',
	(select cs.tuid from cc_sms_template cs where cs.tuid = ${fld:template_id}),
	${fld:template_id},
	${def:org}
from cc_customer c 
inner join (
	select regexp_split_to_table(${fld:vc_customercode},';') as vc_custcode
) as t on c.code = t.vc_custcode
where c.mobile is not null and c.mobile != '' and c.org_id = ${def:org}
 