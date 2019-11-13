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
public class ImportCustCardExcel extends ImportUtil {
	
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
			String fileNameTemplate = super.getContext().getRealPath("/")+"/erpclubdoc/template/the.xlsx";

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
							if(officename.length()>0) {
								String _queryofficename = StringUtil.replace(getResource("query-officename.sql"), "${field_name}", "officename");
								_queryofficename = StringUtil.replace(_queryofficename, "${field_value}", officename);
								_queryofficename = getSQL(_queryofficename, null);
								Recordset _rsofficename = db.get(_queryofficename);
								_rsofficename.first();
								if(_rsofficename.getString("officename").equals("1")){
									String _queryofficcode = StringUtil.replace(getResource("query-guestcode.sql"), "${field_name}", "officename");
									_queryofficcode = StringUtil.replace(_queryofficcode, "${field_value}", officename);
									_queryofficcode = getSQL(_queryofficcode, null);
									Recordset _rsofficecode = db.get(_queryofficcode);
									_rsofficecode.first();
									rs.setValue("guestcode",_rsofficecode.getString("code") );
								}else{
									validateError.append("未找到该公司；"+officename);
								}
								
							}else {
								validateError.append("公司名称不能为空；");
							}
							
						} catch (Exception e) {
							validateError.append("公司名称不能为空；");
						}

					}else if(iTemplateCurrentCol == 1){	//第二列为
						try{
							// 联系人姓名
							String name = super.formatStringValue(dataRow.get(iDataCurrentCol));
							if (name.length() > 0) {
									rs.setValue("name", name);
							}else{
								validateError.append("联系人不能为空；");
							}
						} catch (Exception e) {
							validateError.append("联系人不能为空；");
						}

					}else if(iTemplateCurrentCol == 2){	//第二列为
						try{
							//性别
							String sex = super.formatStringValue(dataRow.get(iDataCurrentCol));
							if(sex.equals("男")){
								rs.setValue("sex", "1");
							}else if(sex.equals("女")){
								rs.setValue("sex", "0");
							}
						} catch (Exception e) {
							validateError.append("性别失败；");
						}
					}else if(iTemplateCurrentCol == 3){	//第二列为
						try{
							// 职务
							String position = super.formatStringValue(dataRow.get(iDataCurrentCol));
							String querypositiontype = getResource("query-positiontype.sql");
							querypositiontype = getSQL(querypositiontype, null);
							Recordset _positionType = db.get(querypositiontype);
							int index = super.findRecordNumber(_positionType, "position", position);
							if (index < 0) {
								validateError.append("公司中职位，应为（投资人 ，总监， 会籍经理， 教练经理，会籍，教练）；");
							}else {
								if(position.equals("投资人"))
									rs.setValue("position", 1);
								if(position.equals("总监"))
									rs.setValue("position", 2);
								if(position.equals("会籍经理"))
									rs.setValue("position", 3);
								if(position.equals("教练经理"))
									rs.setValue("position", 4);
								if(position.equals("会籍"))
									rs.setValue("position", 5);
								if(position.equals("教练"))
									rs.setValue("position", 6);
							}
							
						} catch (Exception e) {
							validateError.append("职务失败；");
						}

					}else if(iTemplateCurrentCol == 4){	//第二列为
						try{
							// 手机号
							mobile = super.formatStringValue(dataRow.get(iDataCurrentCol));
							if (mobile.length() > 0) {
								String _querymobile = StringUtil.replace(getResource("query-mobile.sql"), "${field_name}", "mobile");
								_querymobile = StringUtil.replace(_querymobile, "${field_value}", mobile);
								_querymobile = getSQL(_querymobile, null);
								Recordset _rsmobile = db.get(_querymobile);
								_rsmobile.first();
								if(_rsmobile.getString("mobilecount").equals("1")){
									validateError.append("该手机号码已存在;");
								}else{
									if(isPhoneLegal(mobile)) {
										rs.setValue("mobile", mobile);
									}else {
										validateError.append("该手机号码格式不正确;");
									}
								}
							}
							} catch (Exception e) {
								validateError.append("手机失败");
						}
					}else if(iTemplateCurrentCol == 5){	//第6列为
						try{
							// 跟进状态
							String commresult = super.formatStringValue(dataRow.get(iDataCurrentCol));
							if(commresult.length()>0) {
								if(commresult.equals("未建立关系"))
									rs.setValue("commresult", 1);
								if(commresult.equals("建立关系"))
									rs.setValue("commresult", 2);
								if(commresult.equals("了解需求"))
									rs.setValue("commresult", 3);
								if(commresult.equals("对接产品价值"))
									rs.setValue("commresult", 4);
								if(commresult.equals("要承诺"))
									rs.setValue("commresult", 5);
								if(commresult.equals("暂时搁置"))
									rs.setValue("commresult", 6);
								if(commresult.equals("成交"))
									rs.setValue("commresult", 7);
								if(commresult.equals("未成交"))
									rs.setValue("commresult", 8);
							}else {
								validateError.append("跟进状态不能为空；");
							}
							
						} catch (Exception e) {
							validateError.append("跟进状态不能为空；");
						}
					} else if(iTemplateCurrentCol == 6){	//第7列为
						try{
							// 备注
							rs.setValue("remark", super.formatStringValue(dataRow.get(iDataCurrentCol)));
						} catch (Exception e) {
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
					String _querythecode = StringUtil.replace(getResource("query-thecode.sql"), "${field_name}", "");
					_querythecode = StringUtil.replace(_querythecode, "${field_value}", "");
					_querythecode = getSQL(_querythecode, null);
					Recordset _rsthecode = db.get(_querythecode);
					_rsthecode.first();
					rs.setValue("thecode", _rsthecode.getString("thecode"));
					db.beginTrans();
					String insertthe = getResource("insert-thecontact.sql");
					String _insertthe = getSQL(insertthe, rs);
					db.exec(_insertthe);
					String insertcomm = getResource("insert-comm.sql");
					String _iinsertcomm = getSQL(insertcomm, rs);
					db.exec(_iinsertcomm);
					
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
		rs.append("name", Types.VARCHAR);	// 姓名
		rs.append("thecode", Types.VARCHAR);	// thecode
		rs.append("mobile", Types.VARCHAR);	// 手机
		rs.append("commresult", Types.INTEGER);	// 跟进状态
		rs.append("position", Types.INTEGER);	// 职务
		rs.append("remark", Types.VARCHAR);	// 备注
		rs.append("sex", Types.VARCHAR);	// 性别
		rs.append("guestcode", Types.VARCHAR);	// 公司编号
		
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
        String regExp = "^[1][3,4,5,7,8][0-9]{9}$";    
        Pattern p = Pattern.compile(regExp);    
        Matcher m = p.matcher(str);    
        return m.matches();    
    }    
    
}
