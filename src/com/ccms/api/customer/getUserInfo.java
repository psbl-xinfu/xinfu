package com.ccms.api.customer;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;


import dinamica.Db;
import dinamica.GenericTransaction;
import dinamica.Recordset;
import dinamica.StringUtil;
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
		Recordset rsGetuserInfo = new Recordset();
		String uid="";
		String name="";
		String sex="";
		String userCode="";
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		Date xdate= df.parse(df.format(beginDate));
		SimpleDateFormat rq=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String intime = rq.format(beginDate);
		
		String operatelogsql = getLocalResource(basePath+"insert-operatelog.sql");
		operatelogsql = getSQL(operatelogsql, inputParams);
		
		
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
			//识别码类型
			String codeType = inputParams.containsField("codeType") ? inputParams.getString("codeType") : "";
			//手机号
			userCode = inputParams.containsField("userCode") ? inputParams.getString("userCode") : "";
			if(codeType=="1") {
				if( null == userCode || "".equals(userCode) ){
					qrcodePath="手机号不能为空";
					throw new Throwable(qrcodePath);
				}
			}
			if(codeType=="3") {
				if( null == userCode || "".equals(userCode) ){
					qrcodePath="卡号不能为空";
					throw new Throwable(qrcodePath);
				}
			}
		
			
			//获取设备信息
			String devicesql = getLocalResource(basePath+"query-device.sql");
			devicesql = getSQL(devicesql, inputParams);
			devicesql = StringUtil.replace(devicesql, "${fld:deviceID}", "'"+deviceID+"'");
			devicesql = StringUtil.replace(devicesql, "${fld:appid}", "'"+appid+"'");
			Recordset querydevice= db.get(devicesql);
			if( null == querydevice || querydevice.getRecordCount() <= 0 ){
				qrcodePath="未找到该设备号";
				tuid=1;
				String operatelogsql1 = getLocalResource(basePath+"insert-operatelogorg.sql");
				operatelogsql1 = getSQL(operatelogsql1, inputParams);
				operatelogsql1 = StringUtil.replace(operatelogsql1, "${fld:remark}", "'"+qrcodePath+"'");
				operatelogsql1 = StringUtil.replace(operatelogsql1, "${fld:createdby}", "'"+deviceID+"'");
				operatelogsql1 = StringUtil.replace(operatelogsql1, "${fld:mobile}", "'"+userCode+"'");
				operatelogsql1 = StringUtil.replace(operatelogsql1, "${fld:createdate}", "'"+xdate+"'");
				operatelogsql1 = StringUtil.replace(operatelogsql1, "${fld:createtime}", "'"+intime+"'");
				db.addBatchCommand(operatelogsql1);
				db.exec();
				throw new Throwable(qrcodePath);
			}
			querydevice.first();
			String orgId=querydevice.getString("org_id");
			//获取当前时间
			
			if(codeType.equals("1")) {
				//根据手机号获取用户信息
				String custsql = getLocalResource(basePath+"query-cust.sql");
				custsql = getSQL(custsql, inputParams);
				custsql = StringUtil.replace(custsql, "${fld:userCode}", "'"+userCode+"'");
				custsql = StringUtil.replace(custsql, "${fld:org}", "'"+orgId+"'");
				Recordset querycust= db.get(custsql);
				if( null == querycust || querycust.getRecordCount() <= 0 ){
					qrcodePath="未找到该会员";
					tuid=1;
					save(operatelogsql, qrcodePath, deviceID, userCode, xdate, intime, orgId);
					throw new Throwable(qrcodePath);
					
				}
				querycust.first();
				uid=querycust.getString("uid");
				name=querycust.getString("name");
				sex=querycust.getString("sex");
			}
			if(codeType.equals("3")) {
				//根据卡号获取用户信息
				String custcardsql = getLocalResource(basePath+"query-custcard.sql");
				custcardsql = getSQL(custcardsql, inputParams);
				custcardsql = StringUtil.replace(custcardsql, "${fld:userCode}", "'"+userCode+"'");
				custcardsql = StringUtil.replace(custcardsql, "${fld:org}", "'"+orgId+"'");
				Recordset querycustcard= db.get(custcardsql);
				if( null == querycustcard || querycustcard.getRecordCount() <= 0 ){
					qrcodePath="未找到该会员";
					tuid=1;
					save(operatelogsql, qrcodePath, deviceID, userCode, xdate, intime, orgId);
					throw new Throwable(qrcodePath);
					
				}
				querycustcard.first();
				uid=querycustcard.getString("uid");
				name=querycustcard.getString("name");
				sex=querycustcard.getString("sex");
				
			}
			
			save(operatelogsql, qrcodePath, deviceID, userCode, xdate, intime, orgId);
			
		} catch(Throwable t) {
			t.printStackTrace();
		} finally {
			rsGetuserInfo.append("errcode", Types.VARCHAR);
			rsGetuserInfo.append("errmsg", Types.VARCHAR);
			rsGetuserInfo.append("uid", Types.VARCHAR);
			rsGetuserInfo.append("userType", Types.VARCHAR);
			rsGetuserInfo.append("name", Types.VARCHAR);
			rsGetuserInfo.append("sex", Types.VARCHAR);
			rsGetuserInfo.append("phone", Types.VARCHAR);
			rsGetuserInfo.append("img", Types.VARCHAR);
			rsGetuserInfo.addNew();
			rsGetuserInfo.setValue("errcode", String.valueOf(tuid));
			rsGetuserInfo.setValue("errmsg", qrcodePath);
			rsGetuserInfo.setValue("uid", uid);
			rsGetuserInfo.setValue("userType", 1);
			rsGetuserInfo.setValue("name", name);
			rsGetuserInfo.setValue("sex", sex);
			rsGetuserInfo.setValue("phone", userCode);
			rsGetuserInfo.setValue("img", null);
			publish("_rsGetuserInfo", rsGetuserInfo);
		}
		return rc;
	}
	public void save(String sql, String qrcodePath,String deviceID,String userCode,Date xdate,String intime,String orgId) throws Throwable
	{
		//zyb add  添加日志记录
		Db db = getDb();
		sql = StringUtil.replace(sql, "${fld:remark}", "'"+qrcodePath+"'");
		sql = StringUtil.replace(sql, "${fld:createdby}", "'"+deviceID+"'");
		sql = StringUtil.replace(sql, "${fld:mobile}", "'"+userCode+"'");
		sql = StringUtil.replace(sql, "${fld:createdate}", "'"+xdate+"'");
		sql = StringUtil.replace(sql, "${fld:createtime}", "'"+intime+"'");
		sql = StringUtil.replace(sql, "${fld:org_id}", "'"+orgId+"'");
		//ZYB  添加方法
		db.addBatchCommand(sql);
		db.exec();
	}
	
}
