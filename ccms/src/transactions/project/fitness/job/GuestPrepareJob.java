package transactions.project.fitness.job;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.ccms.quartz.quartz.BaseJob;
import com.ccms.quartz.quartz.JDBC;

import dinamica.Db;
import dinamica.Recordset;

/***
 * 资源会员都会进入公海
 * @author C
 * 2016-06-25
 */
public class GuestPrepareJob extends BaseJob{
	private static Logger logger = Logger.getLogger(GuestPrepareJob.class.getName());
	private static Boolean IS_FINISH = true;
	private static byte[] lock = new byte[0];
	
/*	private static final int DATATYPE_guest = 1;	// 资源
	private static final int DATATYPE_customer = 2;	// 会员
*/	private static final String PUBLIC_REASON_guest_outof_maxnum = "资源会员都会进入public表";
	/*private static final String PUBLIC_REASON_cust_follow_timeout = "会员跟进超时";*/
	
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException{
		//执行方法之前先判断该线程是否执行完成
		if(IS_FINISH == false){
			super.beforeExecute(arg0, "ignore");
			return;
		}
		String tuid = super.beforeExecute(arg0, "");
		String error = "";
		//加锁，以免上一个线程尚未执行完，下一个就执行了
		synchronized(lock){
			IS_FINISH = false;
			Connection conn = null;
			try {
				conn = JDBC.getConnection();
				Db db = new Db(conn);
				
				// 写入公海脚本
				String insertPublic = getLocalResource("/transactions/project/fitness/job/sql/guestprepare/insert-public.sql");
				// 获取超出分配次数的客户资源列表--zzn目前系统不采用此逻辑，只考虑按保护期时间过期
				//String queryPublicGuest = getLocalResource("/transactions/project/fitness/job/sql/guestprepare/pub/query-guest.sql");
				// 获取在保护期内小于最小跟进次数的会员列表
				String queryPublicCust = getLocalResource("/transactions/project/fitness/job/sql/guestprepare/pub/query-cust.sql");
				// 快过期资源提醒脚本
				String insertRemind = getLocalResource("/transactions/project/fitness/job/sql/guestprepare/outdate/remind/insert_message.sql");
				// 获取需要提醒的会籍、资源
				String queryRemind = getLocalResource("/transactions/project/fitness/job/sql/guestprepare/outdate/remind/query.sql");
				// 获取资源过期更新脚本
				String updateInvalid = getLocalResource("/transactions/project/fitness/job/sql/guestprepare/outdate/update.sql");
				// 获取过期的客户资源列表
				String queryOut = getLocalResource("/transactions/project/fitness/job/sql/guestprepare/outdate/query.sql");				
				// 获取俱乐部列表
				String queryOrg =  getLocalResource("/transactions/project/fitness/job/sql/query-org.sql");
				Recordset rsOrg = db.get(queryOrg);
				while(rsOrg.next()){
					//zyb 20190415 资源和会员都进入公海
					String _queryOutPublic = getSQL(queryOut, rsOrg);
					Recordset rsqueryOutPublic = db.get(_queryOutPublic);
						while( rsqueryOutPublic.next() ){
							String _insert = getSQL(insertPublic, rsqueryOutPublic);
							//zyb 20190415  原因条件
							_insert = StringUtils.replaceOnce(_insert, "${resason}", String.valueOf(PUBLIC_REASON_guest_outof_maxnum));
							db.exec(_insert);
						}					
					/*					
					// 2、会员在保护期内超过最大跟进天数时，进入公海
					String _queryPublic = getSQL(queryPublicCust, rsOrg);
					Recordset rsPublic = db.get(_queryPublic);
					while( rsPublic.next() ){
						String _insert = getSQL(insertPublic, rsPublic);
						_insert = StringUtils.replaceOnce(_insert, "${datatype}", String.valueOf(DATATYPE_customer));
						_insert = StringUtils.replaceOnce(_insert, "${resason}", String.valueOf(PUBLIC_REASON_cust_follow_timeout));
						db.exec(_insert);
					}
					*/
					// 3、客户资源快过期提醒
					/*String _queryRemind = getSQL(queryRemind, rsOrg);
					Recordset rsMind = db.get(_queryRemind);
					while(rsMind.next()){
						String _insertRemind = getSQL(insertRemind, rsMind);
						db.exec(_insertRemind);
					}*/

				/*	// 4、客户资源过期后，重新回到会籍经理手中   
					String _queryOut = getSQL(queryOut, rsOrg);
					Recordset rsOut = db.get(_queryOut);
					while( rsOut.next() ){
						String _update = getSQL(updateInvalid, rsOut);
						db.exec(_update);
					}*/
					
				}
				
				// 5、资源爽约
				// 获取资源爽约更新脚本
				String updateDump = getLocalResource("/transactions/project/fitness/job/sql/guestprepare/dump/update.sql");
				// 获取爽约的客户资源列表
				String queryDump = getLocalResource("/transactions/project/fitness/job/sql/guestprepare/dump/query.sql");
				Recordset rsDump = db.get(getSQL(queryDump,null));
				while( rsDump.next() ){
					String _update = getSQL(updateDump, rsDump);
					db.exec(_update);
				}
			}catch (Throwable e) {
				error = e.getMessage();
				logger.error(e);
				e.printStackTrace();
			}finally{
				if(conn != null){
					// 关闭连接
					try {
						conn.close();
					} catch (SQLException e) {
						logger.error(e);
					}
				}
				IS_FINISH = true;
				super.afterExecute(arg0, tuid, error);
			}
		}
    }
}
