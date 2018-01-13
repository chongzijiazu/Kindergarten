//判断是否登录
check_is_error_url();
function check_is_error_url(){
	if(!localstorageGet("user_info") && !localstorageGet("is_goto")){
		header_logout();
	}else{
		var temp_href_val = location.href;
		var temp_href_arr = temp_href_val.split("/");
		temp_href_val = temp_href_arr[temp_href_arr.length-1];

		if(!localstorageGet("is_goto")){
			var user_type = localstorageGet("user_info")['user_type'];
			if((temp_href_val=="mb_category.html" || temp_href_val=="mb_evaluate.html") && user_type!="1" && user_type!="2" && user_type!="3" && user_type!="4" && user_type!="5" && user_type!="6" && user_type!="7"){
				header_logout();
			}else if((temp_href_val=="qa_assessment_check.html") && user_type!="8" && user_type!="9"){
				header_logout();
			}else if((temp_href_val=="qa_customer_service.html") && user_type!="10"){
				header_logout();
			}else if((temp_href_val=="qa_beijing.html") && user_type!="11"){
				header_logout();
			}else if((temp_href_val=="qa_superadmin.html") && user_type!="12"){
				header_logout();
			}
		}
		
	}
	
}
var is_show_error_alert_box = false;
var header_html = "";

//最顶的工具条
header_html += "<div class='header_title'>";
header_html +=     "<div class='header_logo_img'></div>";
header_html +=     "<div class='text-center header_system_name'><img src='../images/ic_logo.png' width='90'><span>幼儿园办园行为评估系统</span></div>";
header_html +=     "<div class='text-right header_btn_class'>";
header_html +=         "<div id='btn_sch_info' onclick='popup_edit_sch_info(this);' onblur='hide_popup_header();' tabindex='0'></div>";
// header_html +=         "<div id='btn_sch_info' class='btn_sch_info_dim'></div>";
header_html +=         "<div id='btn_play_video' onclick='popup_play_video(this);' onblur='hide_popup_header();' tabindex='0'></div>";
header_html +=         "<span id='btn_popup_logout_box'>";
header_html +=             "<span id='btn_popup_logout' onclick='popup_logout(this);' onblur='hide_popup_header();' tabindex='0'></span>";
header_html +=             "<span id='login_name_show' onclick='popup_logout(this);' onblur='hide_popup_header();' tabindex='0'>"+localstorageGet("login_name_show")+"</span>";
header_html += 	           "<span id='btn_login_daosanjiao' class='glyphicon glyphicon-triangle-bottom' onclick='popup_logout(this);' onblur='hide_popup_header();' tabindex='0'></span>";
header_html +=         "</span>";
header_html +=     "</div>";
header_html += "</div>";


//popup school detailinfo

header_html += "<div class='sch_dim_box'></div>";
header_html += "<div class='' id='header_popup_content'>";
// header_html += 					"<button id='close_btn' type='button' class='glyphicon glyphicon-remove-circle close' data-dismiss='modal' aria-hidden='true'></button>";

header_html +=		"<div class='modal-header sch_info_title'>幼儿园信息</div>";
header_html += 		"<div class='modal-title ' id='header_myModalLabel'>";
header_html +=			"<div class='header_input_box_1'>";
header_html +=				"<span class='header_pop_span'>学校（机构）名称：</span>";
header_html +=				"<input class='edt_input ei_0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_2'>";
header_html +=				"<span class='header_pop_span'>学校（机构）标识码：</span>";
header_html +=				"<span class='edt_span ei_1'></span>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_1'>";
header_html +=				"<span class='header_pop_span'>学校（机构）地址名称：</span>";
header_html +=				"<input class='edt_input ei_2'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_2'>";
header_html +=				"<span class='header_pop_span'>学校（机构）地址代码：</span>";
header_html +=				"<span class='edt_span ei_3'></span>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_1'>";
header_html +=				"<span class='header_pop_span'>学校（机构）驻地城乡类型名称：</span>";
header_html +=				"<select class='edt_input ei_4'>";
header_html +=					"<option value='主城区'>主城区</option>";
header_html +=					"<option value='城乡结合区'>城乡结合区</option>";
header_html +=					"<option value='镇中心区'>镇中心区</option>";
header_html +=					"<option value='镇乡结合区'>镇乡结合区</option>";
header_html +=					"<option value='特殊区域'>特殊区域</option>";
header_html +=					"<option value='乡中心区'>乡中心区</option>";
header_html +=					"<option value='村庄'>村庄</option>";
header_html +=				"</select>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_2'>";
header_html +=				"<span class='header_pop_span'>学校（机构）驻地城乡类型代码：</span>";
header_html +=				"<select class='edt_input ei_5'>";
header_html +=					"<option value='111'>111</option>";
header_html +=					"<option value='112'>112</option>";
header_html +=					"<option value='121'>121</option>";
header_html +=					"<option value='122'>122</option>";
header_html +=					"<option value='123'>123</option>";
header_html +=					"<option value='210'>210</option>";
header_html +=					"<option value='220'>220</option>";
header_html +=				"</select>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_1'>";
header_html +=				"<span class='header_pop_span'>学校（机构）办学类型名称：</span>";
header_html +=				"<select class='edt_input ei_6'>";
header_html +=					"<option value='幼儿园'>幼儿园</option>";
header_html +=					"<option value='独立设置的少数民族幼儿园'>独立设置的少数民族幼儿园</option>";
header_html +=					"<option value='附设幼儿班'>附设幼儿班</option>";
header_html +=				"</select>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_2'>";
header_html +=				"<span class='header_pop_span'>学校（机构）办学类型代码：</span>";
header_html +=				"<select class='edt_input ei_7'>";
header_html +=					"<option value='111'>111</option>";
header_html +=					"<option value='112'>112</option>";
header_html +=					"<option value='119'>119</option>";
header_html +=				"</select>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_1'>";
header_html +=				"<span class='header_pop_span'>学校（机构）举办者名称：</span>";
header_html +=				"<select class='edt_input ei_8'>";
header_html +=					"<option value='中央'>中央</option>";
header_html +=					"<option value='省级教育部门'>省级教育部门</option>";
header_html +=					"<option value='省级其他部门'>省级其他部门</option>";
header_html +=					"<option value='地级教育部门'>地级教育部门</option>";
header_html +=					"<option value='地级其他部门'>地级其他部门</option>";
header_html +=					"<option value='县级教育部门'>县级教育部门</option>";
header_html +=					"<option value='县级其他部门'>县级其他部门</option>";
header_html +=					"<option value='地方企业'>地方企业</option>";
header_html +=					"<option value='事业单位'>事业单位</option>";
header_html +=					"<option value='部队'>部队</option>";
header_html +=					"<option value='集体'>集体</option>";
header_html +=					"<option value='民办'>民办</option>";
header_html +=				"</select>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_2'>";
header_html +=				"<span class='header_pop_span'>学校（机构）举办者代码：</span>";
header_html +=				"<select class='edt_input ei_9'>";
header_html +=					"<option value='党政机关代码'>党政机关代码</option>";
header_html +=					"<option value='811'>811</option>";
header_html +=					"<option value='812'>812</option>";
header_html +=					"<option value='821'>821</option>";
header_html +=					"<option value='822'>822</option>";
header_html +=					"<option value='831'>831</option>";
header_html +=					"<option value='832'>832</option>";
header_html +=					"<option value='891'>891</option>";
header_html +=					"<option value='892'>892</option>";
header_html +=					"<option value='893'>893</option>";
header_html +=					"<option value='894'>894</option>";
header_html +=					"<option value='999'>999</option>";
header_html +=				"</select>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_1'>";
header_html +=				"<span class='header_pop_span'>计划内预防接种率（%）：</span>";
header_html +=				"<input class='edt_input ei_10'>%";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_2'>";
header_html +=				"<span class='header_pop_span'>传染病年发病率（%）：</span>";
header_html +=				"<input class='edt_input ei_11'>%";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_1'>";
header_html +=				"<span class='header_pop_span'>幼儿出勤率（%）：</span>";
header_html +=				"<input class='edt_input ei_12'>%";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_2'>";
header_html +=				"<span class='header_pop_span'>专任教师年保留率（%）：</span>";
header_html +=				"<input class='edt_input ei_13'>%";
header_html +=			"</div>";

header_html +=			"<div class='header_input_box_1'></div>";
header_html +=			"<div class='header_input_box_1'>";
header_html +=				"<span class='header_pop_span hps_0'>是否普惠性民办幼儿园：</span>";
header_html +=				"<input type='radio' class='edt_radio er_0' name='er_group_0' value='0'><span class='class_bt_20'>是</span>";
header_html +=				"<input type='radio' class='edt_radio er_0' name='er_group_0' value='1'><span class='class_bt_20'>否</span>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_1'>";
header_html +=				"<span class='header_pop_span hps_1'>是否乡镇中心幼儿园：</span>";
header_html +=				"<input type='radio' class='edt_radio er_0' name='er_group_1' value='0'><span class='class_bt_20'>是</span>";
header_html +=				"<input type='radio' class='edt_radio er_0' name='er_group_1' value='1'><span class='class_bt_20'>否</span>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_1'>";
header_html +=				"<span class='header_pop_span hps_2'>是否寄宿制幼儿园：</span>";
header_html +=				"<input type='radio' class='edt_radio er_0' name='er_group_2' value='0'><span class='class_bt_20'>是</span>";
header_html +=				"<input type='radio' class='edt_radio er_0' name='er_group_2' value='1'><span class='class_bt_20'>否</span>";
header_html +=			"</div>";

