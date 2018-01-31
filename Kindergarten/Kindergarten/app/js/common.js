//檔案最大文件大小，單位為字節(默認5M = 5242880)
var gv_file_maxsize = 5242880;

// var resource_test_webroot = "http://183.63.140.254:7004/quality_assessment_api/";
var resource_test_webroot = "https://oss.qszhiku.com/";
// var resource_test_webroot = "http://127.0.0.1/prototype/";



// var api_test_webroot = "http://127.0.0.1/quality_assessment/quality_assessment_api/index.php/";

// var api_test_webroot = "http://183.63.140.254:7004/quality_assessment_api/index.php/";
var api_test_webroot = "http://192.168.1.104:8070/kindergarten/";
// var api_test_webroot = "http://127.0.0.1/prototype/index.php/";
// var api_183_webroot = "http://183.63.140.254:7004/quality_assessment_api/index.php/";


//---------------------------------------------------------------------------------------- LocalStorage start
    /**
     * localstorage 添加
     */
    function localstorageAdd(pKey, pValue)  
    {  
        if (Modernizr.localstorage) 
        {   
            localStorage.setItem(pKey,JSON.stringify(pValue));  
        }else{  
            sessionStorage.setItem(pKey,JSON.stringify(pValue));  
        }  
    }
    /**
     * localstorage 刪除
     * @param pKey
     */
    function localstorageRemove(pKey)
    {
    	if (Modernizr.localstorage) 
    	{
    		localStorage.removeItem(pKey);
    	}else{
    		sessionStorage.removeItem(pKey);
    	}
    }
    /**
     * localstorage 獲取
     */
    function localstorageGet(pKey)  
    {  
        if (Modernizr.localstorage) 
        {   
            var temp = JSON.parse(localStorage.getItem(pKey));  
        }else{  
            var temp = JSON.parse(sessionStorage.getItem(pKey));  
        }  
		return temp;
    } 
    /**
     * localstorage 清楚
     */
    function localstorageClear()
    {
    	if (Modernizr.localstorage) 
    	{
    		localStorage.clear();
    	}else{
    		sessionStorage.clear();
    	}
    }
    /**
     * 判斷 LocalStorage 是否包含某個key    1=true    0=false
     * @param pKey
     * @returns {Number}
     */
    function localstorageCheck(pKey)
    {
    	var temp = 0;
    	if(gv_localstorage != null)
    	{
    		for(var i=0;i<gv_localstorage.length;i++)
    		{	
    			var key = gv_localstorage.key(i);
    			if(key == pKey)
    			{
    			    temp = 1;
    			    break;
    			}
    		}
    	}
    	return temp;
    }
    //---------------------------------------------------------------------------------------- LocalStorage end


/*
 * 	獲取选项内容
 * 參數1:        $account     用户名称
 * 參數2:        $password    密码
 */
var api_prototype_user_qa_login = api_test_webroot + "evaluation/app/login.do";

/*
 *  獲取选项内容
 * 參數1:        $school_id     学校ID
 * 參數2:        $user_type     用户类型
 * 參數3:        $token             令牌
 */
var api_prototype_user_qa_get_evaprogress = api_test_webroot + "UserController/qa_get_evaprogress";

/*
 *  设置学校开始评估时间
 * 參數1:        $school_id     学校ID
 * 參數2:        $user_type     用户类型
 * 參數3:        $token             令牌
 */
var api_prototype_school_start_time = api_test_webroot + "UserController/qa_school_start_time";

/*
 *  獲取全部选项内容
 * 參數1:        $school_id     学校ID
 * 參數2:        $user_type     用户类型
 * 參數3:        $token             令牌
 */
var api_prototype_get_evacontent = api_test_webroot + "AssProcessController/qa_get_evacontent";

/*
 *  检查复评用户是否正在进行评估
 * 參數1:        $school_id     学校ID
 */
var api_qa_check_user_type_fp_progress = api_test_webroot + "AssProcessController/qa_check_user_type_fp_progress";

/*
 *  按照lv3獲取选项内容
 * 參數1:        $lv_3     第三层评估ID
 * 參數2:        $token             令牌
 */
var api_prototype_get_lv4_result = api_test_webroot + "AssProcessController/qa_get_evadata_bylvid";

/*
 * 	獲取选项提交的内容
 * 參數1:        $lv_3     第三层评估ID
 * 參數2:        $token             令牌
 */
var api_prototype_get_options = api_test_webroot + "AssProcessController/qa_get_ch_options";

/*
 * 	獲取電子書所屬年級
 * 參數1:        $lv_3     第三层评估ID
 * 參數2:        $token             令牌
 */
var api_prototype_get_inputproves = api_test_webroot + "AssProcessController/qa_get_inputproves";

/*
 * 	提交选项数据
 * 參數1:        $lv4_id     第四层评估ID
 * 參數2:        $option_id  第四层选项ID
 * 參數3:        $text_val   输入数据
 * 參數4:        $token      令牌
 */
var api_prototype_send_submit = api_test_webroot + "AssProcessController/qa_save_ch_options";

