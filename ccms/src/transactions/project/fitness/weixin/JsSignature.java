package transactions.project.fitness.weixin;

import java.sql.Types;
import java.util.Iterator;
import java.util.Map;

import org.json.JSONObject;

import transactions.project.weixin.common.WeixinUtil;
import dinamica.Db;
import dinamica.GenericTransaction;
import dinamica.Recordset;
import dinamica.security.DinamicaUser;

public class JsSignature extends GenericTransaction {
	public int service(Recordset inputParams) throws Throwable {
		int rc = super.service(inputParams);
		Db db = getDb();
		String appid = "";
		// modified by leo 190523 从登陆用户账号中获取绑定的wx_service中的tuid
		String weixin_service_id="";
		DinamicaUser user = (DinamicaUser)getSession().getAttribute("dinamica.security.login");
		if( user!=null ){
			String userlogin = user.getName();
			System.out.println("userlogin: "+userlogin);
			String queryUser="select weixin_service_id from hr_staff where userlogin='"+userlogin+"'";
			Recordset rsUser = db.get(queryUser);
			while( rsUser.next() ){
				weixin_service_id=rsUser.getString("weixin_service_id");
				break;
			}
		}
		String secret = "";
		String sid = "";
		String accessAddress = "";
		// modified by leo 190522 根据appid查询配置信息
		String queryAccount;
		if(weixin_service_id!=null && !weixin_service_id.equals("")) {
			queryAccount = "SELECT tuid, appid, appsecret, access_address FROM wx_service WHERE tuid='"+ weixin_service_id +"' and is_deleted = '0' ORDER BY tuid";
		}else {
			queryAccount = "SELECT tuid, appid, appsecret, access_address FROM wx_service WHERE is_deleted = '0' ORDER BY tuid";
		}
		Recordset rsAccount = db.get(queryAccount);
		while( rsAccount.next() ){
			sid = String.valueOf(rsAccount.getValue("tuid"));
			// modified by leo 190522 根据appid查询配置信息,为空从配置里取
			appid = rsAccount.getString("appid");
			secret = rsAccount.getString("appsecret");
			accessAddress = !rsAccount.isNull("access_address") ? rsAccount.getString("access_address") : null;
			break;
		}
		String org_id = "";
		if( null != getSession().getAttribute("dinamica.user.org") ){
			org_id = String.valueOf(getSession().getAttribute("dinamica.user.org"));
		}
		
		String weixin_userid = "";
		String code = getRequest().getParameter("code");
		Recordset r = new Recordset();
		r.append("cust_code", java.sql.Types.VARCHAR);
		r.append("weixin_user", java.sql.Types.VARCHAR);
		r.addNew();
		if( null != sid && sid.length() > 0 && null != code && code.length() > 0 ){
			try{
				weixin_userid = WeixinUtil.getWeixinUserIdForService(appid, secret, code);
			}catch(Throwable e){
			}
		}

		String realString = getRequest().getRequestURL().toString();
//		System.out.println("realString: "+realString);
		String urlString = realString.substring(0, 7).concat(realString.substring(7).replace("//", "/"));

		StringBuffer sb = new StringBuffer();
		sb.append(urlString);
		Map<?, ?> map = getRequest().getParameterMap();
		Iterator<?> it = map.keySet().iterator();
		while (it.hasNext()) {
			String key = (String) it.next();
			String value = getRequest().getParameter(key);
			if (sb.toString().contains("?")) {
				sb.append("&" + key + "=" + value);
			} else {
				sb.append("?" + key + "=" + value);
			}
		}
		String jsapi_ticket = WeixinUtil.getJsTicket(db, sid);
		// 获得js初始化签名
//		System.out.println("sb.toString(): "+sb.toString());
		System.out.println("sid: "+sid);
		System.out.println("jsapi_ticket: "+jsapi_ticket);
		JSONObject jsonObject = WeixinUtil.signature(jsapi_ticket, sb.toString());
		String nonce_str = jsonObject.getString("noncestr");
		String timestamp = jsonObject.getString("timestamp");
		String signature = jsonObject.getString("signature");
		
		Recordset rsSignature = new Recordset();
		rsSignature.append("noncestr", Types.VARCHAR);
		rsSignature.append("timestamp", Types.VARCHAR);
		rsSignature.append("signature", Types.VARCHAR);
		rsSignature.append("service_tuid", Types.VARCHAR);
		rsSignature.append("org_id", Types.VARCHAR);
		rsSignature.append("appid", Types.VARCHAR);
		rsSignature.append("access_address", Types.VARCHAR);
		rsSignature.append("weixin_userid", Types.VARCHAR);

		rsSignature.append("url", Types.VARCHAR);
		rsSignature.append("jsapi_ticket", Types.VARCHAR);
        rsSignature.append("scheme", Types.VARCHAR);

		rsSignature.addNew();
		rsSignature.setValue("noncestr", nonce_str);
		rsSignature.setValue("timestamp", timestamp);
		rsSignature.setValue("signature", signature);
		rsSignature.setValue("service_tuid", sid);
		rsSignature.setValue("org_id", org_id);
		rsSignature.setValue("appid", appid);
		rsSignature.setValue("access_address", accessAddress);
		rsSignature.setValue("weixin_userid", weixin_userid);

		rsSignature.setValue("url", realString);
		rsSignature.setValue("jsapi_ticket", jsapi_ticket);

        String scheme = getRequest().getScheme().toString();
        rsSignature.setValue("scheme", scheme);

		publish("_rsSignature", rsSignature);
		return rc;
	}
}