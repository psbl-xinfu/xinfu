package com.ccms.api.customer;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import dinamica.Db;
import dinamica.GenericTransaction;
import dinamica.Recordset;
import dinamica.StringUtil;

/**
 * @author 赵亚斌
 * @date 2019年4月24日
 * 签课接口
 */
public class doCourseStart extends GenericTransaction{
	public int service(Recordset inputParams) throws Throwable {
		int rc = super.service(inputParams);
		Db db = getDb();
		Integer tuid = 0;
		String qrcodePath="成功";
		String basePath = "/com/ccms/api/customer/docoursestartsql/";
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
		String ptrestcode="";
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
			
			//zyb 20190424 获取ptrest的code
			String ptrestcodesql = getLocalResource(basePath+"query-ptrest.sql");
			ptrestcodesql = getSQL(ptrestcodesql, inputParams);
			ptrestcodesql = StringUtil.replace(ptrestcodesql, "${fld:reservationID}", "'"+reservationID+"'");
			ptrestcodesql = StringUtil.replace(ptrestcodesql, "${fld:org}", "'"+org_id+"'");
			Recordset queryptrestcode = db.get(ptrestcodesql);
			if( null == queryptrestcode || queryptrestcode.getRecordCount() <= 0 ){
				qrcodePath="未找到该会员的课程。会员编号："+userId;
				tuid=1;
				save(operatelogsql, qrcodePath,employeeId , userId, xdate, intime, org_id);
				throw new Throwable(qrcodePath);
				
			}
			queryptrestcode.first();
			//会员该课程的id
			ptrestcode= queryptrestcode.getString("ptrestcode");
			
			//判断这个时间段是不是可以签课
			String preparesql = getLocalResource(basePath+"query-prepare.sql");
			preparesql = getSQL(preparesql, inputParams);
			preparesql = StringUtil.replace(preparesql, "${fld:reservationID}", "'"+reservationID+"'");
			preparesql = StringUtil.replace(preparesql, "${fld:org}", "'"+org_id+"'");
			Recordset queryprepare = db.get(preparesql);
			if(  queryprepare.getRecordCount() >= 1 ){
				queryprepare.first();
				String preparedate=queryprepare.getString("preparedate");
				qrcodePath="该会员不能签到，请确认时间或状态。会员编号："+userId+";上课日期为："+preparedate;
				tuid=1;
				save(operatelogsql, qrcodePath,employeeId , userId, xdate, intime, org_id);
				throw new Throwable(qrcodePath);
				
			}
			//判断教练和会员是不是一个人
			String querysql = getLocalResource(basePath+"query-prepare.sql");
			querysql = getSQL(querysql, inputParams);
			querysql = StringUtil.replace(querysql, "${fld:reservationID}", "'"+reservationID+"'");
			querysql = StringUtil.replace(querysql, "${fld:org}", "'"+org_id+"'");
			Recordset query = db.get(querysql);
			if(  null == query || query.getRecordCount() <= 0  ){
				qrcodePath="该会员未预约课程。会员编号："+userId;
				tuid=1;
				save(operatelogsql, qrcodePath,employeeId , userId, xdate, intime, org_id);
				throw new Throwable(qrcodePath);
				
			}
			query.first();
			String customercode=query.getString("customercode");
			if(!customercode.equals(userId)){
				qrcodePath="该会员验证未通过。会员编号："+userId;
				tuid=1;
				save(operatelogsql, qrcodePath,employeeId , userId, xdate, intime, org_id);
				throw new Throwable(qrcodePath);
				
			}
			String ptid=query.getString("ptid");
			if(!ptid.equals(employeeId)){
				qrcodePath="该教练验证未通过。教练编号："+employeeId;
				tuid=1;
				save(operatelogsql, qrcodePath,employeeId , userId, xdate, intime, org_id);
				throw new Throwable(qrcodePath);
				
			}
			
			//修改该条的记录的状态
			String updatesql = getLocalResource(basePath+"update.sql");
			updatesql = getSQL(updatesql, inputParams);
			updatesql = StringUtil.replace(updatesql, "${fld:reservationID}", "'"+reservationID+"'");
			updatesql = StringUtil.replace(updatesql, "${fld:org}", "'"+org_id+"'");
			db.addBatchCommand(updatesql);
			//扣会员的课次
			String updateptleftcountsql = getLocalResource(basePath+"update-ptleftcount.sql");
			updateptleftcountsql = getSQL(updateptleftcountsql, inputParams);
			updateptleftcountsql = StringUtil.replace(updateptleftcountsql, "${fld:ptrestcode}", "'"+ptrestcode+"'");
			updateptleftcountsql = StringUtil.replace(updateptleftcountsql, "${fld:org}", "'"+org_id+"'");
			db.addBatchCommand(updateptleftcountsql);
			//生成日志添加到ptlog表中
			String insertptlogsql = getLocalResource(basePath+"insert-ptlog.sql");
			insertptlogsql = getSQL(insertptlogsql, inputParams);
			insertptlogsql = StringUtil.replace(insertptlogsql, "${fld:reservationID}", "'"+reservationID+"'");
			insertptlogsql = StringUtil.replace(insertptlogsql, "${fld:org}", "'"+org_id+"'");
			insertptlogsql = StringUtil.replace(insertptlogsql, "${fld:employeeId}", "'"+employeeId+"'");
			db.addBatchCommand(insertptlogsql);
			db.exec();
			save(operatelogsql, qrcodePath, employeeId,userId , xdate, intime, org_id);
		} catch(Throwable t) {
			t.printStackTrace();
		} finally {
			getCourseInfo.append("is_success", Types.VARCHAR);
			getCourseInfo.append("msg", Types.VARCHAR);
			getCourseInfo.addNew();
			getCourseInfo.setValue("is_success", is_success);
			getCourseInfo.setValue("msg", qrcodePath);
			publish("_doCourseStart", getCourseInfo);
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