/*
 * 	上传证明文件
 * 參數1:        $qa_user_attachment_id     第三层评估ID
 * 參數2:        $token                     令牌
 */
var api_prototype_send_data = api_test_webroot + "AssProcessController/qa_upload_fileproves_data";

/*
 *  插入上传证明文件的记录到数据库
 * 參數1:        $qa_user_attachment_id     第三层评估ID
 * 參數2:        $token                     令牌
 */
var api_qa_upload_fileproves_data_insert_sql = api_test_webroot + "AssProcessController/qa_upload_fileproves_data_insert_sql";

/*
 *  上传证明文件
 * 參數1:        $qa_user_attachment_id     第三层评估ID
 * 參數2:        $token                     令牌
 */
var api_prototype_send_file = api_test_webroot + "AssProcessController/qa_upload_fileproves_file";

/*
 * 	删除上传的证明文件
 * 參數1:        $qa_user_attachment_id     第三层评估ID
 * 參數2:        $token                     令牌
 */
var api_prototype_delete_pic = api_test_webroot + "AssProcessController/qa_delete_fileproves_file";

/*
 * 	发送证明文件的文字说明
 * 參數1:        $lv4_id     第四层评估ID
 * 參數3:        $text_val   输入数据
 * 參數2:        $token      令牌
 */
var api_prototype_send_textarea = api_test_webroot + "AssProcessController/qa_upload_inputproves";

/*
 *  双托客服人员导入学校资料
 * 參數1:        $key_province     省代号
 * 參數3:        $key_city         市代号
 * 參數3:        $key_area         区代号
 * 參數4:        $key_search       关键字
 * 參數5:        $token            令牌
 */
var api_import_school_info = api_test_webroot + "SchoolInfoController/import_school_info";

/*
 *  双托客服人员导入学校资料2
 * 參數1:        $key_province     省代号
 * 參數3:        $key_city         市代号
 * 參數3:        $key_area         区代号
 * 參數4:        $key_search       关键字
 * 參數5:        $token            令牌
 */
var api_insert_school_info = api_test_webroot + "SchoolInfoController/insert_school_info"

/*
 *  双托客服人员获取学校资料
 * 參數1:        $key_province     省代号
 * 參數3:        $key_city         市代号
 * 參數3:        $key_area         区代号
 * 參數4:        $key_search       关键字
 * 參數5:        $token            令牌
 */
var api_school_info_data = api_test_webroot + "SchoolInfoController/qa_get_school_info";

/*
 *  删除学校资料
 * 參數1:        $school_data      学校编号
 * 參數5:        $token            令牌
 */
var api_hidden_school = api_test_webroot + "SchoolInfoController/hidden_school";
/*
 *  输出学校账号
 * 參數1:        $school_data      学校编号
 * 參數5:        $token            令牌
 */
var api_explore_school_account = api_test_webroot + "SchoolInfoController/explore_school_account";
/*
 *  输出教委账号
 * 參數1:        $school_data      学校编号
 * 參數5:        $token            令牌
 */
var api_explore_education_account = api_test_webroot + "SchoolInfoController/explore_education_account";
/*
 *  输出其他账号
 * 參數1:        $school_data      学校编号
 * 參數5:        $token            令牌
 */
var api_explore_order_account = api_test_webroot + "SchoolInfoController/explore_order_account";

/*
 *  双托客服人员获取学校评估资料
 * 參數1:        $key_province     省代号
 * 參數3:        $key_city         市代号
 * 參數3:        $key_area         区代号
 * 參數4:        $key_search       关键字
 * 參數5:        $token            令牌
 */
var api_school_assessment_data = api_test_webroot + "AssessmentController/school_assessment_data";
/*
 *  双托客服人员获取学校评估资料
 * 參數1:        $key_province     省代号
 * 參數3:        $key_city         市代号
 * 參數3:        $key_area         区代号
 * 參數4:        $key_search       关键字
 * 參數5:        $token            令牌
 */
var api_education_or_order_account = api_test_webroot + "SchoolInfoController/get_education_or_order_account";
/*
 *  教委获取学校评估资料
 * 參數1:        $key_province     省代号
 * 參數3:        $key_city         市代号
 * 參數3:        $key_area         区代号
 * 參數4:        $key_search       关键字
 * 參數5:        $token            令牌
 */
var api_assessment_highcharts_data = api_test_webroot + "AssessmentController/assessment_highcharts_data";
/*
 *  教委获取学校评估资料
 * 參數1:        $key_province     省代号
 * 參數3:        $key_city         市代号
 * 參數3:        $key_area         区代号
 * 參數4:        $key_search       关键字
 * 參數5:        $token            令牌
 */
var api_assessment_export_excel = api_test_webroot + "AssessmentController/assessment_export_excel";
/*
 *  客服人员重设评估机会
 * 參數1:        $key_province     省代号
 * 參數3:        $key_city         市代号
 * 參數3:        $key_area         区代号
 * 參數4:        $key_search       关键字
 * 參數5:        $token            令牌
 */
var api_reset_assessment_chance = api_test_webroot + "AssessmentController/reset_assessment_chance";