header_html +=			"<div class='header_input_box_3'>";
header_html +=				"<span class='header_pop_span hps_3'>安全保卫人员数：</span>";
header_html +=				"<input type='text' class='edt_number en_0' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_4'>";
header_html +=				"<span class='header_pop_span hps_3'>图书（册）：</span>";
header_html +=				"<input type='text' class='edt_number en_1' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_3'>";
header_html +=				"<span class='header_pop_span hps_3'>学前教育专业毕业的专任教师数：</span>";
header_html +=				"<input type='text' class='edt_number en_2' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_4'>";
header_html +=				"<span class='header_pop_span hps_3'>学前教育专业毕业的保育员数：</span>";
header_html +=				"<input type='text' class='edt_number en_3' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_3'>";
header_html +=				"<span class='header_pop_span hps_3'>取得教师资格证的专任教师数：</span>";
header_html +=				"<input type='text' class='edt_number en_4' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_4'>";
header_html +=				"<span class='header_pop_span hps_3'>与幼儿园签订聘用合同或劳动合同的教职工数：</span>";
header_html +=				"<input type='text' class='edt_number en_5' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_3'>";
header_html +=				"<span class='header_pop_span hps_3'>工资不低于当地最低工资标准的教职工数：</span>";
header_html +=				"<input type='text' class='edt_number en_6' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_4'>";
header_html +=				"<span class='header_pop_span hps_3'>受过幼儿保育职业培训的保育员数：</span>";
header_html +=				"<input type='text' class='edt_number en_7' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_3'>";
header_html +=				"<span class='header_pop_span hps_3'>兼职卫生保健人员数：</span>";
header_html +=				"<input type='text' class='edt_number en_8' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_4'>";
header_html +=				"<span class='header_pop_span hps_3'>供餐数量（几餐）：</span>";
header_html +=				"<input type='text' class='edt_number en_9' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_3'>";
header_html +=				"<span class='header_pop_span hps_3'>专职炊事员数：</span>";
header_html +=				"<input type='text' class='edt_number en_10' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_4'>";
header_html +=				"<span class='header_pop_span hps_3'>兼职炊事员数：</span>";
header_html +=				"<input type='text' class='edt_number en_11' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_3'>";
header_html +=				"<span class='header_pop_span hps_3'>兼职安保人员数：</span>";
header_html +=				"<input type='text' class='edt_number en_12' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_4'>";
header_html +=				"<span class='header_pop_span hps_3'>多功能活动室面积：</span>";
header_html +=				"<input type='text' class='edt_number en_13' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_3'>";
header_html +=				"<span class='header_pop_span hps_3'>教师用计算机台数：</span>";
header_html +=				"<input type='text' class='edt_number en_14' value='0'>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_4'>";
header_html +=				"<span class='header_pop_span hps_3'>教师专业用书数量：</span>";
header_html +=				"<input type='text' class='edt_number en_15' value='0'>";
header_html +=			"</div>";

header_html +=			"<div class='header_input_box_3'>";
header_html +=				"<table class='header_pop_table' cellpadding='0' cellspacing='0' border='1'>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_1' colspan='5'>班数</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_3'>合计</td>";
header_html +=						"<td class='class_td_3'>托班</td>";
header_html +=						"<td class='class_td_3'>小班</td>";
header_html +=						"<td class='class_td_3'>中班</td>";
header_html +=						"<td class='class_td_3'>大班</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class=''><span class='td_edt_input td_g1 td_g1_0' biaoshi='0' maxlength='2' ></span></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g1 td_g1_1' biaoshi='1' maxlength='2' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g1 td_g1_2' biaoshi='2' maxlength='2' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g1 td_g1_3' biaoshi='3' maxlength='2' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g1 td_g1_4' biaoshi='4' maxlength='2' ></td>";
header_html +=					"</tr>";
header_html +=				"</table>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_3'>";
header_html +=				"<table class='header_pop_table' cellpadding='0' cellspacing='0' border='1'>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_1' colspan='5'>在园（班）人数</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_2'>合计</td>";
header_html +=						"<td class='class_td_2'>托班</td>";
header_html +=						"<td class='class_td_2'>小班</td>";
header_html +=						"<td class='class_td_2'>中班</td>";
header_html +=						"<td class='class_td_2'>大班</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class=''><span class='td_edt_input td_g2 td_g2_0' biaoshi='5' maxlength='3' ></span></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g2 td_g2_1' biaoshi='6' maxlength='3' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g2 td_g2_2' biaoshi='7' maxlength='3' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g2 td_g2_3' biaoshi='8' maxlength='3' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g2 td_g2_4' biaoshi='9' maxlength='3' ></td>";
header_html +=					"</tr>";
header_html +=				"</table>";
header_html +=			"</div>";

header_html +=			"<div class='header_input_box_5'>";
header_html +=				"<table class='header_pop_table' cellpadding='0' cellspacing='0' border='1'>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_1' colspan='6'>教职工数</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_2'>合计</td>";
header_html +=						"<td class='class_td_2'>园长</td>";
header_html +=						"<td class='class_td_2'>专任教师</td>";
header_html +=						"<td class='class_td_2'>保健医</td>";
header_html +=						"<td class='class_td_2'>保育员</td>";
header_html +=						"<td class='class_td_2'>其它</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class=''><span class='td_edt_input td_g3 td_g3_0' biaoshi='10' maxlength='3' ></span></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g3 td_g3_1' biaoshi='11' maxlength='2' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g3 td_g3_2' biaoshi='12' maxlength='3' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g3 td_g3_3' biaoshi='13' maxlength='2' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g3 td_g3_4' biaoshi='14' maxlength='2' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g3 td_g3_5' biaoshi='15' maxlength='2' ></td>";
header_html +=					"</tr>";
header_html +=				"</table>";
header_html +=			"</div>";

header_html +=			"<div class='header_input_box_5'>";
header_html +=				"<table class='header_pop_table' cellpadding='0' cellspacing='0' border='1'>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_1' colspan='5'>专任教师学历</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_3'>研究生毕业</td>";
header_html +=						"<td class='class_td_3'>本科毕业</td>";
header_html +=						"<td class='class_td_3'>专科毕业</td>";
header_html +=						"<td class='class_td_3'>高中阶段毕业</td>";
header_html +=						"<td class='class_td_3'>高中阶段以下毕业</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class=''><input class='td_edt_input td_g4 td_g4_0' biaoshi='16' maxlength='3' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g4 td_g4_1' biaoshi='17' maxlength='3' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g4 td_g4_2' biaoshi='18' maxlength='3' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g4 td_g4_3' biaoshi='19' maxlength='3' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g4 td_g4_4' biaoshi='20' maxlength='3' ></td>";
header_html +=					"</tr>";
header_html +=				"</table>";
header_html +=			"</div>";

header_html +=			"<div class='header_input_box_6'>";
header_html +=				"<table class='header_pop_table' cellpadding='0' cellspacing='0' border='1'>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_1' colspan='4'>保育员学历</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_4'>本科毕业及以上</td>";
header_html +=						"<td class='class_td_4'>专科毕业</td>";
header_html +=						"<td class='class_td_4'>高中阶段毕业</td>";
header_html +=						"<td class='class_td_4'>高中阶段以下毕业</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class=''><input class='td_edt_input td_g5 td_g5_0' biaoshi='21' maxlength='2' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g5 td_g5_1' biaoshi='22' maxlength='2' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g5 td_g5_2' biaoshi='23' maxlength='2' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g5 td_g5_3' biaoshi='24' maxlength='2' ></td>";
header_html +=					"</tr>";
header_html +=				"</table>";
header_html +=			"</div>";
header_html +=			"<div class='header_input_box_7'>";
header_html +=				"<table class='header_pop_table' cellpadding='0' cellspacing='0' border='1'>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_1' colspan='3'>占地面积</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_2'>合计</td>";
header_html +=						"<td class='class_td_5'>其中：绿化用地面积</td>";
header_html +=						"<td class='class_td_5'>运动场地面积</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class=''><input class='td_edt_input td_g6 td_g6_0' biaoshi='25' maxlength='12' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g6 td_g6_1' biaoshi='26' maxlength='12' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g6 td_g6_2' biaoshi='27' maxlength='12' ></td>";
header_html +=					"</tr>";
header_html +=				"</table>";
header_html +=			"</div>";

header_html +=			"<div class='header_input_box_5'>";
header_html +=				"<table class='header_pop_table' cellpadding='0' cellspacing='0' border='1'>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_1' colspan='6'>校舍建筑面积</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class='class_td_6'>合计</td>";
header_html +=						"<td class='class_td_6'>其中：租借面积</td>";
header_html +=						"<td class='class_td_6'>危房面积</td>";
header_html +=						"<td class='class_td_6'>活动室面积</td>";
header_html +=						"<td class='class_td_6'>睡眠室面积</td>";
header_html +=						"<td class='class_td_6'>保健室面积</td>";
header_html +=					"</tr>";
header_html +=					"<tr>";
header_html +=						"<td class=''><input class='td_edt_input td_g7 td_g7_0' biaoshi='28' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g7 td_g7_1' biaoshi='29' maxlength='12' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g7 td_g7_2' biaoshi='30' maxlength='12' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g7 td_g7_3' biaoshi='31' maxlength='12' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g7 td_g7_4' biaoshi='32' maxlength='12' ></td>";
header_html +=						"<td class=''><input class='td_edt_input td_g7 td_g7_5' biaoshi='33' maxlength='12'></td>";
header_html +=					"</tr>";
header_html +=				"</table>";
header_html +=			"</div>";

header_html +=		"</div>";

header_html +=		"<div class='text-right sch_info_btn_box'>";
header_html +=			"<button id='btn_header_popup_cencel' type='button' class='button button--moema button--text-upper button--color-lan' onclick='header_control_popup_close();'>取消</button>";
header_html +=			"<button id='btn_header_popup_sueecss' type='button' class='button button--moema button--text-upper button--color-lan' onclick='setSchoolInfo(this);'>修改</button>";
header_html +=		"</div>";
header_html += "</div>";


//popup password edit box

header_html += "<div class='pw_dim_box'></div>";
header_html += "<div class='' id='header_popup_password_content'>";

header_html +=		"<div class='modal-header pw_info_title'>修改账号密码</div>";
header_html += 		"<div class='modal-title' id='header_myModalLabel_pw'>";
header_html +=			"<div class='header_input_box_1'>";
header_html +=				"<span class='header_pop_pw_span pw_t1'>幼儿园自评1：</span>";
header_html +=				"<input class='edt_input ei_0'>";
header_html +=			"</div>";

header_html +=		"</div>";

header_html +=		"<div class='text-right pw_info_btn_box'>";
header_html +=			"<button id='btn_header_pw_popup_cencel' type='button' class='button button--moema button--text-upper button--color-lan' onclick='header_control_pw_popup_close();'>取消</button>";
header_html +=			"<button id='btn_header_pw_popup_sueecss' type='button' class='button button--moema button--text-upper button--color-lan' onclick='setSchoolPassword(this);'>修改</button>";
header_html +=		"</div>";
header_html += "</div>";

//popup video
header_html += "<div class='dim_box'></div>";
header_html += "<div id='video_box' class='text-center'>";
header_html +=     "<div id='video_html'><div id='video'></div></div>";
header_html +=     "<div class='col-md-12 text-center'>";
header_html +=         "<button id='btn_clode_video' type='button' class='btn btn-info' onclick='close_video();'>关闭</button>";
header_html +=     "</div>";
header_html += "</div>";


//popup edit school info
header_html += "<div class='popup_edit_sch_info popover bottom'>";
header_html += "<div class='arrow'></div>";
header_html += "<span class='text-center class_zi_05'>幼儿园信息</span>";
header_html += "<div id='btn_edit_school_info' class='button button--moema button--text-upper' onclick='header_sch_info(this);' onmouseover='popup_header_over();' onmouseout='popup_header_out();'>查看/修改</div>";
header_html += "</div>";

