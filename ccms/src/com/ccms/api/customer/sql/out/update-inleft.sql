update cc_inleft set
	lefttime='${def:timestamp}',--离场时间
	leftuser=${fld:deviceID}, --离场操作人
	remark=${fld:remark}
where code=${fld:code} and org_id = ${fld:org}