/*
 *  教委获取学校评估资料
 * 參數1:        $key_province     省代号
 * 參數3:        $key_city         市代号
 * 參數3:        $key_area         区代号
 * 參數4:        $key_search       关键字
 * 參數5:        $token            令牌
 */
var api_get_area_information = api_test_webroot + "AreaController/get_area_information";

/*
 *  教委获取学校评估资料
 * 參數1:        $school_id        学校ID
 * 參數3:        $user_type        用户类型
 * 參數3:        $phone_number     手机号
 * 參數5:        $token            令牌
 */
var api_qa_get_smscode = api_test_webroot + "AssProcessController/qa_get_smscode";

/*
 *  教委获取学校评估资料
 * 參數1:        $school_id                 学校ID
 * 參數3:        $user_type                 用户类型
 * 參數3:        $user_id                   用户ID
 * 參數3:        $submit_user               提交人真实姓名
 * 參數3:        $asubmit_groupmenbers      督評組成員名稱（名稱用","隔開）
 * 參數3:        $sms_code                  手機短信驗證碼
 * 參數5:        $token                     令牌
 */
var api_qa_submit_evainfo = api_test_webroot + "AssProcessController/qa_submit_evainfo";

/*
 *  教委获取学校评估资料
 * 參數1:        $school_id        学校ID
 * 參數3:        $user_type        用户类型
 * 參數5:        $token            令牌
 */
var api_qa_submit_evadata = api_test_webroot + "AssProcessController/qa_submit_evadata";

/*
 *  督学长重置功能
 * 參數1:        $school_id        学校ID
 * 參數3:        $user_type        用户类型
 * 參數5:        $token            令牌
 */
var api_qa_edit_evaprogress = api_test_webroot + "AssProcessController/qa_edit_evaprogress";

/*
 *  获取证明文件OSS路径
 * 參數1:        $school_id        学校ID
 * 參數3:        $user_id          用户类型
 * 參數3:        $file_path        文件相对路径
 * 參數5:        $token            令牌
 */
var api_qa_get_ossfile_link = api_test_webroot + "AssProcessController/qa_get_ossfile_link";

/*
 *  设置school_info(13~67)
 * 參數1:        $school_id        学校ID
 * 參數3:        $info_type        园所信息类型
 * 參數5:        $token            令牌
 */
var api_prototype_get_school_info = api_test_webroot + "AssProcessController/prototype_get_school_info";

/*
 *  设置school_info(13~67)
 * 參數1:        $school_id        学校ID
 * 參數3:        $info_type        园所信息类型
 * 參數3:        $detailinfo       学校详细信息
 * 參數5:        $token            令牌
 */
var api_prototype_set_school_info = api_test_webroot + "AssProcessController/prototype_set_school_info";

/*
 *  根据学校ID获取该学校用户密码
 * 參數1:        $school_id        学校ID
 * 參數5:        $token            令牌
 */
var api_prototype_get_school_password = api_test_webroot + "AssProcessController/prototype_get_school_password";

/*
 *  根据用户ID获取该用户密码
 * 參數1:        $user_id          用户ID
 * 參數5:        $token            令牌
 */
var api_prototype_get_user_password = api_test_webroot + "AssProcessController/prototype_get_user_password";

/*
 *  根据区号获取该区所有学校的教委用户密码
 * 參數1:        $user_id          用户ID
 * 參數2:        $area_code        区号
 * 參數5:        $token            令牌
 */
var api_prototype_get_password_for_area_code = api_test_webroot + "AssProcessController/prototype_get_password_for_area_code";

/*
 *  设置school_info(13~67)
 * 參數1:        $user_id_arr       用户ID数组
 * 參數2:        $user_password_arr 用户密码数组
 * 參數5:        $token             令牌
 */
var api_prototype_set_school_password = api_test_webroot + "AssProcessController/prototype_set_school_password";

/*
 *  排队输出excel和doc
 * 參數1:        $user_id_arr       用户ID数组
 * 參數2:        $user_password_arr 用户密码数组
 * 參數5:        $token             令牌
 */
var api_insert_outdatafiles_list = api_test_webroot + "ServerDaemonController/insert_outdatafiles_list";

/*
 *  北京大众获取学校信息
 * 參數1:        $key_search        用户输入的学校标识码
 * 參數5:        $token             令牌
 */
var api_beijing_school_assessment_data = api_test_webroot + "BeiJingController/school_assessment_data";

/*
 *  北京大众获取已经输出压缩包的学校
 * 參數1:        $key_search        用户输入的学校标识码
 * 參數5:        $token             令牌
 */
var api_beijing_output_school_list = api_test_webroot + "BeiJingController/beijing_output_school_list";

/*
 *  超级管理员、专家和北京大众人员下载docx报告
 * 參數1:        $key_search        用户输入的学校标识码
 * 參數5:        $token             令牌
 */
var api_download_docx = api_test_webroot + "ExportDocxController/download_docx";


/*
 *  检查视频是否可看
 * 參數1:        $srcdata           用户输入的学校标识码
 * 參數5:        $token             令牌
 */
var api_prototype_check_src_success = api_test_webroot + "AssProcessController/check_src_success";