//popup play video
header_html += "<div class='popup_play_video popover bottom'>";
header_html += "<div class='arrow'></div>";
header_html += "<span class='text-center class_zi_05'>使用说明</span>";
header_html += "<div id='btn_play_video_go' class='button button--moema button--text-upper' onclick='goto_play_video(this);' onmouseover='popup_header_over();' onmouseout='popup_header_out();'>指标解读视频</div>";
header_html += "<div id='btn_play_video_go_2' class='button button--moema button--text-upper' onclick='goto_play_video(this);' onmouseover='popup_header_over();' onmouseout='popup_header_out();'>使用说明视频</div>";
header_html += "<div class='button button--moema button--text-upper btn_down_doc_go' data-url='http://qszk-bucket.oss-cn-beijing.aliyuncs.com/video/Instructions.pdf' onmouseover='popup_header_over();' onmouseout='popup_header_out();'>使用说明文字</div>";
header_html += "<div class='button button--moema button--text-upper btn_down_doc_go' data-url='http://qszk-bucket.oss-cn-beijing.aliyuncs.com/video/directory.pdf' onmouseover='popup_header_over();' onmouseout='popup_header_out();'>准备资料目录</div>";
header_html += "</div>";
//popup logout
var user_type = localstorageGet("user_info")['user_type'];
var temp_str = "";
if(user_type=="1"){
	temp_str = "园长";
}else if(user_type=="2"){
	temp_str = "教师";
}else if(user_type=="3"){
	temp_str = "督学组长";
}else if(user_type=="4"){
	temp_str = "督学";
}else if(user_type=="5" || user_type=="6" || user_type=="7"){
	temp_str = "复评";
}else if(user_type=="8"){
	temp_str = "教委";
}else if(user_type=="9"){
	temp_str = "专家";
}else if(user_type=="10"){
	temp_str = "客服";
}else if(user_type=="11"){
	temp_str = "北京大众人员";
}else if(user_type=="12"){
	temp_str = "管理员";
}
header_html += "<div class='popup_logout popover bottom'>";
header_html += "<div class='arrow'></div>";
header_html += "<div><img src='../images/ic_yonghuming.png' width='33'><span class='logout_text user_type_"+ user_type +"'>欢迎您，"+temp_str+"!</span></div>";
header_html += "<div id='btn_logout_go' type='button' class='button button--moema button--text-upper button--color-red' onclick='header_logout(this);' onmouseover='popup_header_over();' onmouseout='popup_header_out();'>退出</div>";
header_html += "</div>";

header_html += "<div id='overlay'>";
header_html +=     "<a class='close' title='close'></a>";
header_html +=     "<div id='overlay-player'></div>";
header_html += "</div>";
document.write(header_html);

//弹出学校信息
function header_sch_info(school_id, user_type){
	check_popup_header = 0;
	$(".popup_edit_sch_info").hide();
	$(".sch_dim_box").show();
	// $("#header_popup_content").show();
	$("body").css("overflow", "hidden");
	resizeCallback();
	getSchoolInfo(school_id, user_type);
}
window.onresize = window.onorientationchange = resizeCallback;
function resizeCallback(){
	var window_height = $(window).height();
	var temp_height = window_height - 30 - 50;
	var temp_height_2 = window_height - 100 - 50;
	$("#header_popup_content").css("max-height", temp_height + "px");
	$("#header_myModalLabel").css("max-height", (temp_height - 130) + "px");
	if((window_height - 460) < 150){
		$("#header_popup_password_content").css("max-height", temp_height_2 + "px");
		$("#header_myModalLabel_pw").css("max-height", (temp_height_2 - 130) + "px").css("overflow-y", "scroll");
	}else{
		$("#header_popup_password_content").css("max-height", "");
		$("#header_myModalLabel_pw").css("max-height", "").css("overflow-y", "auto");
	}
}

function header_control_popup_close(){
	$(".sch_dim_box").hide();
	$("#header_popup_content").hide();
	$("body").css("overflow", "auto");
}


//控制弹出的公共方法
var check_popup_header = 0;
var save_header_select;
function popup_header_over(){
	check_popup_header = 2;
}
function popup_header_out(){
	check_popup_header = 1;
	$(save_header_select).focus();
}

//弹出修改幼儿园信息
function popup_edit_sch_info(tObj){
	$(".popup_edit_sch_info").hide();
	$(".popup_play_video").hide();
	$(".popup_logout").hide();
	save_header_select = $(tObj);

	if(check_popup_header==0){
		check_popup_header = 1;
	}else if(check_popup_header==1){
		check_popup_header = 0;
		return;
	}
	$(".popup_edit_sch_info").css({
		top: ($("#btn_sch_info").offset().top + 35) + 'px',
		left: ($("#btn_sch_info").offset().left - 55) + 'px'
	});
	$(".popup_edit_sch_info").show();
}

//弹出播放按钮
function popup_play_video(tObj){
	$(".popup_edit_sch_info").hide();
	$(".popup_play_video").hide();
	$(".popup_logout").hide();
	save_header_select = $(tObj);

	if(check_popup_header==0){
		check_popup_header = 1;
	}else if(check_popup_header==1){
		check_popup_header = 0;
		return;
	}
	$(".popup_play_video").css({
		top: ($("#btn_play_video").offset().top + 35) + 'px',
		left: ($("#btn_play_video").offset().left - 70) + 'px'
	});
	$(".popup_play_video").show();
}


//播放视频
function goto_play_video(){
	$(".popup_play_video").hide();
	// $(".dim_box").show();
	// $("#video_box").show();
	// read();
}

function read(){

	var srcdata = "../video/test.mp4";
	$("#video").flowplayer(
	{
		playlist: [
			[
				{ mp4:  srcdata }
			]
      	],
      	embed: false,
      	controls: {}
	})
}
function close_video(){
	$(".dim_box").hide();
	$("#video_box").hide();
	$("#video_html").html("<div id='video'></div>");
}


//点击弹出登出的按钮
var save_popup_arr = [];
function popup_logout(tObj,go_type){
	// console.log(event.type);
	$(".popup_edit_sch_info").hide();
	$(".popup_play_video").hide();
	$(".popup_logout").hide();
	save_header_select = $(tObj);

	if(check_popup_header==0){
		check_popup_header = 1;
	}else if(check_popup_header==1 && save_popup_arr[1]!=$(tObj).attr("qa_user_attachment_id")){
		check_popup_header = 0;
		$(".popup_logout").hide();
		return;
	}else{
		check_popup_header = 0;
		$(".popup_logout").hide();
		return;
	}
	if(event.type=='click'){
		isTouch = 0;
	}else{
		isTouch = 1;
	}
	var e = fixEvent(event);
	
	$(".popup_logout").css({
		top: ($("#btn_login_daosanjiao").offset().top + 29) + 'px',
		left: ($("#btn_login_daosanjiao").offset().left - 180) + 'px'
	});

	var temp_val = $("#login_name_show").width()/2;
	temp_val = 100 - (temp_val / 120 * 100);
	$(".popup_logout").find('.arrow').css({
		left: temp_val + '%'
	});
	$(".popup_logout").show();
}
function test(){
	$(".popup_hide_control").hide();
	$(".popup_hide_5").show();
	$(".class_bt_11").html("网络连接失败，请检查后重试。");
	$("#btn_popup_cencel").hide();
	$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	$("#btn_popup_sueecss").html("确定");
	$("#myModalLabel").css("min-height", "180px");
	$("#popup_content").css("min-height", "270px");
	$(".control_btn_padding").css("padding-left", "19%");
}

//隐藏弹出按钮
function hide_popup_header(){
	if(check_popup_header==2){
		return;
	}else{
		check_popup_header = 0;
		$(".popup_edit_sch_info").hide();
		$(".popup_play_video").hide();
		$(".popup_logout").hide();
	}
}

function header_logout(){
	// localstorageClear();
	localstorageRemove("sch_start_time");
	localstorageRemove("sch_end_time");
	localstorageRemove("user_info");
	localstorageRemove("school_info");
	localstorageRemove("login_name_show");
	localstorageRemove("sch_eva_progress");
	localstorageRemove("is_goto");
	localstorageRemove("school_info_check");
	localstorageRemove("ass_level1_autoid");
	localstorageRemove("ass_level2_autoid");
	localstorageRemove("ass_level3_autoid");
	localstorageRemove("lv_arr_index");
	localstorageRemove("save_lv_arr");

	window.location.href = "login.html";
}
//ajax全局报错监听
$(document).ajaxError(function(event, request, settings) {
  $( "#msg" ).append( "<li>Error requesting page " + settings.url + "</li>" );
});

