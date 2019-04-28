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
 * @date 2019年4月24日
 * 
 */
public class doCourseEnd extends GenericTransaction {
	public int service(Recordset inputParams) throws Throwable {
		int rc = super.service(inputParams);
		Db db = getDb();
		Integer tuid = 0;
		String qrcodePath="成功";
		String basePath = "/com/ccms/api/customer/doCourseEndsql/";
		Date beginDate = new Date();
		Recordset getCourseInfo = new Recordset();
		boolean is_success=false;
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		Date xdate= df.parse(df.format(beginDate));
		SimpleDateFormat rq=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String intime = rq.format(beginDate);
		String operatelogsql = getLocalResource(basePath+"insert-operatelog.sql");
		operatelogsql = getSQL(operatelogsql, inputParams);
		String org_id="";
		String ptlogcode="";
		try {
			//场馆KEY
			String appid = inputParams.containsField("appid") ? inputParams.getString("appid") : "";
			if( null == appid || "".equals(appid) ){
				qrcodePath="提交参数appid不能为空";
				throw new Throwable(qrcodePath);
			}
			
			//课程预约ID
			String reservationID = inputParams.containsField("reservationID") ? inputParams.getString("reservationID") : "";
			if( null == reservationID || "".equals(reservationID) ){
				qrcodePath="课程预约ID不能为空";
				throw new Throwable(qrcodePath);
			}
			
			
			//	员工教练ID
			String employeeId = inputParams.containsField("employeeId") ? inputParams.getString("employeeId") : "";
			if( null == employeeId || "".equals(employeeId) ){
				qrcodePath="员工教练ID不能为空";
				throw new Throwable(qrcodePath);
			}
			
			//	会员ID
			String userId = inputParams.containsField("userId") ? inputParams.getString("userId") : "";
			if( null == userId || "".equals(userId) ){
				qrcodePath="会员ID不能为空";
				throw new Throwable(qrcodePath);
			}
			
			//	会员ID
			String number = inputParams.containsField("number") ? inputParams.getString("number") : "";
			/*if( null == number || "".equals(number) ){
				qrcodePath="此次课时数不能为空";
				throw new Throwable(qrcodePath);
			}*/
	
			//根据appid获取门店id
			String atubesql = getLocalResource(basePath+"query-atube.sql");
			atubesql = getSQL(atubesql, inputParams);
			atubesql = StringUtil.replace(atubesql, "${fld:appid}", "'"+appid+"'");
			
			Recordset queryatube= db.get(atubesql);
			if( null == queryatube || queryatube.getRecordCount() <= 0 ){
				qrcodePath="未找到该门店。appid："+appid+";教练编号："+employeeId+";会员编号"+userId;
				tuid=1;
				saveorg(operatelogsql, qrcodePath, appid, employeeId, xdate, intime);
				throw new Throwable(qrcodePath);
				
			}
			queryatube.first();
			org_id=queryatube.getString("org_id");
			
			//zyb 20190424 获取ptlog的code
			String ptlogcodesql = getLocalResource(basePath+"query-ptlog.sql");
			ptlogcodesql = getSQL(ptlogcodesql, inputParams);
			ptlogcodesql = StringUtil.replace(ptlogcodesql, "${fld:reservationID}", "'"+reservationID+"'");
			ptlogcodesql = StringUtil.replace(ptlogcodesql, "${fld:org}", "'"+org_id+"'");
			ptlogcodesql = StringUtil.replace(ptlogcodesql, "${fld:employeeId}", "'"+employeeId+"'");
			ptlogcodesql = StringUtil.replace(ptlogcodesql, "${fld:userId}", "'"+userId+"'");
			Recordset queryptlogcode = db.get(ptlogcodesql);
			if( null == queryptlogcode || queryptlogcode.getRecordCount() <= 0 ){
				qrcodePath="未找到上课记录。会员编号："+userId+"教练编号："+employeeId;
				tuid=1;
				save(operatelogsql, qrcodePath,employeeId , userId, xdate, intime, org_id);
				throw new Throwable(qrcodePath);
				
			}
			queryptlogcode.first();
			//ptlog的id
			ptlogcode= queryptlogcode.getString("code");
			String quittingtime=queryptlogcode.getString("quittingtime");
			if(quittingtime==""||quittingtime==null) {
				//修改该条的记录的下课时间
				String updatesql = getLocalResource(basePath+"update.sql");
				updatesql = getSQL(updatesql, inputParams);
				updatesql = StringUtil.replace(updatesql, "${fld:ptlogcode}", "'"+ptlogcode+"'");
				updatesql = StringUtil.replace(updatesql, "${fld:org}", "'"+org_id+"'");
				db.addBatchCommand(updatesql);
				db.exec();
				save(operatelogsql, qrcodePath, employeeId,userId , xdate, intime, org_id);
			}else {
				qrcodePath="该课已签退。会员编号："+userId+"教练编号："+employeeId;
				tuid=1;
				save(operatelogsql, qrcodePath,employeeId , userId, xdate, intime, org_id);
				throw new Throwable(qrcodePath);
			}
			
			
		} catch(Throwable t) {
			t.printStackTrace();
		} finally {
			getCourseInfo.append("is_success", Types.VARCHAR);
			getCourseInfo.append("msg", Types.VARCHAR);
			getCourseInfo.addNew();
			getCourseInfo.setValue("is_success", is_success);
			getCourseInfo.setValue("msg", qrcodePath);
			publish("_doCourseEnd", getCourseInfo);
		}
		return rc;
	}
	public void saveorg(String sql, String qrcodePath,String appid,String employeeId,Date xdate,String intime) throws Throwable
	{
		//zyb add  添加日志记录
		Db db = getDb();
		sql = StringUtil.replace(sql, "${fld:remark}", "'"+qrcodePath+"'");
		sql = StringUtil.replace(sql, "${fld:createdby}", "'"+appid+"'");
		sql = StringUtil.replace(sql, "${fld:mobile}", "'"+employeeId+"'");
		sql = StringUtil.replace(sql, "${fld:createdate}", "'"+xdate+"'");
		sql = StringUtil.replace(sql, "${fld:createtime}", "'"+intime+"'");
		//ZYB  添加方法
		db.addBatchCommand(sql);
		db.exec();
	}
	
	public void save(String sql, String qrcodePath,String employeeId,String userId,Date xdate,String intime,String org_id) throws Throwable
	{
		//zyb add  添加日志记录
		Db db = getDb();
		sql = StringUtil.replace(sql, "${fld:remark}", "'"+qrcodePath+"'");
		sql = StringUtil.replace(sql, "${fld:createdby}", "'"+employeeId+"'");
		sql = StringUtil.replace(sql, "${fld:userId}", "'"+userId+"'");
		sql = StringUtil.replace(sql, "${fld:createdate}", "'"+xdate+"'");
		sql = StringUtil.replace(sql, "${fld:createtime}", "'"+intime+"'");
		sql = StringUtil.replace(sql, "${fld:org_id}", "'"+org_id+"'");
		//ZYB  添加方法
		db.addBatchCommand(sql);
		db.exec();
	}
}