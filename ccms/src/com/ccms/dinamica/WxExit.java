package com.ccms.dinamica;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import dinamica.Db;
import dinamica.GenericTableManager;
import dinamica.Recordset;
import dinamica.StringUtil;
import transactions.project.weixin.SecurityFilterForWeixin;

/**  
 * All rights Reserved, Designed By gymjam.cn
 * @Title:  WxExit.java   
 * @Package com.ccms.dinamica   
 * @Description:    TODO(健身管理软件) 微信退出跳到首页需单独处理 
 * @author: Leo    
 * @date:   2019年5月27日 上午9:40:42   
 * @version V2.0 
 * @Copyright: 2019 www.gymjam.cn Inc. All rights reserved. 
 */
public class WxExit extends GenericTableManager{
	private static Logger logger = Logger
			.getLogger(WxExit.class.getName());
	public int service(Recordset inputParams) throws Throwable {

		// reuse superclass code
		super.service(inputParams);
		HttpServletRequest request = getRequest();
		HttpSession s = request.getSession(true);
		
		//记录当前是否微信登录
		// modified by leo 190524 微信是否登陆通过sid判断
		String weixin_userid = (String)s.getAttribute("dinamica.security.weixin_userid");
		String sid = (String)s.getAttribute("dinamica.security.weixin_service_id");
		
		
		//判断weixin_userid，如果非空，则weixin_type赋值,以便于filter中判断当前是否为微信登录
//		if (weixin_userid != null && weixin_userid.length() > 0) {
		// modified by leo 190524 微信退出应保存微信服务号sid而非登陆用户
		if (sid != null && sid.length() > 0) {
			Db db = getDb();
			String getServiceSql = getSQL(getResource("query-service.sql"), null);
			Recordset serviceRecordset = db.get(getServiceSql);
			if(serviceRecordset.getRecordCount()==0){
				throw new Throwable("服务号配置不正确。");
			}
			serviceRecordset.first();
			String serviceId = serviceRecordset.getString("tuid");
			String appId = serviceRecordset.getString("appid");
//			String appsecret=serviceRecordset.getString("appsecret");
			String access_address=serviceRecordset.getString("access_address");
			String loginUrl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appId+"&redirect_uri="+URLEncoder.encode(access_address+"/phone/action/project/fitness/wx/home?sid="+serviceId)+"&response_type=code&scope=snsapi_base&state=1#wechat_redirect";
			logger.info("loginUrl: "+loginUrl);
			logger.info("logout: "+weixin_userid);
			Enumeration em = request.getSession().getAttributeNames();
			while (em.hasMoreElements()) {
				request.getSession().removeAttribute(em.nextElement().toString());
			}
//            s.setAttribute("dinamica.security.weixin_userid", weixin_userid);
//			s.setAttribute("dinamica.security.weixin_service_id", sid);			
//			s.setAttribute("dinamica.security.weixin_type", "0");
			String updateWeixinSql = getResource("update-weixin.sql");
			updateWeixinSql = getSQL(updateWeixinSql,inputParams);
			db.exec(updateWeixinSql);
			// add by leo 190527 微信登陆退出时需带初始登陆信息到登陆页，避免微信未授权问题
			
			getResponse().sendRedirect(loginUrl);
		}
		// add by leo 无微信登陆信息，清除全部session
		else {
			Enumeration em = request.getSession().getAttributeNames();
			while (em.hasMoreElements()) {
				request.getSession().removeAttribute(em.nextElement().toString());
			}
		}
		
		return 0;
	}
}