//绑定弹出播放视频方法
var check_is_error = 0;
var flowplayer_api;
$(document).ready(function() {
	$(".big_div").on('click', function(event) {
		// event.preventDefault();
		/* Act on the event */
		hide_popup_header();
	});
	
	//video
	$('#myModal').live('hide.bs.modal', function(){
		setTimeout(function(){
			is_show_error_alert_box = false;
		},500);
	})

	$(".td_edt_input").css("background-color", "transparent");

	$("#overlay .close").live("click", function(){
		$("#overlay").animate({
			opacity: 0},
			"normal", function() {
				$("#overlay").hide();
				$("#overlay").css("opacity", "1");
				$("#exposeMask").hide();
				if(flowplayer_api){
					flowplayer_api.unload();
				}
				$("#overlay-player").removeClass('is-error');
				if(overlayObj){
					overlayObj.close();
				}
				if(overlayObj_2){
					overlayObj_2.close();
				}
		});
	})
	
	// var srcdata = "http://qszk-bucket.oss-cn-beijing.aliyuncs.com/video/test.mp4";
	var srcdata = "http://pinggu.qszhiku.com/video/3.mp4";
	overlayObj = $("#btn_play_video_go").overlay({
		api: true,
	    target: "#overlay",
	    closeOnEsc: false, // see comment on flowplayer keyboard option above
	    closeOnClick: false, // 点击空白位不会关闭
	    top: "24%",
	    left: "24%",
	    mask: {
	      color: "#000",
	      opacity: 0.3
	    },
	    speed: "slow",
	    onBeforeLoad: function () {
	    	// derive file names from trigger index
	        cdn = "//edge.flowplayer.org/",
	        clip = {
	            qualities: ["216p", "360p", "720p"," 1080p"],
	            defaultQuality: "360p",
	            urlResolvers: 'secure',
	            sources: [
	            	{ type: "video/mp4",             src: srcdata }
	            ]
	        };
	 
    		//执行ajax检查是否在线
    		var user_type = 1;
    		var data_type = 1;
    		if(localstorageGet("is_goto")==1){
    			var school_id = localstorageGet("school_info_check")['id'];
    		}else{
    			var school_id    = localstorageGet("user_info")['school_id'];
    		}
    		var user_id   = localstorageGet("user_info")['id'];
    		$.ajax({
    			url       : api_prototype_check_src_success,
    			type      : "post",
    			dataType  : 'html',
    			data      : {
    				srcdata : srcdata
    			},
    			//请求成功后的回调函数有两个参数
    	    	success:function(data,textStatus){
    		    	// var jsonstr = JSON.stringify(data);
		    		// var jsondata = $.parseJSON(jsonstr);
		    		if(data==true){
		    			if (flowplayer_api === undefined) {
		    				// initial load
		    				flowplayer_api = flowplayer("#overlay-player", {
		    					clip: clip,
		    					splash: true,
		    					// set keyboard to false if you don't want to use closeOnEsc: false for overlay
		    					// keyboard: false,
		    					rtmp: "rtmp://s3b78u0kbtx79q.cloudfront.net/cfx/st",
		    					ratio: 9/16
		    				});
		    				flowplayer_api.load();
	    					// flowplayer_api = $("#overlay-player").flowplayer(
	    					// {
	    					// 	playlist: [
	    					// 		[
	    					// 			{ mp4:  srcdata }
	    					// 		]
	    				 //      	],
	    				 //      	embed: false

	    					// })
		    			} else {
		    				flowplayer_api.load(clip);
		    			}
		    		}else{
		    			$('#myModal').modal('hide');
		    			check_is_error = 1;
		    			setTimeout(function(){
		    				$(".modal-backdrop").remove();
		    				overlayObj.close();
		    				create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
		    			},1200);
		    		}
    	    	},
    	    	//请求失败时将调用此方法
    	    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    	    		$('#myModal').modal('hide');
    	    		check_is_error = 1;
    	    		setTimeout(function(){
    	    			$(".modal-backdrop").remove();
    	    			overlayObj.close();
    	    			create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
    	    		},1200);
    	    	}
    		});
	    },
	 
	    onBeforeClose: function (e) {
	    	if(check_is_error==0){
    			if (flowplayer_api.loading) {
    		    	e.preventDefault();
    			} else {
    		    // important! unload the player
    		    	flowplayer_api.unload();
    			}
	    	}else{
	    		check_is_error = 0;
	    	}
	    	
	    }
	});

	// var srcdata_2 = "http://qszk-bucket.oss-cn-beijing.aliyuncs.com/video/2.mp4";
	var srcdata_2 = "http://qszk-bucket.oss-cn-beijing.aliyuncs.com/video/test.mp4";
	// var srcdata_2 = "http://pinggu.qszhiku.com/video/使用视频.mp4";
	overlayObj_2 = $("#btn_play_video_go_2").overlay({
		api: true,
	    target: "#overlay",
	    closeOnEsc: false, // see comment on flowplayer keyboard option above
	    closeOnClick: false, // 点击空白位不会关闭
	    top: "24%",
	    left: "24%",
	    mask: {
	      color: "#000",
	      opacity: 0.3
	    },
	    speed: "slow",
	    onBeforeLoad: function () {
	    	// derive file names from trigger index
	        cdn = "//edge.flowplayer.org/",
	        clip = {
	            qualities: ["216p", "360p", "720p"," 1080p"],
	            defaultQuality: "360p",
	            urlResolvers: 'secure',
	            sources: [
	            	{ type: "video/mp4",             src: srcdata_2 }
	            ]
	        };
	 
    		//执行ajax检查是否在线
    		var user_type = 1;
    		var data_type = 1;
    		if(localstorageGet("is_goto")==1){
    			var school_id = localstorageGet("school_info_check")['id'];
    		}else{
    			var school_id    = localstorageGet("user_info")['school_id'];
    		}
    		var user_id   = localstorageGet("user_info")['id'];
    		$.ajax({
    			url       : api_prototype_check_src_success,
    			type      : "post",
    			dataType  : 'html',
    			data      : {
    				srcdata : srcdata_2
    			},
    			//请求成功后的回调函数有两个参数
    	    	success:function(data,textStatus){
    		    	// var jsonstr = JSON.stringify(data);
			    	// var jsondata = $.parseJSON(jsonstr);
			    	if(data==true){
			    		if (flowplayer_api === undefined) {
			    			// initial load
			    			flowplayer_api = flowplayer("#overlay-player", {
			    				clip: clip,
			    				splash: true,
			    				// set keyboard to false if you don't want to use closeOnEsc: false for overlay
			    				// keyboard: false,
			    				rtmp: "rtmp://s3b78u0kbtx79q.cloudfront.net/cfx/st",
			    				ratio: 9/16
			    			});
			    			flowplayer_api.load();
		    				// flowplayer_api = $("#overlay-player").flowplayer(
		    				// {
		    				// 	playlist: [
		    				// 		[
		    				// 			{ mp4:  srcdata_2 }
		    				// 		]
		    			 //      	],
		    			 //      	embed: false

		    				// })
			    		} else {
			    			flowplayer_api.load(clip);
			    		}
			    	}else{
			    		$('#myModal').modal('hide');
			    		check_is_error = 1;
			    		setTimeout(function(){
			    			$(".modal-backdrop").remove();
			    			overlayObj_2.close();
			    			create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
			    		},1200);
			    	}
    	    	},
    	    	//请求失败时将调用此方法
    	    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    	    		$('#myModal').modal('hide');
    	    		check_is_error = 1;
    	    		setTimeout(function(){
    	    			$(".modal-backdrop").remove();
    	    			overlayObj_2.close();
    	    			create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
    	    		},1200);
    	    	}
    		});
	    },
	 
	    onBeforeClose: function (e) {
	    	if(check_is_error==0){
    			if (flowplayer_api.loading) {
    		    	e.preventDefault();
    			} else {
    		    // important! unload the player
    		    	flowplayer_api.unload();
    			}
	    	}else{
	    		check_is_error = 0;
	    	}
	    }
	});
	
	$(".btn_down_doc_go").on('click', function(event) {
		// event.preventDefault();
		/* Act on the event */
		//var doc_url = "http://qszk-bucket.oss-cn-beijing.aliyuncs.com/video/Instructions.pdf";
		window.open($(this).data("url"));
	});

	var user_type = localstorageGet("user_info")['user_type'];
	if(user_type!='1' && user_type!='3'){
		$("#btn_sch_info").hide();
	}else{
		//实例化numberinput
		$(".en_0").spinner({maxlength:2,min:0,max:20});
		$(".en_1").spinner({maxlength:9,min:0,max:999999999});
		$(".en_2").spinner({maxlength:3,min:0,max:199});
		$(".en_3").spinner({maxlength:2,min:0,max:99});
		$(".en_4").spinner({maxlength:3,min:0,max:199});
		$(".en_5").spinner({maxlength:3,min:0,max:199});
		$(".en_6").spinner({maxlength:3,min:0,max:199});
		$(".en_7").spinner({maxlength:2,min:0,max:99});
		$(".en_8").spinner({maxlength:2,min:0,max:20});
		$(".en_9").spinner({maxlength:1,min:0,max:3});
		$(".en_10").spinner({maxlength:2,min:0,max:20});
		$(".en_11").spinner({maxlength:2,min:0,max:20});
		$(".en_12").spinner({maxlength:2,min:0,max:20});
		$(".en_13").spinner({maxlength:9,min:0,max:999999999});
		$(".en_14").spinner({maxlength:9,min:0,max:999999999});
		$(".en_15").spinner({maxlength:9,min:0,max:999999999});
	}

	
	//限制输入
	$(".ei_10,.ei_11,.ei_12,.ei_13").bind("keyup paste change", function (e){
		var header_temp_val = $(this).val();
		if(isNaN(header_temp_val)){
			header_temp_val = $(this).val().replace(/[\D]+/g, '');
			header_temp_val = parseFloat(header_temp_val) || '';
			$(this).val(header_temp_val);
		}
		header_temp_val = String(header_temp_val);
		if(header_temp_val.indexOf(".")>-1){
			var header_temp_arr = header_temp_val.split(".");
			if(header_temp_arr[1] && header_temp_arr[1].length>2){
				header_temp_val = header_temp_arr[0] + "." + header_temp_arr[1].substring(0, 2);
				header_temp_val = parseFloat(header_temp_val);
				$(this).val(header_temp_val);
			}
		}
		if(parseFloat(header_temp_val)>100){
			$(this).val(100);
		}
	})

	$(".td_edt_input").bind("blur", function (e){
		var header_temp_val = $(this).val();
		if(header_temp_val==""){
			$(this).val(0);
		}
	});
	$(".td_edt_input").bind("keyup paste change", function (e){
		var header_temp_val = $(this).val();
		if(header_temp_val==""){

		}else{
			if(header_temp_val.indexOf(".")>-1){
				var header_temp_arr = header_temp_val.split(".");
				if(header_temp_arr[1] && header_temp_arr[1].length>2){
					header_temp_val = header_temp_arr[0] + "." + header_temp_arr[1].substring(0, 2);
					header_temp_val = parseFloat(header_temp_val);
					$(this).val(header_temp_val);
				}
			}
			if($(this).hasClass("td_g6") || $(this).hasClass("td_g7")){
				if(isNaN(header_temp_val)){
					header_temp_val = $(this).val().replace(/[^0-9.]*/g, '');
					header_temp_val = parseFloat(header_temp_val) || 0;
					$(this).val(header_temp_val);
				}else if(header_temp_val===""){
					header_temp_val = $(this).val().replace(/[\D]+/g, '');
					header_temp_val = parseFloat(header_temp_val) || 0;
					$(this).val(header_temp_val);
				}else{
					var check_num_temp = $(this).val();
					header_temp_val = $(this).val().replace(/\b(0+)/gi,"");
					header_temp_val = parseFloat(header_temp_val) || 0;
					if(check_num_temp != header_temp_val || check_num_temp != check_num_temp.replace(/\b(0+)/gi,"")){
						$(this).val(header_temp_val);
					}
					
				}
			}else{
				header_temp_val = $(this).val().replace(/[\D]+/g, '');
				header_temp_val = parseInt(header_temp_val) || 0;
				$(this).val(header_temp_val);
			}
		}
		
		

		if($(this).attr("biaoshi") == "11"){if(parseInt(header_temp_val)>10){$(this).val(10)}}
		if($(this).attr("biaoshi") == "12"){if(parseInt(header_temp_val)>199){$(this).val(199)}}
		if($(this).attr("biaoshi") == "13"){if(parseInt(header_temp_val)>20){$(this).val(20)}}
		if($(this).hasClass("td_g4")){if(parseInt(header_temp_val)>199){$(this).val(199)}}
		if($(this).hasClass("td_g6")){if(parseInt(header_temp_val)>999999999){$(this).val(999999999)}}
		if($(this).hasClass("td_g7")){if(parseInt(header_temp_val)>999999999){$(this).val(999999999)}}

		//计算合计值
		if($(this).hasClass('td_g1')){
			var temp_val = parseInt($(".td_g1_1").val() || 0) + parseInt($(".td_g1_2").val() || 0) + parseInt($(".td_g1_3").val() || 0) + parseInt($(".td_g1_4").val() || 0);
			temp_val = parseInt(temp_val || 0);
			$(".td_g1_0").html(temp_val);
		}

		if($(this).hasClass('td_g2')){
			var temp_val = parseInt($(".td_g2_1").val() || 0) + parseInt($(".td_g2_2").val() || 0) + parseInt($(".td_g2_3").val() || 0) + parseInt($(".td_g2_4").val() || 0);
			temp_val = parseInt(temp_val || 0);
			$(".td_g2_0").html(temp_val);
		}

		if($(this).hasClass('td_g3')){
			var temp_val = parseInt($(".td_g3_1").val() || 0) + parseInt($(".td_g3_2").val() || 0) + parseInt($(".td_g3_3").val() || 0) + parseInt($(".td_g3_4").val() || 0) + parseInt($(".td_g3_5").val() || 0);
			temp_val = parseInt(temp_val || 0);
			$(".td_g3_0").html(temp_val);
		}

		if($(this).hasClass('td_g6')){
			var temp_val = parseFloat($(".td_g6_1").val() || 0) + parseFloat($(".td_g6_2").val() || 0);
			temp_val = parseFloat(temp_val || 0).toFixed(2);
			// $(".td_g6_0").html(temp_val);
		}

		if($(this).hasClass('td_g7')){
			var temp_val = parseFloat($(".td_g7_1").val() || 0) + parseFloat($(".td_g7_2").val() || 0) + parseFloat($(".td_g7_3").val() || 0) + parseFloat($(".td_g7_4").val() || 0) + parseFloat($(".td_g7_5").val() || 0);
			temp_val = parseFloat(temp_val || 0).toFixed(2);
			// $(".td_g7_0").html(temp_val);
		}
	});
});

