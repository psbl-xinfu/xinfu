package com.ccms.api;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;

import dinamica.Db;
import dinamica.GenericTransaction;
import dinamica.Recordset;
import dinamica.StringUtil;
/**
 * @author 赵亚斌
 * @date 2019年4月17日
 * 
 */



/**  
 * All rights Reserved, Designed By gymjam.cn
 * @Title:  OpenDoorIn.java   
 * @Package com.ccms.api.customer   
 * @Description:    TODO(健身管理软件)   
 * @author: Leo    
 * @date:   2019年3月29日 上午9:12:17   
 * @version V2.0 
 * @Copyright: 2019 www.gymjam.cn Inc. All rights reserved. 
 */
public class bindUserVeinFinger extends GenericTransaction {
	public int service(Recordset inputParams) throws Throwable {
		int rc = super.service(inputParams);
		Db db = getDb();
		Integer tuid = 1;
		String qrcodePath="失败";
		// add by leo 190329 增加返回接口参数定义
		String errcode="1"; // 为0通过，为1不通过
		String errmsg="验证未开始";
		String basePath = "/com/ccms/api/sql/";
		Date beginDate = new Date();
		Recordset rsGetuserErr = new Recordset();
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		Date xdate= df.parse(df.format(beginDate));
		SimpleDateFormat rq=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String intime = rq.format(beginDate);
		
		String operatelogsql = getLocalResource(basePath+"insert-operatelog.sql");
		operatelogsql = getSQL(operatelogsql, inputParams);
		
		System.out.println("---------------------------------");
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
			//用户识别类型
			String	userType = inputParams.containsField("userType") ? inputParams.getString("userType") : "";
			if( null == userType || "".equals(userType) ){
				qrcodePath="用户识别类型";
				throw new Throwable(qrcodePath);
			}
			//用户编号
			String	uid = inputParams.containsField("uid") ? inputParams.getString("uid") : "";
			if( null == uid || "".equals(uid) ){
				qrcodePath="用户编号不可以为空";
				throw new Throwable(qrcodePath);
			}
			//验证云会员id	
			String	cloudId = inputParams.containsField("cloudId") ? inputParams.getString("cloudId") : "";
			if( null == cloudId || "".equals(cloudId) ){
				qrcodePath="验证云会员id不可以为空";
				throw new Throwable(qrcodePath);
			}
		
			//获取设备信息
			String devicesql = getLocalResource(basePath+"query-device.sql");
			devicesql = getSQL(devicesql, inputParams);
			devicesql = StringUtil.replace(devicesql, "${fld:deviceID}", "'"+deviceID+"'");
			devicesql = StringUtil.replace(devicesql, "${fld:appid}", "'"+appid+"'");
			Recordset querydevice= db.get(devicesql);
			if( null == querydevice || querydevice.getRecordCount() <= 0 ){
				qrcodePath="读取设备号失败！"+deviceID;
				String operatelogsql1 = getLocalResource(basePath+"insert-operatelogorg.sql");
				operatelogsql1 = getSQL(operatelogsql1, inputParams);
				operatelogsql1 = StringUtil.replace(operatelogsql1, "${fld:remark}", "'"+qrcodePath+"'");
				operatelogsql1 = StringUtil.replace(operatelogsql1, "${fld:createdby}", "'"+deviceID+"'");
				operatelogsql1 = StringUtil.replace(operatelogsql1, "${fld:uid}", "'"+uid+"'");
				operatelogsql1 = StringUtil.replace(operatelogsql1, "${fld:createdate}", "'"+xdate+"'");
				operatelogsql1 = StringUtil.replace(operatelogsql1, "${fld:createtime}", "'"+intime+"'");
				db.addBatchCommand(operatelogsql1);
				db.exec();
				throw new Throwable(qrcodePath);
			}
			querydevice.first();
			String orgId=querydevice.getString("org_id");
			//根据uid获取用户信息
			String custsql = getLocalResource(basePath+"query-cust.sql");
			custsql = getSQL(custsql, inputParams);
			custsql = StringUtil.replace(custsql, "${fld:uid}", "'"+uid+"'");
			Recordset querycust= db.get(custsql);
			if( null == querycust || querycust.getRecordCount() <= 0 ){
				String staffsql = getLocalResource(basePath+"query-staff.sql");
				staffsql = getSQL(staffsql, inputParams);
				staffsql = StringUtil.replace(staffsql, "${fld:uid}", "'"+uid+"'");
				staffsql = StringUtil.replace(staffsql, "${fld:org}", "'"+orgId+"'");
				Recordset querystaff= db.get(staffsql);
				if( null == querystaff || querystaff.getRecordCount() <= 0 ){
					qrcodePath="未找到该会员或教练"+uid;
					tuid=1;
					save(operatelogsql, qrcodePath, deviceID, uid, xdate, intime, orgId);
					throw new Throwable(qrcodePath);
				}else {
					tuid=0;
					qrcodePath="成功";
					save(operatelogsql, qrcodePath, deviceID, uid, xdate, intime, orgId);
				}
				
				
			}else {
				
				tuid=0;
				qrcodePath="成功";
				save(operatelogsql, qrcodePath, deviceID, uid, xdate, intime, orgId);
			}
			
		} catch(Throwable t) {
			t.printStackTrace();
		} finally {
			rsGetuserErr.append("errcode", Types.VARCHAR);
			rsGetuserErr.append("errmsg", Types.VARCHAR);
			rsGetuserErr.addNew();
			rsGetuserErr.setValue("errcode", String.valueOf(tuid));
			rsGetuserErr.setValue("errmsg", qrcodePath);
			publish("_rsGetuserErr", rsGetuserErr);
		}
		return rc;
	}
	public void save(String sql, String qrcodePath,String deviceID,String uid,Date xdate,String intime,String orgId) throws Throwable
	{
		//zyb add  添加日志记录
		Db db = getDb();
		sql = StringUtil.replace(sql, "${fld:remark}", "'"+qrcodePath+"'");
		sql = StringUtil.replace(sql, "${fld:createdby}", "'"+deviceID+"'");
		sql = StringUtil.replace(sql, "${fld:uid}", "'"+uid+"'");
		sql = StringUtil.replace(sql, "${fld:createdate}", "'"+xdate+"'");
		sql = StringUtil.replace(sql, "${fld:createtime}", "'"+intime+"'");
		sql = StringUtil.replace(sql, "${fld:org_id}", "'"+orgId+"'");
		//ZYB  添加方法
		db.addBatchCommand(sql);
		db.exec();
	}

	
}
