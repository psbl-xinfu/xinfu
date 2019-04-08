package com.ccms.api.customer;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

import dinamica.Db;
import dinamica.GenericTransaction;
import dinamica.Recordset;
import dinamica.StringUtil;
import transactions.project.fitness.util.ErpTools;
/**
 * @author 赵亚斌
 * @date 2019年4月4日
 * 
 */
public class getUserInfo extends GenericTransaction {
	public int service(Recordset inputParams) throws Throwable {
		int rc = super.service(inputParams);
		Db db = getDb();
		Integer tuid = 0;
		String qrcodePath="成功";
		// add by leo 190329 增加返回接口参数定义
		String errcode="1"; // 为0通过，为1不通过
		String errmsg="验证未开始";
		String basePath = "/com/ccms/api/customer/userInfo/";
		Date beginDate = new Date();
		Recordset rsOpenDoorIn = new Recordset();
		String uid="";
		String name="";
		String sex="";
		String userCode="";
		try {
			// 验证参数
			//商家授权id，可使用验证设备有效性
			String appid = inputParams.containsField("appid") ? inputParams.getString("appid") : "";
			if( null == appid || "".equals(appid) ){
				qrcodePath="提交参数appid不能为空";
				throw new Throwable(qrcodePath);
			}
			//设备编号
			String deviceID = inputParams.containsField("deviceID") ? inputParams.getString("deviceID") : "";
			if( null == deviceID || "".equals(deviceID) ){
				qrcodePath="提交参数deviceID不能为空";
				throw new Throwable(qrcodePath);
			}
			//用户身份类型1会员2私教3教练
			String codeType = inputParams.containsField("codeType") ? inputParams.getString("codeType") : "";
			//手机号
			userCode = inputParams.containsField("userCode") ? inputParams.getString("userCode") : "";
			if( null == userCode || "".equals(userCode) ){
				qrcodePath="手机号不能为空";
				throw new Throwable(qrcodePath);
			}
			String devicesql = getLocalResource(basePath+"query-device.sql");
			devicesql = getSQL(devicesql, inputParams);
			devicesql = StringUtil.replace(devicesql, "${fld:deviceID}", "'"+deviceID+"'");
			devicesql = StringUtil.replace(devicesql, "${fld:appid}", "'"+appid+"'");
			Recordset querydevice= db.get(devicesql);
			querydevice.first();
			String orgId=querydevice.getString("org_id");
			
			String custsql = getLocalResource(basePath+"query-cust.sql");
			custsql = getSQL(custsql, inputParams);
			custsql = StringUtil.replace(custsql, "${fld:userCode}", "'"+userCode+"'");
			custsql = StringUtil.replace(custsql, "${fld:org}", "'"+orgId+"'");
			Recordset querycust= db.get(custsql);
			if( null == querycust || querycust.getRecordCount() <= 0 ){
				qrcodePath="未找到该会员";
				tuid=1;
				SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
				Date xdate= df.parse(df.format(beginDate));
				SimpleDateFormat rq=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String intime = rq.format(beginDate);
				String operatelogsql = getLocalResource(basePath+"insert-operatelog.sql");
				operatelogsql = getSQL(operatelogsql, inputParams);
				operatelogsql = StringUtil.replace(operatelogsql, "${fld:remark}", "'"+qrcodePath+"'");
				operatelogsql = StringUtil.replace(operatelogsql, "${fld:createdby}", "'"+deviceID+"/"+userCode+"'");
				operatelogsql = StringUtil.replace(operatelogsql, "${fld:createdate}", "'"+xdate+"'");
				operatelogsql = StringUtil.replace(operatelogsql, "${fld:createtime}", "'"+intime+"'");
				operatelogsql = StringUtil.replace(operatelogsql, "${fld:org_id}", "'"+orgId+"'");
				db.addBatchCommand(operatelogsql);
				db.exec();
				throw new Throwable(qrcodePath);
				
			}
			querycust.first();
			 uid=querycust.getString("uid");
			 name=querycust.getString("name");
			 sex=querycust.getString("sex");

			
		} catch(Throwable t) {
			t.printStackTrace();
		} finally {
			rsOpenDoorIn.append("errcode", Types.VARCHAR);
			rsOpenDoorIn.append("errmsg", Types.VARCHAR);
			rsOpenDoorIn.append("uid", Types.VARCHAR);
			rsOpenDoorIn.append("userType", Types.VARCHAR);
			rsOpenDoorIn.append("name", Types.VARCHAR);
			rsOpenDoorIn.append("sex", Types.VARCHAR);
			rsOpenDoorIn.append("phone", Types.VARCHAR);
			rsOpenDoorIn.append("img", Types.VARCHAR);
			rsOpenDoorIn.addNew();
			rsOpenDoorIn.setValue("errcode", String.valueOf(tuid));
			rsOpenDoorIn.setValue("errmsg", qrcodePath);
			rsOpenDoorIn.setValue("uid", uid);
			rsOpenDoorIn.setValue("userType", 1);
			rsOpenDoorIn.setValue("name", name);
			rsOpenDoorIn.setValue("sex", sex);
			rsOpenDoorIn.setValue("phone", userCode);
			rsOpenDoorIn.setValue("img", null);
			publish("_rsOpenDoorIn", rsOpenDoorIn);
		}
		return rc;
	}
	
}