function flowplayer_stop_api(){
	if (api === undefined){
		var api = flowplayer("#overlay-player");
	}
	api.stop();
}

//转换鼠标与touch
function fixEvent(e){
	if(isTouch == 0){
		if(window.navigator.appVersion.match(/6./i) == "6."){
			if( typeof e == "undefined" ) {
				e = window.event;
			}
			if( typeof e.layerX == "undefined" ) {
				e.layerX = e.offsetX;
			}
			if( typeof e.layerY == "undefined" ) {
				e.layerY = e.offsetY;
			}
			if( typeof e.pageX == "undefined" ) {
				e.pageX = e.clientX + document.body.scrollLeft - document.body.clientLeft;
			}
			if( typeof e.pageY == "undefined" ) {
				e.pageY = e.clientY + document.body.scrollTop - document.body.clientTop;
			}
		}else{
			e = getNativeEvent(e);
		}
	}
	else if (isTouch == 1){
		e = getNativeEvent(e).touches[0];
	}
	return e;
}

function getNativeEvent(event){
	while ( event && typeof event.originalEvent !== "undefined" ) {
		event = event.originalEvent;
	}
	return event;
}



//公用弹出框
//生成提示框
function create_alert_box(titlecontent, bodycontent, yescallback, yescontent, nocallback, nocontent, btntype, min_height, content_center){
	$("#myModal").remove();
	var temp_html = "";
	temp_html += "<div class='mb_alert_box modal fade' id='myModal' aria-labelledby='myModalLabel' aria-hidden='true'>";
	temp_html += 	"<div id='ta_class'>";
	temp_html += 		"<div id='tb_class'>";
	temp_html += 			"<div class='modal-dialog'>";
	temp_html += 				"<div class='modal-content' id='popup_content'>";
	temp_html += 					"<button id='close_btn' type='button' class='close' data-dismiss='modal' aria-hidden='true'></button>";

	temp_html += 					"<div class='modal-title' id='myModalLabel'>";
	
	temp_html += 					"<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>" + titlecontent + "</p>";
	if(content_center == undefined){
		temp_html += 					"<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 text-center class_bt_11 popup_text'>" + bodycontent + "</p>";
	}else{
		temp_html += 					"<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 " + content_center + " class_bt_11 popup_text'>" + bodycontent + "</p>";
	}
	
	temp_html +=					"</div>";

	temp_html += 					"<div class='col-md-12 text-center'>";
	
	if(btntype==2){
	temp_html += 						"<div class='col-md-9 col-md-offset-2 col-sm-9 col-sm-offset-2 col-xs-10 col-xs-offset-1 control_padding_btn_box' style='padding-left:2%;'>";
	temp_html += 							"<span id='btn_popup_sueecss' class='button button--moema button--text-upper button--color-lan class_an_06' onclick='close_alert_box();'>确定</span>";
	temp_html += 							"<div style='width:8%;height:10px;float:left;'></div>";
	temp_html += 							"<span id='btn_popup_cencel' class='button button--moema button--text-upper button--color-lan class_an_06' onclick='close_alert_box();'>取消</span>";
	}else{
	temp_html += 						"<div class='col-md-offset-4 col-md-4 col-sm-offset-4 col-sm-4 col-xs-offset-4 col-xs-4 control_padding_btn_box'>";
	temp_html += 							"<span id='btn_popup_sueecss' class='button button--moema button--text-upper button--color-lan class_an_06' onclick='close_alert_box();'>确定</span>";
	}
	temp_html += 						"</div>";
	temp_html += 					"</div>";
	temp_html += 				"</div>";
	temp_html += 			"</div>";
	temp_html += 		"</div>";
	temp_html += 	"</div>";
	temp_html += "</div>";
	$("body").append(temp_html);

	$("#btn_popup_sueecss").on("click", function(){
		if(yescallback){
			yescallback();
		}
	});
	if(yescontent){
		$("#btn_popup_sueecss").html(yescontent);
	}

	$("#btn_popup_cencel").on("click", function(){
		if(nocallback){
			nocallback();
		}
	});
	if(nocontent){
		$("#btn_popup_cencel").html(nocontent);
	}

	if(btntype==1){
		$("#btn_popup_cencel").hide();
	}

	if(popup_content){
		$("#popup_content").css("min-height", min_height);
	}

	$('#myModal').modal();

	if(BrowserSystem=="android"){
		if(typeof(Android)!="undefined"){
			Android.openAlertTrue();
		}
	}
}

function create_alert_box_ajax_error(titlecontent, bodycontent, content_center){
	if(is_show_error_alert_box){
		return;
	}
	
	is_show_error_alert_box = true;
	$("#myModal").remove();
	var temp_html = "";
	temp_html += "<div class='mb_alert_box modal fade' id='myModal' aria-labelledby='myModalLabel' aria-hidden='true'>";
	temp_html += 	"<div id='ta_class'>";
	temp_html += 		"<div id='tb_class'>";
	temp_html += 			"<div class='modal-dialog'>";
	temp_html += 				"<div class='modal-content' id='popup_content'>";
	temp_html += 					"<button id='close_btn' type='button' class='close' data-dismiss='modal' aria-hidden='true'></button>";

	temp_html += 					"<div class='modal-title' id='myModalLabel'>";
	
	temp_html += 					"<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>" + titlecontent + "</p>";
	if(content_center == undefined){
		temp_html += 					"<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 text-center class_bt_11 popup_text'>" + bodycontent + "</p>";
	}else{
		temp_html += 					"<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 " + content_center + " class_bt_11 popup_text popup_text_2'>" + bodycontent + "</p>";
	}
	
	temp_html +=					"</div>";

	temp_html += 					"<div class='col-md-12 text-center'>";
	
	temp_html += 						"<div class='col-md-offset-4 col-md-4 col-sm-offset-4 col-sm-4 col-xs-offset-4 col-xs-4 control_padding_btn_box'>";
	temp_html += 							"<span id='btn_popup_sueecss' class='button button--moema button--text-upper button--color-lan class_an_06' onclick='close_alert_box();'>确定</span>";
	
	temp_html += 						"</div>";
	temp_html += 					"</div>";
	temp_html += 				"</div>";
	temp_html += 			"</div>";
	temp_html += 		"</div>";
	temp_html += 	"</div>";
	temp_html += "</div>";
	$("body").append(temp_html);
	$('#myModal').modal();

	if(BrowserSystem=="android"){
		if(typeof(Android)!="undefined"){
			Android.openAlertTrue();
		}
	}
}


function create_alert_box_shuoming(titlecontent, bodycontent){
	$("#myModal").remove();
	var temp_html = "";
	temp_html += "<div class='mb_alert_box modal fade' id='myModal' aria-labelledby='myModalLabel' aria-hidden='true'>";
	temp_html += 	"<div id='ta_class'>";
	temp_html += 		"<div id='tb_class'>";
	temp_html += 			"<div class='modal-dialog'>";
	temp_html += 				"<div class='modal-content' id='popup_content'>";
	temp_html += 					"<button id='close_btn' type='button' class='close' data-dismiss='modal' aria-hidden='true'></button>";

	temp_html += 					"<div class='modal-title' id='myModalLabel'>";
	
	temp_html += 					"<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>" + titlecontent + "</p>";
	
	temp_html += 					bodycontent;
	
	
	temp_html +=					"</div>";

	temp_html += 					"<div class='col-md-12 text-center'>";
	
	temp_html += 						"<div class='col-md-offset-4 col-md-4 col-sm-offset-4 col-sm-4 col-xs-offset-4 col-xs-4 control_padding_btn_box'>";
	temp_html += 							"<span id='btn_popup_sueecss' class='button button--moema button--text-upper button--color-lan class_an_06' onclick='close_alert_box();'>确定</span>";
	
	temp_html += 						"</div>";
	temp_html += 					"</div>";
	temp_html += 				"</div>";
	temp_html += 			"</div>";
	temp_html += 		"</div>";
	temp_html += 	"</div>";
	temp_html += "</div>";
	$("body").append(temp_html);
	$('#myModal').modal();

	if(BrowserSystem=="android"){
		if(typeof(Android)!="undefined"){
			Android.openAlertTrue();
		}
	}
}

