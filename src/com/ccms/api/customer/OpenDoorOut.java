package com.ccms.api.customer;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;

import dinamica.Db;
import dinamica.GenericTransaction;
import dinamica.Recordset;
import dinamica.StringUtil;

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
public class OpenDoorOut extends GenericTransaction {
	public int service(Recordset inputParams) throws Throwable {
		int rc = super.service(inputParams);
		Db db = getDb();
		Integer tuid = 1;
		String qrcodePath="退场失败";
		// add by leo 190329 增加返回接口参数定义
		String errcode="1"; // 为0通过，为1不通过
		String errmsg="验证未开始";
		String basePath = "/com/ccms/api/customer/sql/out/";
		
		String inleftAddSql = getLocalResource(basePath+"insert-inleft.sql");
		inleftAddSql = getSQL(inleftAddSql, inputParams);
		String inleftAdddevSql = getLocalResource(basePath+"insert-inleftdev.sql");
		inleftAdddevSql=getSQL(inleftAdddevSql, inputParams);
		String inleftAddcustSql = getLocalResource(basePath+"insert-inleftcust.sql");
		inleftAddcustSql = getSQL(inleftAddcustSql, inputParams);
		String inleftoutsql = getLocalResource(basePath+"insert-inleftout.sql");
		inleftoutsql = getSQL(inleftoutsql, inputParams);
		Date beginDate = new Date();
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		Date xdate= df.parse(df.format(beginDate));
		SimpleDateFormat rq=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String intime = rq.format(beginDate);
		try {
			// 验证参数
			//商家授权id，可使用验证设备有效性
			String appid = inputParams.containsField("appid") ? inputParams.getString("appid") : "";
			if( null == appid || "".equals(appid) ){
				qrcodePath="提交参数appid不能为空";
				throw new Throwable(qrcodePath);
			}
			//用户编号
			String uid = inputParams.containsField("uid") ? inputParams.getString("uid") : "";
			if( null == uid || "".equals(uid) ){
				qrcodePath="提交参数uid不能为空";
				throw new Throwable(qrcodePath);
			}
			//设备编号
			String deviceID = inputParams.containsField("deviceID") ? inputParams.getString("deviceID") : "";
			if( null == deviceID || "".equals(deviceID) ){
				qrcodePath="提交参数deviceID不能为空";
				throw new Throwable(qrcodePath);
			}
			//进出类型0进，1出
			String type = inputParams.containsField("type") ? inputParams.getString("type") : "";
			if( null == type || "".equals(type) ){
				qrcodePath="提交参数type不能为空";
				throw new Throwable(qrcodePath);
			}
			//用户身份类型1会员2私教3教练
			String userType = inputParams.containsField("userType") ? inputParams.getString("userType") : "";
			
			//用户身份类型暂不使用
//			if( null == userType || "".equals(userType) ){
//				errmsg="提交参数userType不能为空";
//				throw new Throwable("提交参数userType不能为空");
//			}
			//验证识别类型（1：指静脉 2：二维码 3：刷卡 4：人脸）
			String verifyType = inputParams.containsField("verifyType") ? inputParams.getString("verifyType") : "";
			if( null == verifyType || "".equals(verifyType) ){
				qrcodePath="提交参数verifyType不能为空";
				throw new Throwable(qrcodePath);
			}
			
			//zyb add根据设备号和appid去找门店编号
			String queryOrgId = "SELECT org_id FROM cc_device WHERE deviceid = ${fld:deviceid} AND appid = ${fld:appid}";
			queryOrgId = getSQL(queryOrgId, inputParams);
			queryOrgId = StringUtil.replace(queryOrgId, "${fld:deviceid}", "'"+deviceID+"'");
			queryOrgId = StringUtil.replace(queryOrgId, "${fld:appid}", "'"+appid+"'");
			Recordset rsOrgID = db.get(queryOrgId);
			if( null == rsOrgID || rsOrgID.getRecordCount() <= 0 ){
				qrcodePath="读取设备信息失败!设备号："+deviceID;
				savedev(inleftAdddevSql, uid, tuid,deviceID, qrcodePath);
				throw new Throwable(qrcodePath);
			}
			rsOrgID.first();
			
			String orgID = rsOrgID.getString("org_id");//zyb  门店id
			
			String membersOrgIdSql = "SELECT name,cardcode,org_id,mobile FROM cc_customer WHERE code = ${fld:uid}";
			membersOrgIdSql = getSQL(membersOrgIdSql, inputParams);
			membersOrgIdSql = StringUtil.replace(membersOrgIdSql, "${fld:uid}", "'"+uid+"'");
			Recordset queryMembersOrgId = db.get(membersOrgIdSql);
			if( null == queryMembersOrgId || queryMembersOrgId.getRecordCount() <= 0 ){
				qrcodePath="失败：未找到该会员!会员编号："+uid;
				savecust(inleftAddcustSql, uid, orgID, deviceID, tuid, qrcodePath);
				throw new Throwable(qrcodePath);
				
			}
		
			queryMembersOrgId.first();
			String membersOrgId =queryMembersOrgId.getString("org_id");//zyb  会员所在的门店id
			String membersCardcode=queryMembersOrgId.getString("cardcode");//zyb  默认刷卡卡号
			String membersName=queryMembersOrgId.getString("name");//zyb 会员姓名
			String memberMobile=queryMembersOrgId.getString("mobile");
			if(null == membersCardcode || membersCardcode == "") {
				qrcodePath="失败：未设置默认卡！手机号："+memberMobile;
				save(inleftAddSql, uid, membersCardcode, membersOrgId, orgID, deviceID, tuid, qrcodePath);
				throw new Throwable(qrcodePath);
			}
			
			//zyb 添加消息记录
			String messageaddsql = getLocalResource(basePath+"insert-message.sql");
			messageaddsql = getSQL(messageaddsql, inputParams);
			messageaddsql = StringUtil.replace(messageaddsql, "${fld:deviceid}", "'"+membersCardcode+"'");
			messageaddsql = StringUtil.replace(messageaddsql, "${fld:uid}", "'"+uid+"'");
			messageaddsql = StringUtil.replace(messageaddsql, "${fld:membersName}", "'"+membersName+"'");
			messageaddsql = StringUtil.replace(messageaddsql, "${fld:org}", "'"+orgID+"'");
			//Recordset messageadd = db.get(messageaddsql);
			db.addBatchCommand(messageaddsql);
			
			//判断是是新增还是修改
			String inleftinsql = "SELECT code FROM cc_inleft where indate = (select current_date)" + 
					"	and cardcode ='"+membersCardcode+"' and lefttime is null and intime is not null and org_id = "+orgID + 
					"	order by intime desc LIMIT 1";
			inleftinsql = getSQL(inleftinsql, inputParams);
			Recordset inleftin = db.get(inleftinsql);
			if( null == inleftin || inleftin.getRecordCount() <= 0 ){
				save(inleftoutsql, uid, membersCardcode, membersOrgId, orgID, deviceID, tuid, qrcodePath);
				throw new Throwable(qrcodePath);
				
			}
			inleftin.first();
			String in_inleft =inleftin.getString("code");
			
			String inleftinoutsql = "SELECT  COALESCE(code::int,0) as code FROM cc_inleft where indate = (select current_date)" + 
					"	and cardcode ='"+membersCardcode+"' and lefttime is not null and intime is not null and org_id = "+orgID + 
					"	order by intime desc LIMIT 1";
			inleftinoutsql = getSQL(inleftinoutsql, inputParams);
			Recordset inoutleftin = db.get(inleftinoutsql);
			if( null == inoutleftin || inoutleftin.getRecordCount() <= 0 ){
				String cardstartenddate = getLocalResource(basePath+"update-inleft.sql");
				cardstartenddate = getSQL(cardstartenddate, inputParams);
				cardstartenddate = StringUtil.replace(cardstartenddate, "${fld:code}", "'"+in_inleft+"'");
				cardstartenddate = StringUtil.replace(cardstartenddate, "${fld:org}", "'"+orgID+"'");
				cardstartenddate = StringUtil.replace(cardstartenddate, "${fld:remark}", "'"+qrcodePath+"'");
				cardstartenddate = StringUtil.replace(cardstartenddate, "${fld:deviceID}", "'"+deviceID+"'");
				db.addBatchCommand(cardstartenddate);
				db.exec();
				
			}else {
				inoutleftin.first();
				String inout_inleft =inoutleftin.getString("code");
				int inbin= Integer.valueOf(in_inleft);
				int intoutbin= Integer.valueOf(inout_inleft);
				if(inbin>intoutbin) {
					//zyb 添加出场的时间
					String cardstartenddate = getLocalResource(basePath+"update-inleft.sql");
					cardstartenddate = getSQL(cardstartenddate, inputParams);
					cardstartenddate = StringUtil.replace(cardstartenddate, "${fld:code}", "'"+in_inleft+"'");
					cardstartenddate = StringUtil.replace(cardstartenddate, "${fld:org}", "'"+orgID+"'");
					cardstartenddate = StringUtil.replace(cardstartenddate, "${fld:remark}", "'"+qrcodePath+"'");
					cardstartenddate = StringUtil.replace(cardstartenddate, "${fld:deviceID}", "'"+deviceID+"'");
					db.addBatchCommand(cardstartenddate);
					db.exec();
				}else {
					save(inleftoutsql, uid, membersCardcode, membersOrgId, orgID, deviceID, tuid, qrcodePath);
					throw new Throwable(qrcodePath);
				}
			}
			
			tuid=0;
			qrcodePath="成功";
		} catch(Throwable t) {
			t.printStackTrace();
		} finally {
			Recordset rsOpenDoorIn = new Recordset();
			rsOpenDoorIn.append("errcode", Types.VARCHAR);
			rsOpenDoorIn.append("errmsg", Types.VARCHAR);
			rsOpenDoorIn.addNew();
			rsOpenDoorIn.setValue("errcode", String.valueOf(tuid));
			rsOpenDoorIn.setValue("errmsg", qrcodePath);
			publish("_rsOpenDoorOut", rsOpenDoorIn);
		}
		return rc;
	}
	
	
	
