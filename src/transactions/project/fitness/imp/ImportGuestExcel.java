package transactions.project.fitness.imp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Types;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

import com.ccms.imp.ExcelImportFor2k3;
import com.ccms.imp.ExcelImportFor2k7;
import com.ccms.imp.ExcelImportUtil;

import dinamica.Db;
import dinamica.Recordset;
import dinamica.RecordsetException;
import dinamica.StringUtil;

/***
 * 会员卡导入
 * @author C
 * 2016-08-06
 */
public class ImportGuestExcel extends ImportUtil {
	
	Map<String, Map<String, String>> domainMap = null;// 查询出参数表
	Map<String, Map<String, String>> mappingMap = null;// 查询出错误信息对照表

	public int service(Recordset inputParams) throws Throwable {
		int rc = super.service(inputParams);
		Db db = null;
		int result = -1;
		String desc = "";
		String importLogTuid = "";
		String importBatch = "";
		InputStream in = null;
		Recordset rsFailed = this.initRecordset();
		try {
			db = getDb();
			if (inputParams.isNull("file.filename")) {
				throw new Throwable("导入文件不能为空!");
			}
			String file = inputParams.getString("file");
			// 解决excel文件名中文乱码
			String fileName = inputParams.getString("file.filename");
			String fileNameTemplate = super.getContext().getRealPath("/")+"/erpclubdoc/template/guest.xlsx";

			fileName = fileName.substring(fileName.lastIndexOf(File.separator) + 1);
			fileName = super.formatRequestEncoding(fileName);	
			inputParams.setValue("file.filename", fileName);
			// 获取excel文件在服务器上的地址,如果不存在则创建文件夹
			String savePath = super.getRealSavePath("upload", "engineer", false);
			if ("\\".equals(File.separator)) {
				savePath = StringUtil.replace(savePath, "\\", "\\\\");
			}
			// 生成批次号
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			importBatch = "G_" + sdf.format(new Date());
			// 获取文件扩展名
			String ext = fileName.lastIndexOf(".") == -1 ? "" : fileName.substring(fileName.lastIndexOf(".") + 1);
			// 保存的文件重命名
			fileName = super.renameSaveFile(fileName, importBatch, ext);
			// 导入前记录日志
			importLogTuid = super.insertImportLog(db, importBatch, fileName, savePath + fileName);
			File f = new File(file);
			File ft = new File(fileNameTemplate);

			// 数据处理成list
			ExcelImportUtil excel;
			if ("xls".equalsIgnoreCase(ext)) {
				if (f.length() > ExcelImportUtil.MAX_LENGTH_2K3) {
					throw new Throwable(ExcelImportUtil.ERROR_MAX_SIZE_ILLEGAL);
				}
				excel = new ExcelImportFor2k3(f);
			} else if ("xlsx".equalsIgnoreCase(ext)) {
				excel = new ExcelImportFor2k7(f);
			} else {
				throw new Throwable(ExcelImportUtil.ERROR_FORMAT_ILLEGAL);
			}
			
			//模版
			ExcelImportUtil excelTemplate;
			if ("xls".equalsIgnoreCase(ext)) {
				if (f.length() > ExcelImportUtil.MAX_LENGTH_2K3) {
					throw new Throwable(ExcelImportUtil.ERROR_MAX_SIZE_ILLEGAL);
				}
				excelTemplate = new ExcelImportFor2k3(ft);
			} else if ("xlsx".equalsIgnoreCase(ext)) {
				excelTemplate = new ExcelImportFor2k7(ft);
			} else {
				throw new Throwable(ExcelImportUtil.ERROR_FORMAT_ILLEGAL);
			}

			List<List<String>> dataList = excel.getExcelData();
			List<List<String>> dataListTemplate = excelTemplate.getExcelData();
			if (dataList.size() == 0) {
				throw new Throwable(ExcelImportUtil.ERROR_FILE_EMPTY);
			}
			//模版为空
			if (dataListTemplate.size() == 0) {
				throw new Throwable(ExcelImportUtil.ERROR_TEMPLATE_FILE_EMPTY);
			}

			int byteread = 0;
			File _file = new File(savePath);
			if (_file.exists()) {
				in = new FileInputStream(file); // 读入原文件
				@SuppressWarnings("resource")
				FileOutputStream fs = new FileOutputStream(savePath + fileName);
				byte[] buffer = new byte[1024 * 100];
				while ((byteread = in.read(buffer)) != -1) {
					fs.write(buffer, 0, byteread);
				}
			}
			f.delete();
			int rowsNum = dataList.size(); // 获取行数
			int title_line_num = 0;
			Recordset rs = this.initRecordset();
			StringBuffer validateError = new StringBuffer();
			// 读取模版，比对表头部分@oasahi 20180515
			List<String> dataRowTitle = dataList.get(0);	//第一行，标题行
			List<String> dataRowTemplateTitle = dataListTemplate.get(0);	//模版第一行，标题行
			String titleNameTemplate;
			boolean isTitleFound = false;
			for (int j = 0; j < (null == dataRowTemplateTitle ? 0 : dataRowTemplateTitle.size()); j++) {
				titleNameTemplate = super.formatStringValue(dataRowTemplateTitle.get(j));
				isTitleFound = false; //模版的表头在文件中是否匹配到了
				for (int k = 0; k < (null == dataRowTitle ? 0 : dataRowTitle.size()); k++) {
					if(super.formatStringValue(dataRowTitle.get(k)).equals(titleNameTemplate)){
						isTitleFound = true;
					}
				}
				if(!isTitleFound){
					//模版中，应该有的列，在数据文件中不存在。
					validateError.append("导入的Excel缺少列项："+titleNameTemplate+"<br>");
				}
				isTitleFound = false;
			}
			
			for (int j = (title_line_num + 1); j < rowsNum; j++) {
				rs.addNew();
				List<String> dataRow = dataList.get(j);
				// 模版中，列的约定如下：
				// 第一列为会员姓名
				// 第二列为会员卡号
				// 第三列卡内部号
				// 第四列为会员电话
				// 第五列为其他电话
				// 第六列为会籍顾问
				// 第七列为教练
				// 第八列为卡类型
				// 第九列卡有效期始
				// 第十列有效期止
				// 第十一列卡状态
				// 第十二列备注
				
				
				// 序号
				rs.setValue("row_number", j);
				int iDataCurrentCol = 0;	//当前列号
				
				DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd"); 
				String datepattern = "^\\d{4}\\D+\\d{2}\\D+\\d{2}$";
				Pattern datep = Pattern.compile(datepattern);
				Date sDate = null, edate = null;
				String mobile="";
				//定位数据文件中，表头项的位置
				for (int iTemplateCurrentCol = 0; iTemplateCurrentCol < (null == dataRowTemplateTitle ? 0 : dataRowTemplateTitle.size()); iTemplateCurrentCol++) {
					titleNameTemplate = super.formatStringValue(dataRowTemplateTitle.get(iTemplateCurrentCol));
					for (int m = 0; m < (null == dataRowTitle ? 0 : dataRowTitle.size()); m++) {
						if(super.formatStringValue(dataRowTitle.get(m)).equals(titleNameTemplate)){
							iDataCurrentCol = m;
							break;
						}
					}

					int count = 0;
					
					if(iTemplateCurrentCol == 0){	//第一列为
						try{
							// 公司名称
							String officename = super.formatStringValue(dataRow.get(iDataCurrentCol));
							if (officename.length() <= 0) {
								validateError.append("公司名称不能为空;");
							}else {
								String _queryofficename = StringUtil.replace(getResource("query-officename.sql"), "${field_name}", "officename");
								_queryofficename = StringUtil.replace(_queryofficename, "${field_value}", officename);
								_queryofficename = getSQL(_queryofficename, null);
								Recordset _rsofficename = db.get(_queryofficename);
								_rsofficename.first();
								if(_rsofficename.getString("officename").equals("1")){
									validateError.append("公司名称已存在;"+officename);
								}else{
									rs.setValue("officename", officename);
								}
							}
							
						} catch (Exception e) {
							validateError.append("公司名称不能为空;");
						}
					}else if(iTemplateCurrentCol == 1){	//第二列为
						try{
							// 省
							String province = super.formatStringValue(dataRow.get(iDataCurrentCol));
							String queryprovince = StringUtil.replace(getResource("query-province.sql"), "${field_text}", "domain_text_cn");
							queryprovince = StringUtil.replace(queryprovince, "${field_value}", province);
							queryprovince = getSQL(queryprovince, null);
							Recordset _rsprovince = db.get(queryprovince);
							_rsprovince.first();
							if (_rsprovince.getRecordCount()>0) {
								rs.setValue("province", _rsprovince.getString("domain_value"));
							}else{
								validateError.append("省不可以为空;");
							}
						} catch (Exception e) {
							validateError.append("省的格式不正确;");
						}
					}else if(iTemplateCurrentCol == 2){	//第三列为
						try{
							// 市
							String city = super.formatStringValue(dataRow.get(iDataCurrentCol));
							String querycity = StringUtil.replace(getResource("query-city.sql"), "${field_text}", "domain_text_cn");
							querycity = StringUtil.replace(querycity, "${field_value}", city);
							querycity = getSQL(querycity, null);
							Recordset _rscity = db.get(querycity);
							_rscity.first();
							if (_rscity.getRecordCount()>0) {
								rs.setValue("city", _rscity.getString("domain_value"));
							}else{
								validateError.append("市不可以为空;");
							}
						} catch (Exception e) {
							validateError.append("市的格式不正确;");
						}
					}else if(iTemplateCurrentCol == 3){	//第四列为
						try{
							// 公司类型
							String custtype = super.formatStringValue(dataRow.get(iDataCurrentCol));
							//健身俱乐部 ，健身工作室， 瑜伽会所， 器械器，培训机构，其他 customtype
							/*String querycustomtype = getResource("query-customtype.sql");
							querycustomtype = getSQL(querycustomtype, null);
							Recordset _customType = db.get(querycustomtype);
							int index = super.findRecordNumber(_customType, "customtype", custtype);*/
							if (custtype.length() < 0) {
								validateError.append("公司类型不可以为空");
							}else{
								//公司类型
								if(custtype.equals("健身俱乐部"))
									rs.setValue("customtype", 1);
								if(custtype.equals("健身工作室"))
									rs.setValue("customtype", 2);
								if(custtype.equals("瑜伽会所"))
									rs.setValue("customtype", 3);
								if(custtype.equals("器械器"))
									rs.setValue("customtype", 4);
								if(custtype.equals("培训机构"))
									rs.setValue("customtype", 5);
								if(custtype.equals("其他"))
									rs.setValue("customtype", 6);
								
							}
						} catch (Exception e) {
							validateError.append("公司中不存在该类型，应为（健身俱乐部 ，健身工作室， 瑜伽会所， 器械器，培训机构，其他）；");
						}
					}else if(iTemplateCurrentCol == 4){	//第五列为
						try{
							// 会籍
							String querymc = getResource("query-mc.sql");
							querymc = getSQL(querymc, null);
							Recordset mcType = db.get(querymc);
							String mc = super.formatStringValue(dataRow.get(iDataCurrentCol));
							if (mc.length() > 0) {
								int index = super.findRecordNumber(mcType, "mc", mc);
								if (index < 0) {
									validateError.append("系统中不存在该顾问;");
								}else{
									String _querymc = StringUtil.replace(getResource("query-staffvalue.sql"), "${field_name}", "name");
									_querymc = StringUtil.replace(_querymc, "${field_value}", mc);
									_querymc = getSQL(_querymc, null);
									Recordset _rsmc = db.get(_querymc);
									_rsmc.first();
									rs.setValue("mc", _rsmc.getString("mc"));
								}
							}else{
								validateError.append("顾问不可以为空;");
							}
						} catch (Exception e) {
							validateError.append("顾问不可以为空;");
						}

					}else if(iTemplateCurrentCol == 5){	//第六列为
						try{
							// 电话
							String othertel = super.formatStringValue(dataRow.get(iDataCurrentCol));
							rs.setValue("officetel", othertel);
						} catch (Exception e) {
							validateError.append("电话格式不对;");
						}
					}else if(iTemplateCurrentCol == 6){	//第7列为
						try{
							// 邮箱
							String email = super.formatStringValue(dataRow.get(iDataCurrentCol));
							rs.setValue("email", email);
						} catch (Exception e) {
							validateError.append("email格式不对;");
						}

					}else if(iTemplateCurrentCol == 7){	//第8列为
						try{
							// 地址
							String officeaddr = super.formatStringValue(dataRow.get(iDataCurrentCol));
							rs.setValue("officeaddr", officeaddr);
						} catch (Exception e) {
							validateError.append("地址格式不对;");
						}

					}else{
						validateError.append("模版文件中存在无法处理的列项："+titleNameTemplate);
					}
				}
				
				// 数据保存
				if( null != validateError && validateError.length() > 0 ){
					rs.setValue("validate_error", validateError.toString());
					rsFailed.addNew();
					rs.copyValues(rsFailed);
					validateError.delete(0, validateError.length());
				}else{
					String _queryguestcode = StringUtil.replace(getResource("query-guestcode.sql"), "${field_name}", "");
					_queryguestcode = StringUtil.replace(_queryguestcode, "${field_value}", "");
					_queryguestcode = getSQL(_queryguestcode, null);
					Recordset _rsguestcode = db.get(_queryguestcode);
					_rsguestcode.first();
					rs.setValue("guestcode", _rsguestcode.getString("guestcode"));
					
					db.beginTrans();
					String insertPublic = getResource("insert-public.sql");
					String _insertPublic = getSQL(insertPublic, rs);
					db.exec(_insertPublic);
					String insertGuest = getResource("insert-guest.sql");
					String _insertGuest = getSQL(insertGuest, rs);
					db.exec(_insertGuest);
					db.commit();
				}
			}
			result = 1;
			desc = "";
		} catch (Throwable t) {
			result = 0;
			desc = "导入失败：" + t.getMessage();
			t.printStackTrace();
		} finally {
			try{
				if (null != in) {
					in.close(); // 关闭流
				}
				super.updateImportLog(db, importLogTuid, result, StringUtil.replace(desc, "'", "''"));
			} catch(Throwable t) {
				t.printStackTrace();
			}
		}
		publish("query-result", this.createResultRecordset(result, desc));
		publish("query-failed", rsFailed);
		return rc;
	}
	