//生成提示框
function create_alert_b_box(){
    // alert(1);
    $("#myModal").remove();
    var temp_html = "";
    temp_html += "<div class='mb_alert_box modal fade' id='myModal' aria-labelledby='myModalLabel' aria-hidden='true'>";
    temp_html +=    "<div id='ta_class'>";
    temp_html +=        "<div id='tb_class'>";
    temp_html +=            "<div class='modal-dialog'>";
    temp_html +=                "<div class='modal-content' id='popup_content'>";
    temp_html +=                    "<button id='close_btn' type='button' class='close' data-dismiss='modal' aria-hidden='true'></button>";

    temp_html +=                    "<div class='modal-title' id='myModalLabel'>";
    // temp_html +=                     "<img src='../images/evaluate/ic_kuang.png' class='img-responsive'>";
    temp_html +=                    "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
    temp_html +=                    "<p class='lead col-md-12 col-sm-12 col-xs-12 popup_text popup_text_2'>导出全部数据所需时间较长,为节约您的宝贵时间,您可以留下邮箱地址,数据导出完毕后,我们将向你发送快捷下载链接。</p>";
    temp_html +=                    "<p class='lead col-md-12 col-sm-12 col-xs-12 text-center'><input type='email' id='emailbox' placeholder='输入邮箱地址'></p>";
    temp_html +=                    "</div>";

    temp_html +=                    "<div class='col-md-12 text-center'>";
    temp_html +=                        "<div class='col-md-9 col-md-offset-2 col-sm-8 col-sm-offset-3 col-xs-8 col-xs-offset-3' style='padding-left:2%;'>";
    temp_html +=                            "<span id='btn_popup_sueecss' class='button button--moema button--text-upper button--color-lan class_an_06' onclick='beijing_export_excel();'>确定</span>";
    temp_html +=                            "<div style='width:8%;height:10px;float:left;'></div>";
    temp_html +=                            "<span id='btn_popup_cencel' class='button button--moema button--text-upper button--color-lan class_an_06' onclick='close_alert_box();'>取消</span>";
    temp_html +=                        "</div>";
    temp_html +=                    "</div>";
    temp_html +=                "</div>";
    temp_html +=            "</div>";
    temp_html +=        "</div>";
    temp_html +=    "</div>";
    temp_html += "</div>";
    $("body").append(temp_html);
    $('#myModal').modal();
    scoreCheck = false;
    proveCheck = false;
    
}

//关闭弹出框
function close_alert_box(){
	$('#myModal').modal('hide');
}


//获取园所信息
function getSchoolInfo(school_id, user_type){
	if(!user_type){
		var school_id        = localstorageGet("user_info")['school_id'];
		var user_type        = localstorageGet("user_info")['user_type'];
	}else{
		$(".edt_input").prop("disabled",true);
		$(".edt_radio").prop("disabled",true);
		$(".edt_number").prop("disabled",true);
		$(".td_edt_input").prop("disabled",true);
		$("#btn_header_popup_sueecss").hide();
		$("#btn_header_popup_cencel").html("关闭");
	}
	
	var info_type;
	if(user_type=="1"){
		info_type = 1;
	}else{
		info_type = 2;
	}
	

	$.ajax({
		url       : api_prototype_get_school_info,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id         : school_id,
			info_type         : info_type
			},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
    		var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		var result_arr = (jsondata.list[1][0]);
	    		$(".ei_1").html(result_arr.info_1);
	    		$(".ei_0").val(result_arr.info_2);
	    		$(".ei_2").val(result_arr.info_3);
	    		$(".ei_3").html(result_arr.info_4);
	    		if(result_arr.info_5=="城乡结合部"){
	    			$(".ei_4").val("城乡结合区");
	    		}else{
	    			$(".ei_4").val(result_arr.info_5);
	    		}
	    		
	    		$(".ei_5").val(result_arr.info_6);
	    		$(".ei_6").val(result_arr.info_7);
	    		$(".ei_7").val(result_arr.info_8);
	    		$(".ei_8").val(result_arr.info_9);
	    		$(".ei_9").val(result_arr.info_10);
	    		if(result_arr.info_11 == "是"){
	    			$(".edt_radio[name='er_group_0']").eq(0).prop("checked",true);
	    		}else{
	    			$(".edt_radio[name='er_group_0']").eq(1).prop("checked",true);
	    		}
	    		if(result_arr.info_12 == "是"){
	    			$(".edt_radio[name='er_group_1']").eq(0).prop("checked",true);
	    		}else{
	    			$(".edt_radio[name='er_group_1']").eq(1).prop("checked",true);
	    		}

	    		var detailinfo = $.parseJSON(jsondata.list[0][0].detailinfo);
	    		$(".en_0").val(detailinfo.info_13);
	    		if(detailinfo.info_13>0){$(".en_0").prev().prop("disabled", false);}
	    		if(detailinfo.info_13>=20){$(".en_0").next().prop("disabled", true);}

	    		$(".td_g1_0").html(detailinfo.info_14);
	    		$(".td_g1_1").val(detailinfo.info_15);
	    		$(".td_g1_2").val(detailinfo.info_16);
	    		$(".td_g1_3").val(detailinfo.info_17);
	    		$(".td_g1_4").val(detailinfo.info_18);
	    		$(".td_g2_0").html(detailinfo.info_19);
	    		$(".td_g2_1").val(detailinfo.info_20);
	    		$(".td_g2_2").val(detailinfo.info_21);
	    		$(".td_g2_3").val(detailinfo.info_22);
	    		$(".td_g2_4").val(detailinfo.info_23);
	    		$(".td_g3_0").html(detailinfo.info_24);
	    		$(".td_g3_1").val(detailinfo.info_25);
	    		$(".td_g3_2").val(detailinfo.info_26);
	    		$(".td_g3_3").val(detailinfo.info_27);
	    		$(".td_g3_4").val(detailinfo.info_28);
	    		$(".td_g3_5").val(detailinfo.info_29);
	    		$(".en_2").val(detailinfo.info_30);
	    		if(detailinfo.info_30>0){$(".en_2").prev().prop("disabled", false);}
	    		if(detailinfo.info_30>=199){$(".en_2").next().prop("disabled", true);}

	    		$(".en_3").val(detailinfo.info_31);
	    		if(detailinfo.info_31>0){$(".en_3").prev().prop("disabled", false);}
	    		if(detailinfo.info_31>=99){$(".en_3").next().prop("disabled", true);}

	    		$(".td_g4_0").val(detailinfo.info_32);
	    		$(".td_g4_1").val(detailinfo.info_33);
	    		$(".td_g4_2").val(detailinfo.info_34);
	    		$(".td_g4_3").val(detailinfo.info_35);
	    		$(".td_g4_4").val(detailinfo.info_36);
	    		$(".td_g7_0").val(detailinfo.info_37);
	    		$(".td_g7_1").val(detailinfo.info_38);
	    		$(".td_g7_2").val(detailinfo.info_39);
	    		$(".td_g7_3").val(detailinfo.info_40);
	    		$(".td_g7_4").val(detailinfo.info_41);
	    		$(".td_g7_5").val(detailinfo.info_42);
	    		$(".td_g6_0").val(detailinfo.info_43);
	    		$(".td_g6_1").val(detailinfo.info_44);
	    		$(".td_g6_2").val(detailinfo.info_45);
	    		$(".en_1").val(detailinfo.info_46);
	    		if(detailinfo.info_46>0){$(".en_1").prev().prop("disabled", false);}
	    		if(detailinfo.info_46>=9999){$(".en_1").next().prop("disabled", true);}

	    		if(detailinfo.info_47 == "是"){
	    			$(".edt_radio[name='er_group_2']").eq(0).prop("checked",true);
	    		}else{
	    			$(".edt_radio[name='er_group_2']").eq(1).prop("checked",true);
	    		}
	    		$(".en_4").val(detailinfo.info_48);
	    		if(detailinfo.info_48>0){$(".en_4").prev().prop("disabled", false);}
	    		if(detailinfo.info_48>=199){$(".en_4").next().prop("disabled", true);}

	    		$(".en_5").val(detailinfo.info_49);
	    		if(detailinfo.info_49>0){$(".en_5").prev().prop("disabled", false);}
	    		if(detailinfo.info_49>=199){$(".en_5").next().prop("disabled", true);}

	    		$(".en_6").val(detailinfo.info_50);
	    		if(detailinfo.info_50>0){$(".en_6").prev().prop("disabled", false);}
	    		if(detailinfo.info_50>=199){$(".en_6").next().prop("disabled", true);}

	    		$(".td_g5_0").val(detailinfo.info_51);
	    		$(".td_g5_1").val(detailinfo.info_52);
	    		$(".td_g5_2").val(detailinfo.info_53);
	    		$(".td_g5_3").val(detailinfo.info_54);
	    		$(".en_7").val(detailinfo.info_55);
	    		if(detailinfo.info_55>0){$(".en_7").prev().prop("disabled", false);}
	    		if(detailinfo.info_55>=99){$(".en_7").next().prop("disabled", true);}

	    		$(".en_8").val(detailinfo.info_56);
	    		if(detailinfo.info_56>0){$(".en_8").prev().prop("disabled", false);}
	    		if(detailinfo.info_56>=20){$(".en_8").next().prop("disabled", true);}

	    		$(".en_9").val(detailinfo.info_57);
	    		if(detailinfo.info_57>0){$(".en_9").prev().prop("disabled", false);}
	    		if(detailinfo.info_57>=3){$(".en_9").next().prop("disabled", true);}

	    		$(".en_10").val(detailinfo.info_58);
	    		if(detailinfo.info_58>0){$(".en_10").prev().prop("disabled", false);}
	    		if(detailinfo.info_58>=20){$(".en_10").next().prop("disabled", true);}
	    		$(".en_11").val(detailinfo.info_59);
	    		if(detailinfo.info_59>0){$(".en_11").prev().prop("disabled", false);}
	    		if(detailinfo.info_59>=20){$(".en_11").next().prop("disabled", true);}
	    		$(".en_12").val(detailinfo.info_60);
	    		if(detailinfo.info_60>0){$(".en_12").prev().prop("disabled", false);}
	    		if(detailinfo.info_60>=20){$(".en_12").next().prop("disabled", true);}
	    		$(".en_13").val(detailinfo.info_61);
	    		if(detailinfo.info_61>0){$(".en_13").prev().prop("disabled", false);}
	    		if(detailinfo.info_61>=9999){$(".en_13").next().prop("disabled", true);}
	    		$(".en_14").val(detailinfo.info_62);
	    		if(detailinfo.info_62>0){$(".en_14").prev().prop("disabled", false);}
	    		if(detailinfo.info_62>=9999){$(".en_14").next().prop("disabled", true);}
	    		$(".en_15").val(detailinfo.info_63);
	    		if(detailinfo.info_63>0){$(".en_15").prev().prop("disabled", false);}
	    		if(detailinfo.info_63>=9999){$(".en_15").next().prop("disabled", true);}

	    		$(".ei_10").val(detailinfo.info_64);
	    		$(".ei_11").val(detailinfo.info_65);
	    		$(".ei_12").val(detailinfo.info_66);
	    		$(".ei_13").val(detailinfo.info_67);
	    		$("#header_popup_content").show();
	    	}else if(error_code==2){
	    		create_alert_box("提示", jsondata.msg, control_popup_close, "", "", "", 1, "320px", "1");
	    		$(".popup_text").addClass('popup_text_2');
	    		
	    		// $(".control_padding_btn_box").css("padding-left", "19%");
	    		
	    		$('#myModal').modal();
	    	}
    	},
    	//请求失败时将调用此方法
    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    		$('#myModal').modal('hide');
    		$(".sch_dim_box").hide();
    		setTimeout(function(){
    			create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
    		},1200);
    	}
	});
}

