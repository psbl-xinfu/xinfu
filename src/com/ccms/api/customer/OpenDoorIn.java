package com.ccms.api.customer;

import java.sql.Types;

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
public class OpenDoorIn extends GenericTransaction {
	public int service(Recordset inputParams) throws Throwable {
		int rc = super.service(inputParams);
		String qrcodePath = "";
		Integer tuid = null;
		// add by leo 190329 增加返回接口参数定义
		String errcode="1"; // 为0通过，为1不通过
		String errmsg="验证未开始";
		try {
			// 验证参数
			//商家授权id，可使用验证设备有效性
			String appid = inputParams.containsField("appid") ? inputParams.getString("appid") : "";
			if( null == appid || "".equals(appid) ){
				errmsg="提交参数appid不能为空";
				throw new Throwable("提交参数appid不能为空");
			}
			//用户编号
			String uid = inputParams.containsField("uid") ? inputParams.getString("uid") : "";
			if( null == uid || "".equals(uid) ){
				errmsg="提交参数uid不能为空";
				throw new Throwable("提交参数uid不能为空");
			}
			//设备编号
			String deviceID = inputParams.containsField("deviceID") ? inputParams.getString("deviceID") : "";
			if( null == deviceID || "".equals(deviceID) ){
				errmsg="提交参数deviceID不能为空";
				throw new Throwable("提交参数deviceID不能为空");
			}
			//进出类型0进，1出
			String type = inputParams.containsField("type") ? inputParams.getString("type") : "";
			if( null == type || "".equals(type) ){
				errmsg="提交参数type不能为空";
				throw new Throwable("提交参数type不能为空");
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
				errmsg="提交参数verifyType不能为空";
				throw new Throwable("提交参数verifyType不能为空");
			}
			
			// add by leo 190401 类里执行sql参考根据情况修改 begin
			Db db = getDb();
			String queryStaff = "SELECT qrcode_path, org_id, md5(concat(org_id, '###', user_id)) AS qrcode_value FROM hr_staff WHERE userlogin = ${fld:pk_value} AND org_id = ${def:org}";
			queryStaff = getSQL(queryStaff, inputParams);
			Recordset rsStaff = db.get(queryStaff);
			if( null == rsStaff || rsStaff.getRecordCount() <= 0 ){
				throw new Throwable("未找到相关员工信息");
			}
			rsStaff.first();

			String querySeq = getLocalResource("/transactions/project/fitness/weixin/sql/qrcode/query-qrcode-seq.sql");
			Recordset rsSeq = db.get(querySeq);
			String insertQrcode = getLocalResource("/transactions/project/fitness/weixin/sql/qrcode/insert-qrcode.sql");
			insertQrcode = getSQL(insertQrcode, inputParams);
			insertQrcode = StringUtil.replace(insertQrcode, "${tuid}", String.valueOf(tuid));db.exec(insertQrcode);
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
			publish("_rsOpenDoorIn", rsOpenDoorIn);
		}
		return rc;
	}
}