	private Recordset initRecordset() throws RecordsetException {
		Recordset rs = new Recordset();
		rs.append("row_number", Types.INTEGER);
		rs.append("guestcode", Types.VARCHAR);
		rs.append("officename", Types.VARCHAR);	// 姓名
		rs.append("province", Types.VARCHAR);	// 省
		rs.append("city", Types.VARCHAR);	// 市
		rs.append("customtype", Types.INTEGER);	// 公司类型
		rs.append("mc", Types.VARCHAR);	// 会籍
		rs.append("officetel", Types.VARCHAR);	// 电话
		rs.append("email", Types.VARCHAR); // 邮箱
		rs.append("officeaddr", Types.VARCHAR);  //地址
		
		rs.append("resultcode", Types.INTEGER);
		rs.append("resultdesc", Types.VARCHAR);
		rs.append("validate_error", Types.VARCHAR);
		return rs;
	}

	private Recordset createResultRecordset(int resultcode, String resultdesc) throws RecordsetException {
		Recordset rs = new Recordset();
		rs.append("resultcode", Types.INTEGER);
		rs.append("resulterror", Types.VARCHAR);
		rs.addNew();
		rs.setValue("resultcode", resultcode);
		rs.setValue("resulterror", resultdesc);
		return rs;
	}
	/**  
     * 大陆号码或香港号码均可  
     */    
    public static boolean isPhoneLegal(String str)throws PatternSyntaxException {    
        return isChinaPhoneLegal(str);    
    }    
    
    public static boolean isChinaPhoneLegal(String str) throws PatternSyntaxException {    
        String regExp = "^[0-9]{11}$";       
        Pattern p = Pattern.compile(regExp);    
        Matcher m = p.matcher(str);    
        return m.matches();    
    }    
    public static boolean isEmailFormat(String str)throws PatternSyntaxException {    
        return emailFormat(str);    
    }
    
    public static boolean emailFormat(String email) {
    	boolean tag = true;
    	if (!email.matches("[\\w\\.\\-]+@([\\w\\-]+\\.)+[\\w\\-]+")) {
    		tag = false;
            }
    	return tag;
    }
    
}