	public void save(String inleftAddSql, String uid,String membersCardcode,String membersOrgId,String orgID,String deviceID,int type,String remark) throws Throwable
	{
		//zyb add  添加入场记录
		Db db = getDb();
		inleftAddSql = StringUtil.replace(inleftAddSql, "${fld:custcode}", "'"+uid+"'");
		inleftAddSql = StringUtil.replace(inleftAddSql, "${fld:cardcode}", "'"+membersCardcode+"'");
		inleftAddSql = StringUtil.replace(inleftAddSql, "${fld:unionorgid}", "'"+membersOrgId+"'");
		inleftAddSql = StringUtil.replace(inleftAddSql, "${fld:org}", "'"+orgID+"'");
		inleftAddSql = StringUtil.replace(inleftAddSql, "${fld:typet}", "'"+type+"'");
		inleftAddSql = StringUtil.replace(inleftAddSql, "${fld:deviceid}", "'"+deviceID+"'");
		inleftAddSql = StringUtil.replace(inleftAddSql, "${fld:remark}", "'"+remark+"'");
		//Recordset inleftAdd = db.get(inleftAddSql);
		//ZYB  添加方法
		db.addBatchCommand(inleftAddSql);
		db.exec();
	}
	
	//zyb  20190410 添加未找到该设备
	public void savedev(String inleftAdddev1Sql, String uid,int tuid,String deviceID,String remark) throws Throwable
	{
		//zyb add  添加入场记录
		Db db = getDb();
		inleftAdddev1Sql = StringUtil.replace(inleftAdddev1Sql, "${fld:custcode}", "'"+uid+"'");
		inleftAdddev1Sql = StringUtil.replace(inleftAdddev1Sql, "${fld:typet}", "'"+tuid+"'");
		inleftAdddev1Sql = StringUtil.replace(inleftAdddev1Sql, "${fld:deviceid}", "'"+deviceID+"'");
		inleftAdddev1Sql = StringUtil.replace(inleftAdddev1Sql, "${fld:remark}", "'"+remark+"'");
		//Recordset inleftAdd = db.get(inleftAddSql);
		//ZYB  添加方法
		db.addBatchCommand(inleftAdddev1Sql);
		db.exec();
	}
	//zyb  20190410 添加未找到会员
	public void savecust(String inleftAddcustSql, String uid,String orgID,String deviceID,int tuid,String remark) throws Throwable
	{
		//zyb add  添加入场记录
		Db db = getDb();
		inleftAddcustSql = StringUtil.replace(inleftAddcustSql, "${fld:custcode}", "'"+uid+"'");
		inleftAddcustSql = StringUtil.replace(inleftAddcustSql, "${fld:org}", "'"+orgID+"'");
		inleftAddcustSql = StringUtil.replace(inleftAddcustSql, "${fld:typet}", "'"+tuid+"'");
		inleftAddcustSql = StringUtil.replace(inleftAddcustSql, "${fld:deviceid}", "'"+deviceID+"'");
		inleftAddcustSql = StringUtil.replace(inleftAddcustSql, "${fld:remark}", "'"+remark+"'");
		//Recordset inleftAdd = db.get(inleftAddSql);
		//ZYB  添加方法
		db.addBatchCommand(inleftAddcustSql);
		db.exec();
	}
	
	
	public void saveout(String sql, String uid,String membersCardcode,String membersOrgId,String orgID,String deviceID,int type,String remark) throws Throwable
	{
		//zyb add  添加入场记录
		Db db = getDb();
		sql = StringUtil.replace(sql, "${fld:custcode}", "'"+uid+"'");
		sql = StringUtil.replace(sql, "${fld:cardcode}", "'"+membersCardcode+"'");
		sql = StringUtil.replace(sql, "${fld:unionorgid}", "'"+membersOrgId+"'");
		sql = StringUtil.replace(sql, "${fld:org}", "'"+orgID+"'");
		sql = StringUtil.replace(sql, "${fld:typet}", "'"+type+"'");
		sql = StringUtil.replace(sql, "${fld:deviceid}", "'"+deviceID+"'");
		sql = StringUtil.replace(sql, "${fld:remark}", "'"+remark+"'");
		//Recordset inleftAdd = db.get(inleftAddSql);
		//ZYB  添加方法
		db.addBatchCommand(sql);
		db.exec();
	}
}
