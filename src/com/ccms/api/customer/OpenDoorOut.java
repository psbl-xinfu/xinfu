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
		Integer tuid = 0;
		String qrcodePath="退场成功";
		// add by leo 190329 增加返回接口参数定义
		String errcode="1"; // 为0通过，为1不通过
		String errmsg="验证未开始";
		String basePath = "/com/ccms/api/customer/sql/out/";
		Date beginDate = new Date();
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
			
			// add by leo 190401 类里执行sql参考根据情况修改 begin
			//zyb add根据设备号和appid去找门店编号
			String queryOrgId = "SELECT org_id FROM cc_device WHERE deviceid = ${fld:deviceid} AND appid = ${fld:appid}";
			queryOrgId = getSQL(queryOrgId, inputParams);
			queryOrgId = StringUtil.replace(queryOrgId, "${fld:deviceid}", "'"+deviceID+"'");
			queryOrgId = StringUtil.replace(queryOrgId, "${fld:appid}", "'"+appid+"'");
			Recordset rsOrgID = db.get(queryOrgId);
		
			rsOrgID.first();
			
			String orgID = rsOrgID.getString("org_id");//zyb  门店id
			
			String membersOrgIdSql = "SELECT name,cardcode,org_id FROM cc_customer WHERE code = ${fld:uid}";
			membersOrgIdSql = getSQL(membersOrgIdSql, inputParams);
			membersOrgIdSql = StringUtil.replace(membersOrgIdSql, "${fld:uid}", "'"+uid+"'");
			Recordset queryMembersOrgId = db.get(membersOrgIdSql);
			
		
			queryMembersOrgId.first();
			String membersOrgId =queryMembersOrgId.getString("org_id");//zyb  会员所在的门店id
			String membersCardcode=queryMembersOrgId.getString("cardcode");//zyb  默认刷卡卡号
			String membersName=queryMembersOrgId.getString("name");//zyb 会员姓名
			
			
			//zyb 添加消息记录
			String messageaddsql = getLocalResource(basePath+"insert-message.sql");
			messageaddsql = getSQL(messageaddsql, inputParams);
			messageaddsql = StringUtil.replace(messageaddsql, "${fld:deviceid}", "'"+membersCardcode+"'");
			messageaddsql = StringUtil.replace(messageaddsql, "${fld:uid}", "'"+uid+"'");
			messageaddsql = StringUtil.replace(messageaddsql, "${fld:membersName}", "'"+membersName+"'");
			messageaddsql = StringUtil.replace(messageaddsql, "${fld:org}", "'"+orgID+"'");
			//Recordset messageadd = db.get(messageaddsql);
			db.addBatchCommand(messageaddsql);
			
			//zyb 修改卡的时间
			String cardstartenddate = getLocalResource(basePath+"update-inleft.sql");
			cardstartenddate = getSQL(cardstartenddate, inputParams);
			cardstartenddate = StringUtil.replace(cardstartenddate, "${fld:cardcode}", "'"+membersCardcode+"'");
			cardstartenddate = StringUtil.replace(cardstartenddate, "${fld:org}", "'"+orgID+"'");
			db.addBatchCommand(cardstartenddate);
			db.exec();
			// add by leo 190401 类里执行sql参考根据情况修改 end
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
}
