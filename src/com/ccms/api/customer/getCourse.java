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
 * 
 */
public class getCourse extends GenericTransaction{

	public int service(Recordset inputParams) throws Throwable {
		int rc = super.service(inputParams);
		Db db = getDb();
		Integer tuid = 0;
		String qrcodePath="成功";
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
		int status=0;
		try {
			//场馆KEY
			String appid = inputParams.containsField("appid") ? inputParams.getString("appid") : "";
			if( null == appid || "".equals(appid) ){
				qrcodePath="提交参数appid不能为空";
				throw new Throwable(qrcodePath);
			}
			//	员工教练ID
			String employeeId = inputParams.containsField("employeeId") ? inputParams.getString("employeeId") : "";
			if( null == employeeId || "".equals(employeeId) ){
				qrcodePath="员工教练ID不能为空";
				throw new Throwable(qrcodePath);
			}
			//操作类型   上课时，值 = 1，下课时，值 = 2
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
				tuid=1;
				saveorg(operatelogsql, qrcodePath, appid, employeeId, xdate, intime);
				throw new Throwable(qrcodePath);
				
			}
			queryatube.first();
			org_id=queryatube.getString("org_id");
			
			//zyb 20190423 获取教练的所有的预约课程
			String basesql = "SELECT" + 
					"	p.code as ReservationID" + 
					"	,(p.preparedate+p.preparetime) as ReservationTime" + 
					"	,p.status as ReservationStatus" + 
					"	,(select name from hr_staff where userlogin = p.ptid) as EmployeeName" + 
					"	,p.customercode as MemberID" + 
					"	,c.name as MemberName" + 
					"	,c.mobile as MemberMobile" + 
					"	,d.ptlevelname as LessonName" + 
					"	,(case when p.status=2 then  g.leftcount::integer else pr.ptleftcount::integer end) as StillNumber" + 
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
					" and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id " + 
					"			where (hs.org_id = ${fld:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = ${fld:employeeId}))" + 
					"			and hss.userlogin = ${fld:employeeId} and hs.data_limit = 1)" + 
					"			then 1=1 else p.ptid = ${fld:employeeId} end)";
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
				tuid=1;
				save(operatelogsql, qrcodePath,appid , employeeId, xdate, intime, org_id);
				throw new Throwable(qrcodePath);
				
			}
			List<PrepareBean> list = new ArrayList<>();
			while(querybase.next()){
				PrepareBean bean =new PrepareBean();
				bean.setEmployeeName(querybase.getString("employeename"));
				bean.setLessonEndTime(querybase.getString("lessonendtime"));
				bean.setLessonName(querybase.getString("lessonname"));
				bean.setLessonStartTime(querybase.getString("lessonstarttime"));
				bean.setMemberID(querybase.getString("memberid"));
				bean.setMemberMobile(querybase.getString("membermobile"));
				bean.setMemberName(querybase.getString("membername"));
				bean.setReservationID(querybase.getString("reservationid"));
				bean.setReservationNumber(querybase.getString("reservationnumber"));
				bean.setReservationStatus(querybase.getString("reservationstatus"));
				bean.setReservationTime(querybase.getString("reservationtime"));
				bean.setStillNumber(querybase.getString("stillnumber"));
				list.add(bean);
			}
			ObjectMapper mapper = new ObjectMapper();
			eservation = mapper.writeValueAsString(list);
	        		
			save(operatelogsql, qrcodePath, appid,employeeId , xdate, intime, org_id);
			
		} catch(Throwable t) {
			t.printStackTrace();
		} finally {
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