//修改园所信息
function setSchoolInfo(){
	create_alert_box("提示", "确认修改园所信息吗？", setSchoolInfo_go, "确定", "", "取消", 2, "270px", "text-center");
}
function setSchoolInfo_go(tObj){
	var school_id        = localstorageGet("user_info")['school_id'];
	var user_type        = localstorageGet("user_info")['user_type'];
	var info_type;
	if(user_type=="1"){
		info_type = 1;
	}else{
		info_type = 2;
	}
	// var data_info_1 = $(".ei_1").html();
	var data_info_2 = $(".ei_0").val();
	var data_info_3 = $(".ei_2").val();
	// var data_info_4 = $(".ei_3").html();
	if($(".ei_4").val()=="城乡结合区"){
		var data_info_5 = "城乡结合部";
	}else{
		var data_info_5 = $(".ei_4").val();
	}
	
	var data_info_6 = $(".ei_5").val();
	var data_info_7 = $(".ei_6").val();
	var data_info_8 = $(".ei_7").val();
	var data_info_9 = $(".ei_8").val();
	var data_info_10 = $(".ei_9").val();
	if($(".edt_radio[name='er_group_0']").eq(0).is(":checked")){
		var data_info_11 = "是";
	}else{
		var data_info_11 = "否";
	}
	if($(".edt_radio[name='er_group_1']").eq(0).is(":checked")){
		var data_info_12 = "是";
	}else{
		var data_info_12 = "否";
	}

	var detailinfo = {};
	detailinfo.info_13 = $(".en_0").val();
	detailinfo.info_14 = $(".td_g1_0").html();
	detailinfo.info_15 = $(".td_g1_1").val();
	detailinfo.info_16 = $(".td_g1_2").val();
	detailinfo.info_17 = $(".td_g1_3").val();
	detailinfo.info_18 = $(".td_g1_4").val();
	detailinfo.info_19 = $(".td_g2_0").html();
	detailinfo.info_20 = $(".td_g2_1").val();
	detailinfo.info_21 = $(".td_g2_2").val();
	detailinfo.info_22 = $(".td_g2_3").val();
	detailinfo.info_23 = $(".td_g2_4").val();
	detailinfo.info_24 = $(".td_g3_0").html();
	detailinfo.info_25 = $(".td_g3_1").val();
	detailinfo.info_26 = $(".td_g3_2").val();
	detailinfo.info_27 = $(".td_g3_3").val();
	detailinfo.info_28 = $(".td_g3_4").val();
	detailinfo.info_29 = $(".td_g3_5").val();
	detailinfo.info_30 = $(".en_2").val();
	detailinfo.info_31 = $(".en_3").val();
	detailinfo.info_32 = $(".td_g4_0").val();
	detailinfo.info_33 = $(".td_g4_1").val();
	detailinfo.info_34 = $(".td_g4_2").val();
	detailinfo.info_35 = $(".td_g4_3").val();
	detailinfo.info_36 = $(".td_g4_4").val();
	detailinfo.info_37 = $(".td_g7_0").val();
	detailinfo.info_38 = $(".td_g7_1").val();
	detailinfo.info_39 = $(".td_g7_2").val();
	detailinfo.info_40 = $(".td_g7_3").val();
	detailinfo.info_41 = $(".td_g7_4").val();
	detailinfo.info_42 = $(".td_g7_5").val();
	detailinfo.info_43 = $(".td_g6_0").val();
	detailinfo.info_44 = $(".td_g6_1").val();
	detailinfo.info_45 = $(".td_g6_2").val();
	detailinfo.info_46 = $(".en_1").val();
	if($(".edt_radio[name='er_group_2']").eq(0).is(":checked")){
		detailinfo.info_47 = "是";
	}else{
		detailinfo.info_47 = "否";
	}
	detailinfo.info_48 = $(".en_4").val();
	detailinfo.info_49 = $(".en_5").val();
	detailinfo.info_50 = $(".en_6").val();
	detailinfo.info_51 = $(".td_g5_0").val();
	detailinfo.info_52 = $(".td_g5_1").val();
	detailinfo.info_53 = $(".td_g5_2").val();
	detailinfo.info_54 = $(".td_g5_3").val();
	detailinfo.info_55 = $(".en_7").val();
	detailinfo.info_56 = $(".en_8").val();
	detailinfo.info_57 = $(".en_9").val();
	detailinfo.info_58 = $(".en_10").val();
	detailinfo.info_59 = $(".en_11").val();
	detailinfo.info_60 = $(".en_12").val();
	detailinfo.info_61 = $(".en_13").val();
	detailinfo.info_62 = $(".en_14").val();
	detailinfo.info_63 = $(".en_15").val();
	detailinfo.info_64 = $(".ei_10").val();
	detailinfo.info_65 = $(".ei_11").val();
	detailinfo.info_66 = $(".ei_12").val();
	detailinfo.info_67 = $(".ei_13").val();
	detailinfo = JSON.stringify(detailinfo);
	//console.log(detailinfo)

	$.ajax({
		url       : api_prototype_set_school_info,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id         : school_id,
			info_type         : info_type,
			detailinfo        : detailinfo,
			data_info_2       : data_info_2,
			data_info_3       : data_info_3,
			data_info_5       : data_info_5,
			data_info_6       : data_info_6,
			data_info_7       : data_info_7,
			data_info_8       : data_info_8,
			data_info_9       : data_info_9,
			data_info_10      : data_info_10,
			data_info_11      : data_info_11,
			data_info_12      : data_info_12
			},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
    		var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		var temp_obj = localstorageGet("school_info");
	    		temp_obj.info_2 = data_info_2;
	    		temp_obj.detailinfo[info_type-1] = detailinfo;
	    		localstorageAdd("school_info", temp_obj);
	    		$(".class_bt_01").html(data_info_2);
	    		$(".sch_dim_box").hide();
	    		$("#header_popup_content").hide();
	    		$("body").css("overflow", "auto");
	    		sch_detailinfo = detailinfo;
	    		sch_detailinfo = $.parseJSON(sch_detailinfo);
	    		for(var i=13;i<=67;i++){
	    			if(i!=47){
	    				if(sch_detailinfo["info_" + i] || sch_detailinfo["info_" + i]===0 || sch_detailinfo["info_" + i]==="0"){
	    					sch_detailinfo["info_" + i] = parseFloat(parseFloat(sch_detailinfo["info_" + i]).toFixed(2));
	    				}else{
	    					sch_detailinfo["info_" + i] = "";
	    				}
	    			}
	    		}
	    		$(".blue_font_class").each(function(index, el) {
	    			var re_val = "根据您填写的园所信息表，" + eval($(el).attr("save_fun"))();
	    			$(el).html(re_val);
	    		});
	    	}else if(error_code==2){
	    		create_alert_box("提示", jsondata.msg, control_popup_close, "", "", "", 1, "320px", "1");
	    		$(".popup_text").addClass('popup_text_2');
	    		
	    		// $(".control_padding_btn_box").css("padding-left", "19%");
	    		
	    		$('#myModal').modal();
	    	}
    	},
    	//请求失败时将调用此方法
    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    		$('#myModal').modal('hide');
    		setTimeout(function(){
    			create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
    		},1200);
    	}
	});
}


//获取学校密码
function getPasswordData(school_id, user_type){
	$("body").css("overflow", "hidden");
	$(".pw_dim_box").show();
	resizeCallback();
	
	$.ajax({
		url       : api_prototype_get_school_password,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id         : school_id
			},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
    		var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		var result_arr = (jsondata.list[0]);
	    		var temp_html = "";
	    		temp_html += "<table class='header_pw_table' cellpadding='0' cellspacing='0' border='0'>";
	    		temp_html += "<tr class='header_pw_tr_1'>";
	    		temp_html += 	"<td class='pw_tbale_td_1'></td>";
	    		temp_html += 	"<td class='text-center pw_tbale_td_2'><span class='pw_table_red_1'>原密码</span></td>";
	    		temp_html += 	"<td class='text-center pw_tbale_td_2'><span class='pw_table_red_1'>新密码</span></td>";
	    		temp_html += "</tr>";
	    		for(var i=0;i<result_arr.length;i++){
	    			
	    			temp_html += "<tr class='header_pw_tr_2'>";
	    			temp_html += 	"<td>"+result_arr[i].account+":</td>";
	    			temp_html += 	"<td align='center'><span class='pw_oldP_class'>"+result_arr[i].password+"</span></td>";
	    			temp_html += 	"<td align='center'><input class='pw_newP_class' user_id='"+result_arr[i].id+"' value='' maxlength='7'></td>";
	    			temp_html += "</tr>";
	    		}
	    		
	    		temp_html += "</table>";

	    		$("#header_myModalLabel_pw").html(temp_html);
	    		$("#header_popup_password_content").show();

	    		//限制输入
	    		$(".pw_newP_class").bind("keyup paste change", function (e){
	    			var header_temp_val = $(this).val();
	    			
    				header_temp_val = $(this).val().replace(/[^\w\/]/ig, '');
    				$(this).val(header_temp_val);
	    		})
	    	}else if(error_code==2){
	    		create_alert_box("提示", jsondata.msg, control_popup_close, "", "", "", 1, "320px", "1");
	    		$(".popup_text").addClass('popup_text_2');
	    		
	    		// $(".control_padding_btn_box").css("padding-left", "19%");
	    		
	    		$('#myModal').modal();
	    	}
    	},
    	//请求失败时将调用此方法
    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    		$(".pw_dim_box").hide();
    		$('#myModal').modal('hide');
    		setTimeout(function(){
    			create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
    		},1200);
    	}
	});
}

//获取单独用户密码
function getPasswordDataForUser(user_id){
	$("body").css("overflow", "hidden");
	$(".pw_dim_box").show();
	resizeCallback();
	
	

	$.ajax({
		url       : api_prototype_get_user_password,
		type      : "post",
		dataType  : 'json',
		data      : {
			user_id         : user_id
			},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
    		var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		var result_arr = (jsondata.list[0]);
	    		var temp_html = "";
	    		temp_html += "<table class='header_pw_table' cellpadding='0' cellspacing='0' border='0'>";
	    		temp_html += "<tr class='header_pw_tr_1'>";
	    		temp_html += 	"<td class='pw_tbale_td_1'></td>";
	    		temp_html += 	"<td class='text-center pw_tbale_td_2'><span class='pw_table_red_1'>原密码</span></td>";
	    		temp_html += 	"<td class='text-center pw_tbale_td_2'><span class='pw_table_red_1'>新密码</span></td>";
	    		temp_html += "</tr>";
	    		for(var i=0;i<result_arr.length;i++){
	    			
	    			temp_html += "<tr class='header_pw_tr_2'>";
	    			temp_html += 	"<td>"+result_arr[i].account+":</td>";
	    			temp_html += 	"<td align='center'><span class='pw_oldP_class'>"+result_arr[i].password+"</span></td>";
	    			temp_html += 	"<td align='center'><input class='pw_newP_class' user_id='"+result_arr[i].id+"' value='' maxlength='7'></td>";
	    			temp_html += "</tr>";
	    		}
	    		
	    		temp_html += "</table>";

	    		$("#header_myModalLabel_pw").html(temp_html);
	    		$("#header_popup_password_content").show();

	    		//限制输入
	    		$(".pw_newP_class").bind("keyup paste change", function (e){
	    			var header_temp_val = $(this).val();
	    			
    				header_temp_val = $(this).val().replace(/[^\w\/]/ig, '');
    				$(this).val(header_temp_val);
	    		})
	    	}else if(error_code==2){
	    		create_alert_box("提示", jsondata.msg, control_popup_close, "", "", "", 1, "320px", "1");
	    		$(".popup_text").addClass('popup_text_2');
	    		
	    		// $(".control_padding_btn_box").css("padding-left", "19%");
	    		
	    		$('#myModal').modal();
	    	}
    	},
    	//请求失败时将调用此方法
    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    		$('#myModal').modal('hide');
    		setTimeout(function(){
    			create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
    		},1200);
    	}
	});
}

