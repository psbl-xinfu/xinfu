package com.ccms.api.customer;

import dinamica.GenericTransaction;
import dinamica.Recordset;

/**  
 * All rights Reserved, Designed By gymjam.cn
 * @Title:  OpenDoor.java   
 * @Package com.ccms.api.customer   
 * @Description:    TODO(健身管理软件)   
 * @author: Leo    
 * @date:   2019年3月28日 下午5:56:09   
 * @version V2.0 
 * @Copyright: 2019 www.gymjam.cn Inc. All rights reserved. 
 */
public class OpenDoor extends GenericTransaction{
	public int service(Recordset inputs) throws Throwable
	{
		int rc = Integer.valueOf(getRequest().getParameter("type")) ;
		return rc;
	}
}
