package com.ccms.api.customer;

import java.io.PrintWriter;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import com.fasterxml.jackson.databind.ObjectMapper;

import dinamica.Db;
import dinamica.GenericTransaction;
import dinamica.Recordset;
import dinamica.StringUtil;
/**
 * @author 赵亚斌
 * @date 2019年4月22日
 * 获取所有预约课程和所有签课的课程（注：有下课的时间的除外）doType为  上课时，值 = 1，下课时，值 = 2（注：1是查找所有的预约可。2是查找所有的签课（不包括有下课时间的记录））
 */
public class getCourse extends GenericTransaction{

	public int service(Recordset inputParams) throws Throwable {
		int rc = super.service(inputParams);
		Db db = getDb();
		Integer tuid = 1;
		String qrcodePath="失败";
		// add by leo 190329 增加返回接口参数定义
		String errcode="1"; // 为0通过，为1不通过
		String errmsg="验证未开始";
		String basePath = "/com/ccms/api/customer/coursesql/";
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
		String eservation=null;
		String appid="";
		String employeeId="";
		int status=0;
		try {
			//场馆KEY
			appid = inputParams.containsField("appid") ? inputParams.getString("appid") : "";
			if( null == appid || "".equals(appid) ){
				qrcodePath="提交参数appid不能为空";
				throw new Throwable(qrcodePath);
			}
			//	员工教练ID
			employeeId = inputParams.containsField("employeeId") ? inputParams.getString("employeeId") : "";
			if( null == employeeId || "".equals(employeeId) ){
				qrcodePath="员工教练ID不能为空";
				throw new Throwable(qrcodePath);
			}
			//操作类型   doType为上课时，值 = 1，下课时，值 = 2
			String doType = inputParams.containsField("doType") ? inputParams.getString("doType") : "";
			if( null == doType || "".equals(doType) ){
				qrcodePath="操作类型不可以为空";
				throw new Throwable(qrcodePath);
			}
			//根据appid获取门店id
			String atubesql = getLocalResource(basePath+"query-atube.sql");
			atubesql = getSQL(atubesql, inputParams);
			atubesql = StringUtil.replace(atubesql, "${fld:appid}", "'"+appid+"'");
			
			Recordset queryatube= db.get(atubesql);
			if( null == queryatube || queryatube.getRecordCount() <= 0 ){
				qrcodePath="未找到该门店。appid："+appid+";教练编号："+employeeId;
				throw new Throwable(qrcodePath);
				
			}
			queryatube.first();
			org_id=queryatube.getString("org_id");
			
			String staffsql= getLocalResource(basePath+"query-staff.sql");
			staffsql = getSQL(staffsql, inputParams);
			staffsql = StringUtil.replace(staffsql, "${fld:userlogin}", "'"+employeeId+"'");
			staffsql = StringUtil.replace(staffsql, "${fld:org}", "'"+org_id+"'");
			Recordset querystaffsql= db.get(staffsql);
			if( null == querystaffsql || querystaffsql.getRecordCount() <= 0 ) {
				qrcodePath="未找到该教练。教练编号:"+employeeId;
				throw new Throwable(qrcodePath);
			}
			
			//zyb 20190423 获取教练的所有的预约课程
			String basesql = "SELECT" + 
					"	p.code as ReservationID" + 
					"	,(p.preparedate+p.preparetime) as ReservationTime" + 
					"	,p.status as ReservationStatus" + 
					"	,(select name from hr_staff where userlogin = (case when d.reatetype=1 then c.pt else p.ptid end) and org_id=${fld:org}) as EmployeeName" + 
					"	,p.customercode as MemberID" + 
					"	,c.name as MemberName" + 
					"	,c.mobile as MemberMobile" + 
					"	,d.ptlevelname as LessonName" + 
					"	,(case when p.status=2 then  g.leftcount::varchar else pr.ptleftcount::varchar end) as StillNumber" + 
					"	,d.times as ReservationNumber" + 
					"	,g.created as LessonStartTime" + 
					"	,g.quittingtime as LessonEndTime" + 
					" FROM cc_ptprepare p " + 
					" LEFT JOIN cc_ptlog g ON p.code = g.preparecode and p.org_id = g.org_id " + 
					" left join cc_ptrest pr on p.ptrestcode = pr.code and p.org_id = pr.org_id" + 
					" LEFT JOIN cc_ptdef d ON pr.ptlevelcode = d.code and d.org_id = pr.org_id" + 
					" LEFT JOIN hr_staff f ON p.ptid = f.userlogin" + 
					" LEFT JOIN cc_customer c ON p.customercode = c.code and p.org_id = c.org_id" + 
					" WHERE p.org_id = ${fld:org} and p.status=${fld:status}" + 
					" and p.ptid = ${fld:employeeId} ";
			if(doType.equals("1")) {
				status=1;
			}
			if(doType.equals("2")) {
				status=2;
				basesql+=" and g.quittingtime is null";
			}
			basesql = getSQL(basesql, inputParams);
			basesql = StringUtil.replace(basesql, "${fld:employeeId}", "'"+employeeId+"'");
			basesql = StringUtil.replace(basesql, "${fld:org}", "'"+org_id+"'");
			basesql = StringUtil.replace(basesql, "${fld:status}", "'"+status+"'");
			Recordset querybase = db.get(getSQL(basesql, null));
			if( null == querybase || querybase.getRecordCount() <= 0 ){
				qrcodePath="该教练没有预约课程。教练编号："+employeeId;
				throw new Throwable(qrcodePath);
				
			}
			List<PrepareBean> list = new ArrayList<>();
			while(querybase.next()){
				PrepareBean bean =new PrepareBean();
				if(querybase.getString("employeename")==null) {
					bean.setEmployeeName("");
				}else {
					bean.setEmployeeName(querybase.getString("employeename"));
				}
				
				if(querybase.getString("lessonendtime")==null) {
					bean.setLessonEndTime("");
				}else {
					bean.setLessonEndTime(querybase.getString("lessonendtime"));
				}
				
				if(querybase.getString("lessonname")==null) {
					bean.setLessonName("");
				}else {
					bean.setLessonName(querybase.getString("lessonname"));
				}
				
				if(querybase.getString("lessonstarttime")==null) {
					bean.setLessonStartTime("");
				}else {
					bean.setLessonStartTime(querybase.getString("lessonstarttime"));
				}
				
				if(querybase.getString("memberid")==null) {
					bean.setMemberID("");
				}else {
					bean.setMemberID(querybase.getString("memberid"));
				}
				
				if(querybase.getString("membermobile")==null) {
					bean.setMemberMobile("");
				}else {
					bean.setMemberMobile(querybase.getString("membermobile"));
				}
				
				if(querybase.getString("membername")==null) {
					bean.setMemberName("");
				}else {
					bean.setMemberName(querybase.getString("membername"));
				}
				
				if(querybase.getString("reservationid")==null) {
					bean.setReservationID("");
				}else {
					bean.setReservationID(querybase.getString("reservationid"));
				}
				
				if(querybase.getString("reservationnumber")==null) {
					bean.setReservationNumber("");
				}else {
					bean.setReservationNumber(querybase.getString("reservationnumber"));
				}
				
				if(querybase.getString("reservationstatus")==null) {
					bean.setReservationStatus("");
				}else {
					bean.setReservationStatus(querybase.getString("reservationstatus"));
				}
				
				if(querybase.getString("reservationtime")==null) {
					bean.setReservationTime("");
				}else {
					bean.setReservationTime(querybase.getString("reservationtime"));
				}
				
				if(querybase.getString("stillnumber")==null) {
					bean.setStillNumber("");
				}else {
					bean.setStillNumber(querybase.getString("stillnumber"));
				}
				
				list.add(bean);
			}
			ObjectMapper mapper = new ObjectMapper();
			eservation = mapper.writeValueAsString(list);
			tuid=0;
			qrcodePath="成功";
			is_success=true;
		} catch(Throwable t) {
			t.printStackTrace();
		} finally {
			save(operatelogsql, qrcodePath, appid,employeeId , xdate, intime, org_id);
			getCourseInfo.append("is_success", Types.VARCHAR);
			getCourseInfo.append("msg", Types.VARCHAR);
			getCourseInfo.append("eservation", Types.VARCHAR);
			getCourseInfo.addNew();
			getCourseInfo.setValue("is_success", is_success);
			getCourseInfo.setValue("msg", qrcodePath);
			getCourseInfo.setValue("eservation", eservation);
			publish("_getCourse", getCourseInfo);
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
	
	public void save(String sql, String qrcodePath,String appid,String employeeId,Date xdate,String intime,String org_id) throws Throwable
	{
		//zyb add  添加日志记录
		Db db = getDb();
		sql = StringUtil.replace(sql, "${fld:remark}", "'"+qrcodePath+"'");
		sql = StringUtil.replace(sql, "${fld:createdby}", "'"+appid+"'");
		sql = StringUtil.replace(sql, "${fld:employeeId}", "'"+employeeId+"'");
		sql = StringUtil.replace(sql, "${fld:createdate}", "'"+xdate+"'");
		sql = StringUtil.replace(sql, "${fld:createtime}", "'"+intime+"'");
		sql = StringUtil.replace(sql, "${fld:org_id}", "'"+org_id+"'");
		//ZYB  添加方法
		db.addBatchCommand(sql);
		db.exec();
	}
	
}