//根据区号获取用户密码
function getPasswordDataForAreaCode(user_id,area_code){
	$("body").css("overflow", "hidden");
	$(".pw_dim_box").show();
	resizeCallback();
	
	

	$.ajax({
		url       : api_prototype_get_password_for_area_code,
		type      : "post",
		dataType  : 'json',
		data      : {
			user_id   : user_id,
			area_code : area_code
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
    		var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		var result_arr = (jsondata.list[0]);
	    		var temp_html = "";
	    		temp_html += "<table class='header_pw_table' cellpadding='0' cellspacing='0' border='0'>";
	    		temp_html += "<tr class='header_pw_tr_1'>";
	    		temp_html += 	"<td class='pw_tbale_td_1'></td>";
	    		temp_html += 	"<td class='text-center pw_tbale_td_2'><span class='pw_table_red_1'>原密码</span></td>";
	    		temp_html += 	"<td class='text-center pw_tbale_td_2'><span class='pw_table_red_1'>新密码</span></td>";
	    		temp_html += "</tr>";
	    		for(var i=0;i<result_arr.length;i++){
	    			
	    			temp_html += "<tr class='header_pw_tr_2'>";
	    			temp_html += 	"<td>"+result_arr[i].account+":</td>";
	    			temp_html += 	"<td align='center'><span class='pw_oldP_class'>"+result_arr[i].password+"</span></td>";
	    			temp_html += 	"<td align='center'><input class='pw_newP_class' user_id='"+result_arr[i].id+"' value='' maxlength='7'></td>";
	    			temp_html += "</tr>";
	    		}
	    		
	    		temp_html += "</table>";

	    		$("#header_myModalLabel_pw").html(temp_html);
	    		$("#header_popup_password_content").show();

	    		//限制输入
	    		$(".pw_newP_class").bind("keyup paste change", function (e){
	    			var header_temp_val = $(this).val();
	    			
    				header_temp_val = $(this).val().replace(/[^\w\/]/ig, '');
    				$(this).val(header_temp_val);
	    		})
	    	}else if(error_code==2){
	    		create_alert_box("提示", jsondata.msg, control_popup_close, "", "", "", 1, "320px", "1");
	    		$(".popup_text").addClass('popup_text_2');
	    		
	    		// $(".control_padding_btn_box").css("padding-left", "19%");
	    		
	    		$('#myModal').modal();
	    	}
    	},
    	//请求失败时将调用此方法
    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    		$('#myModal').modal('hide');
    		setTimeout(function(){
    			create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
    		},1200);
    	}
	});
}

//修改密码
function setSchoolPassword(){
	create_alert_box("提示", "确认修改密码吗？", setSchoolPassword_go, "确定", "", "取消", 2, "270px", "text-center");
}
function setSchoolPassword_go(tObj){
	var user_id_arr = [];
	var user_password_arr = [];
	
	$(".pw_newP_class").each(function(index, el) {
		if($(el).val()!=""){
			user_id_arr.push($(el).attr("user_id"));
			user_password_arr.push($(el).val());
		}
	});
	
	if(user_password_arr.length==0){
		$(".pw_dim_box").hide();
		$("#header_popup_password_content").hide();
		$("body").css("overflow", "auto");
		return;
	}

	$.ajax({
		url       : api_prototype_set_school_password,
		type      : "post",
		dataType  : 'json',
		data      : {
			user_id_arr       : user_id_arr,
			user_password_arr : user_password_arr
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
    		var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		$(".pw_dim_box").hide();
	    		$("#header_popup_password_content").hide();
	    		$("body").css("overflow", "auto");
	    		$(".btn_search").trigger("click");
	    	}else if(error_code==2){
	    		create_alert_box("提示", jsondata.msg, control_popup_close, "", "", "", 1, "320px", "1");
	    		$(".popup_text").addClass('popup_text_2');
	    		
	    		// $(".control_padding_btn_box").css("padding-left", "19%");
	    		
	    		$('#myModal').modal();
	    	}
    	},
    	//请求失败时将调用此方法
    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    		$('#myModal').modal('hide');
    		setTimeout(function(){
    			create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
    		},1200);
    	}
	});
}

function header_control_pw_popup_close(){
	$(".pw_dim_box").hide();
	$("#header_popup_password_content").hide();
	$("body").css("overflow", "auto");
}



//导出DOC公用方法
function beijing_export_excel(){
    getAssessmentExportExcel_bj();
    close_alert_box();
}

function getAssessmentExportExcel_bj(){
    // console.log(1);
    var schoolId = "";
    $("input[name='assessment']").each(function(index,el){
        if($(this).is(":checked")){
            if(schoolId != ""){
                schoolId += ",";
            }
            schoolId += $(this).val();
        }
    });
    var emailStr = $("#emailbox").val();
    var export_type = 4;//導出類型（1：xls，2：zip，3：xls+zip，4：doc）
    if(dataType){
    	var data_type = dataType;
    }else{
    	var data_type = 1;
    }
    

    if(emailStr == "")
    {
        close_alert_box();
        // alert(1);
        setTimeout(function(){
            create_alert_box("提示","请输入电子邮件",null,"确定",null,"",1, 270);
        }, 500);
        //create_alert_box("提示","请选择输出对应的资料",null,"确定",null,"",1, 270);
        return;
    }
    var search_str = /^[\w\-\.]+@[\w\-\.]+(\.\w+)+$/;
    if(!search_str.test(emailStr)){
    	setTimeout(function(){
    	    create_alert_box("提示","邮箱格式错误",null,"确定",null,"",1, 270);
    	}, 500);
        return false;
    }
    
    //测试直接输出
    var test_type = 1;

    $.ajax({
        url       : api_insert_outdatafiles_list,
        timeout   : 0,
        type      : "post",
        dataType  : 'json',
        data      : {
            school_id       : schoolId,
            data_type       : data_type,
            output_type     : export_type,
            email_address   : emailStr,
            test_type       : test_type
        },
        beforeSend:function(XMLHttpRequest){
            // ajax_beforeSend(XMLHttpRequest);
        },
        //请求成功后的回调函数有两个参数
        success:function(data,textStatus){
        	var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		// setTimeout(function(){
	    		//     create_alert_box("提示","提交成功",null,"确定",null,"",1, 270)
	    		// }, 500);
	    	}else{
	    		setTimeout(function(){
	    		    create_alert_box("提示","该园的评估数据正在导出当中，请稍后查收邮件。",null,"确定",null,"",1, 270)
	    		}, 500);
	    	}
            
        },
        //请求失败时将调用此方法
        error:function(XMLHttpRequest, textStatus, errorThrown) {
            // ajax_timeout(XMLHttpRequest, textStatus, errorThrown);
        }
    });
}

var BrowserSystem = setBrowser();
function setBrowser(){
	var curBrowser = window.navigator.userAgent;
	if(curBrowser.toLowerCase().indexOf("window") != -1){
		curBrowser = "window";
	}else if(curBrowser.toLowerCase().indexOf("ipad") != -1){
		curBrowser = "ios";
	}else if(curBrowser.toLowerCase().indexOf("iphone") != -1){
		curBrowser = "ios";
	}else if(curBrowser.toLowerCase().indexOf("android") != -1){
		curBrowser = "android";
	}else if(curBrowser.toLowerCase().indexOf("linux") != -1){
		curBrowser = "android";
	}
	return curBrowser;
}



function downloadReport(type)
{
	var userInfo = localstorageGet("user_info");
    var temp ='';

    var apiUrl = "";

    var schoolids = "";
    $("input[name='assessment']").each(function(index,el){
        if($(this).is(":checked")){
            if(schoolids != ""){
                schoolids += ",";
            }
            schoolids += $(this).val();
        }
    });

    if(type == "docx")
    {
    	apiUrl = api_download_docx;
    }
    else
    {
    	apiUrl = api_assessment_export_excel;
    	var export_type = 0;
	    if(scoreCheck){
	        export_type = 1;
	        if(proveCheck){
	            export_type = 2;
	        }
	    }else{
	        // console.log(proveCheck);
	        if(proveCheck){
	            export_type = 3;
	        }
	    }
	    if(export_type == 0){
	        close_alert_box();
	        // alert(1);
	        setTimeout(function(){
	            create_alert_box("提示","请选择输出对应的资料",null,"确定",null,"",1, 270)
	        }, 500);
	        //create_alert_box("提示","请选择输出对应的资料",null,"确定",null,"",1, 270);
	        return;
	    }
    }
    temp+='<form method="post" target="_blank" action="'+apiUrl+'" id="down_form">';
    temp+='<table>';
    temp+='     <tbody>';
    temp+='         <tr>';
    temp+='             <td><input name="school_data" type="text" value="'+schoolids+'" class="check_input"></td>';
    temp+='         </tr>';
    temp+='         <tr>';
    temp+='             <td><input name="data_type" type="text" value="'+dataType+'" class="check_input"></td>';
    temp+='         </tr>';

    if(type == "xlsx")
    {
    	temp+='         <tr>';
	    temp+='             <td><input name="export_type" type="text" value="'+export_type+'" class="check_input"></td>';
	    temp+='         </tr>';
	    temp+='         <tr>';
	    temp+='             <td><input name="key_proper" type="text" value="'+properCode+'" class="check_input"></td>';
	    temp+='         </tr>';
	    temp+='         <tr>';
	    temp+='             <td><input name="is_download" type="text" value="1" class="check_input"></td>';
	    temp+='         </tr>';
    }
    temp+='         <tr>';          
    temp+='             <td><input name="" type="submit" value="提交"></td>';
    temp+='         </tr>';
    temp+='     </tbody>';
    temp+='</table>';
    temp+='</form>';
    
    $(".single_down").html(temp);  //动态生成表单到页面

    $("#down_form").submit();
    
    $(".single_down").html("");
}
