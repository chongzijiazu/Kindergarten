var show_sch_info_id_arr = ["1-2-1-1","1-2-2-1","1-2-2-2","1-2-2-3","1-3-1-2","1-3-1-3","1-3-1-4","1-3-1-5","1-3-1-8","1-3-1-9","1-3-1-10","1-3-2-2","1-3-2-4","1-4-1-5","1-5-3-2","1-5-3-4","2-4-2-2","2-4-2-3","2-4-2-5","4-1-1-2","4-1-3-1","4-1-3-2","4-1-3-3","4-1-3-4","4-1-3-5","4-1-3-6","4-1-4-1","4-1-4-2","4-1-4-3","4-1-4-4","4-1-5-2","4-1-6-2","4-1-7-1","4-4-1-1","4-4-2-1"];

var show_sch_info_fun_arr = ["show_fun_7","show_fun_8","show_fun_9","show_fun_10","show_fun_12","show_fun_13","show_fun_14","show_fun_15","show_fun_18","show_fun_19","show_fun_20","show_fun_22","show_fun_24","show_fun_34","show_fun_56","show_fun_58","show_fun_82","show_fun_83","show_fun_85","show_fun_129","show_fun_135","show_fun_136","show_fun_137","show_fun_138","show_fun_139","show_fun_140","show_fun_141","show_fun_142","show_fun_143","show_fun_144","show_fun_146","show_fun_148","show_fun_149","show_fun_163","show_fun_164"];

var return_null_msg = "没有填写相关信息。";

if(localstorageGet("is_goto")==1){//在查看跳转过来
	// var data_type = localstorageGet("data_type");
	if(mb_eva_data_type=="1"){
		var sch_detailinfo = localstorageGet("school_info_check").detailinfo[0].detailinfo;
	}else{
		var sch_detailinfo = localstorageGet("school_info_check").detailinfo[1].detailinfo;
	}
	
}else{
	if(mb_eva_data_type=="1"){
		var sch_detailinfo = localstorageGet("school_info").detailinfo[0];
	}else{
		var sch_detailinfo = localstorageGet("school_info").detailinfo[1];
	}
	
}
//判断是否登录
if(sch_detailinfo==undefined){
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
// console.log(eval(show_sch_info_fun_arr[show_sch_info_fun_arr.length-1])());

function show_fun_7(){
	if(sch_detailinfo['info_19']===""){
		return "在园人数：" + return_null_msg;
	}else{
		return "在园人数：" + (sch_detailinfo['info_19']).toFixed(2);
	}
}

function show_fun_8(){
	if(sch_detailinfo['info_21']==="" || sch_detailinfo['info_16']===""){
		return "小班平均班额：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_16']!="0"){
			return "小班平均班额：" + (sch_detailinfo['info_21'] / sch_detailinfo['info_16']).toFixed(2);
		}else{
			return "小班平均班额：0.00";
		}
	}
}

function show_fun_9(){
	if(sch_detailinfo['info_22']==="" || sch_detailinfo['info_17']===""){
		return "中班平均班额：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_17']!="0"){
			return "中班平均班额：" + (sch_detailinfo['info_22'] / sch_detailinfo['info_17']).toFixed(2);
		}else{
			return "中班平均班额：0.00";
		}
	}
}

function show_fun_10(){
	if(sch_detailinfo['info_23']==="" || sch_detailinfo['info_18']===""){
		return "大班平均班额：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_18']!="0"){
			return "大班平均班额：" + (sch_detailinfo['info_23'] / sch_detailinfo['info_18']).toFixed(2);
		}else{
			return "大班平均班额：0.00";
		}
	}
}

function show_fun_12(){
	if(sch_detailinfo['info_39']===""){
		return "危房面积：" + return_null_msg;
	}else{
		return "危房面积：" + (sch_detailinfo['info_39']).toFixed(2);
	}
}

function show_fun_13(){
	if(sch_detailinfo['info_38']===""){
		return "租借面积：" + return_null_msg;
	}else{
		return "租借面积：" + (sch_detailinfo['info_38']).toFixed(2);
	}
}

function show_fun_14(){
	if(sch_detailinfo['info_43']==="" || sch_detailinfo['info_19']===""){
		return "生均占地面积：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_19']!="0"){
			return "生均占地面积：" + (sch_detailinfo['info_43'] / sch_detailinfo['info_19']).toFixed(2);
		}else{
			return "生均占地面积：0.00";
		}
	}
}

function show_fun_15(){
	if(sch_detailinfo['info_37']==="" || sch_detailinfo['info_19']===""){
		return "生均校舍建筑面积：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_19']!="0"){
			return "生均校舍建筑面积：" + (sch_detailinfo['info_37'] / sch_detailinfo['info_19']).toFixed(2);
		}else{
			return "生均校舍建筑面积：0.00";
		}
	}
}

function show_fun_18(){
	var temp_return = "";
	if(sch_detailinfo['info_40']==="" || sch_detailinfo['info_19']===""){
		temp_return += "生均活动室面积：" + return_null_msg + "<br>";
	}else{
		if(sch_detailinfo['info_19']!="0"){
			temp_return += "生均活动室面积：" + (sch_detailinfo['info_40'] / sch_detailinfo['info_19'] * 0.6).toFixed(2) + "<br>";
		}else{
			temp_return += "生均活动室面积：0.00" + "<br>";
		}
	}
	
	
	if(sch_detailinfo['info_41']===""){
		temp_return += "睡眠室面积：" + return_null_msg + "<br>";
	}else{
		temp_return += "睡眠室面积：" + (sch_detailinfo['info_41']).toFixed(2) + "<br>";
	}
	if(sch_detailinfo['info_47']===""){
		temp_return += "是否寄宿制幼儿园：" + return_null_msg;
	}else{
		temp_return += "是否寄宿制幼儿园：" + (sch_detailinfo['info_47']);
	}
	
	return temp_return;
}

function show_fun_19(){
	if(sch_detailinfo['info_61']===""){
		return "多功能活动室面积：" + return_null_msg;
	}else{
		return "多功能活动室面积：" + (sch_detailinfo['info_61']).toFixed(2);
	}
	
}

function show_fun_20(){
	if(sch_detailinfo['info_42']===""){
		return "卫生保健室面积：" + return_null_msg;
	}else{
		return "卫生保健室面积：" + (sch_detailinfo['info_42'] * 0.6).toFixed(2);
	}
}

function show_fun_22(){
	if(sch_detailinfo['info_44']==="" || sch_detailinfo['info_19']===""){
		return "生均绿化面积：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_19']!="0"){
			return "生均绿化面积：" + (sch_detailinfo['info_44'] / sch_detailinfo['info_19']).toFixed(2);
		}else{
			return "生均绿化面积：0.00";
		}
	}
}

function show_fun_24(){
	if(sch_detailinfo['info_45']==="" || sch_detailinfo['info_19']===""){
		return "生均运动场地面积：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_19']!="0"){
			return "生均运动场地面积：" + (sch_detailinfo['info_45'] / sch_detailinfo['info_19']).toFixed(2);
		}else{
			return "生均运动场地面积：0.00";
		}
	}
}

function show_fun_34(){
	if(sch_detailinfo['info_26']==="" || sch_detailinfo['info_62']===""){
		return "教师人机比：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_26']!="0" && sch_detailinfo['info_62']!="0"){
			return "教师人机比：" + (sch_detailinfo['info_26'] / sch_detailinfo['info_62']).toFixed(2) + "：1";
		}else{
			return "教师人机比：0.00";
		}
	}
}

function show_fun_56(){
	if(sch_detailinfo['info_46']==="" || sch_detailinfo['info_19']===""){
		return "生均图书：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_19']!="0"){
			return "生均图书：" + (sch_detailinfo['info_46'] / sch_detailinfo['info_19']).toFixed(2);
		}else{
			return "生均图书：0.00";
		}
	}
}

function show_fun_58(){
	if(sch_detailinfo['info_63']===""){
		return "教师专业用书数量：" + return_null_msg;
	}else{
		return "教师专业用书数量：" + (sch_detailinfo['info_63']).toFixed(2);
	}
}

function show_fun_82(){
	if(sch_detailinfo['info_64']===""){
		return "计划内预防接种率（%）：" + return_null_msg;
	}else{
		return "计划内预防接种率（%）：" + (sch_detailinfo['info_64']).toFixed(2);
	}
}

function show_fun_83(){
	if(sch_detailinfo['info_65']===""){
		return "传染病年发病率（%）：" + return_null_msg;
	}else{
		return "传染病年发病率（%）：" + (sch_detailinfo['info_65']).toFixed(2);
	}
}

function show_fun_85(){
	if(sch_detailinfo['info_66']===""){
		return "幼儿出勤率（%）：" + return_null_msg;
	}else{
		return "幼儿出勤率（%）：" + (sch_detailinfo['info_66']).toFixed(2);
	}
}

function show_fun_129(){
	var temp_return = "";
	if(sch_detailinfo['info_24']==="" || sch_detailinfo['info_19']===""){
		temp_return += "教职工师幼比：" + return_null_msg + "<br>";
	}else{
		if(sch_detailinfo['info_19']!="0" && sch_detailinfo['info_24']!="0"){
			temp_return += "教职工师幼比：1：" + (sch_detailinfo['info_19'] / sch_detailinfo['info_24']).toFixed(2) + "<br>";
		}else{
			temp_return += "教职工师幼比：0.00" + "<br>";
		}
	}
	
	if(sch_detailinfo['info_47']===""){
		temp_return += "是否寄宿制幼儿园：" + return_null_msg;
	}else{
		temp_return += "是否寄宿制幼儿园：" + sch_detailinfo['info_47'];
	}
	
	return temp_return;
}

function show_fun_135(){
	var temp_return = "";
	if(sch_detailinfo['info_26']==="" || sch_detailinfo['info_14']===""){
		temp_return += "每班教师数：" + return_null_msg + "<br>";
	}else{
		if(sch_detailinfo['info_14']!="0"){
			temp_return += "每班教师数：" + (sch_detailinfo['info_26'] / sch_detailinfo['info_14']).toFixed(2) + "<br>";
		}else{
			temp_return += "每班教师数：0.00" + "<br>";
		}
	}
	
	if(sch_detailinfo['info_47']===""){
		temp_return += "是否寄宿制幼儿园：" + return_null_msg;
	}else{
		temp_return += "是否寄宿制幼儿园：" + sch_detailinfo['info_47'];
	}
	
	return temp_return;
}

function show_fun_136(){
	if(sch_detailinfo['info_32']==="" || sch_detailinfo['info_33']==="" || sch_detailinfo['info_34']==="" || sch_detailinfo['info_26']===""){
		return "大专及以上学历教师比例（%）：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_26']!="0"){
			return "大专及以上学历教师比例（%）：" + ((sch_detailinfo['info_32'] + sch_detailinfo['info_33'] + sch_detailinfo['info_34']) / sch_detailinfo['info_26'] * 100).toFixed(2) + "";
		}else{
			return "大专及以上学历教师比例（%）：0.00";
		}
	}
}

function show_fun_137(){
	if(sch_detailinfo['info_32']==="" || sch_detailinfo['info_33']==="" || sch_detailinfo['info_34']==="" || sch_detailinfo['info_35']==="" || sch_detailinfo['info_26']===""){
		return "高中及以上学历教师比例（%）：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_26']!="0"){
			return "高中及以上学历教师比例（%）：" + ((sch_detailinfo['info_32'] + sch_detailinfo['info_33'] + sch_detailinfo['info_34'] + sch_detailinfo['info_35']) / sch_detailinfo['info_26'] * 100).toFixed(2) + "";
		}else{
			return "高中及以上学历教师比例（%）：0.00";
		}
	}
}

function show_fun_138(){
	if(sch_detailinfo['info_30']==="" || sch_detailinfo['info_26']===""){
		return "学前教育专业毕业的教师比例（%）：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_26']!="0"){
			return "学前教育专业毕业的教师比例（%）：" + (sch_detailinfo['info_30'] / sch_detailinfo['info_26'] * 100).toFixed(2) + "";
		}else{
			return "学前教育专业毕业的教师比例（%）：0.00";
		}
	}
}

function show_fun_139(){
	if(sch_detailinfo['info_48']==="" || sch_detailinfo['info_26']===""){
		return "取得教师资格证的教师比例（%）：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_26']!="0"){
			return "取得教师资格证的教师比例（%）：" + (sch_detailinfo['info_48'] / sch_detailinfo['info_26'] * 100).toFixed(2) + "";
		}else{
			return "取得教师资格证的教师比例（%）：0.00";
		}
	}
}

function show_fun_140(){
	if(sch_detailinfo['info_67']===""){
		return "专任教师年保留率（%）：" + return_null_msg;
	}else{
		return "专任教师年保留率（%）：" + (sch_detailinfo['info_67']).toFixed(2) + "";
	}
}

function show_fun_141(){
	var temp_return = "";
	if(sch_detailinfo['info_28']==="" || sch_detailinfo['info_14']==="" || sch_detailinfo['info_26']===""){
		temp_return += "每班保育员数：" + return_null_msg + "<br>";
		temp_return += "每班教师数：" + return_null_msg + "<br>";
	}else{
		if(sch_detailinfo['info_14']!="0"){
			temp_return += "每班保育员数：" + (sch_detailinfo['info_28'] / sch_detailinfo['info_14']).toFixed(2) + "<br>";
			temp_return += "每班教师数：" + (sch_detailinfo['info_26'] / sch_detailinfo['info_14']).toFixed(2) + "<br>";
		}else{
			temp_return += "每班保育员数：0.00" + "<br>";
			temp_return += "每班教师数：0.00" + "<br>";
		}
	}
	
	if(sch_detailinfo['info_47']===""){
		temp_return += "是否寄宿制幼儿园：" + return_null_msg;
	}else{
		temp_return += "是否寄宿制幼儿园：" + sch_detailinfo['info_47'];
	}
	
	return temp_return;
}

function show_fun_142(){
	var temp_return = "";
	if(sch_detailinfo['info_51']==="" || sch_detailinfo['info_52']==="" || sch_detailinfo['info_28']===""){
		temp_return += "大专及以上学历保育员比例（%）：" + return_null_msg + "<br>";
	}else{
		if(sch_detailinfo['info_28']!="0"){
			temp_return += "大专及以上学历保育员比例（%）：" + ((sch_detailinfo['info_51'] + sch_detailinfo['info_52']) / sch_detailinfo['info_28'] * 100).toFixed(2) + "<br>";
		}else{
			temp_return += "大专及以上学历保育员比例（%）：0.00" + "<br>";
		}
	}
	
	if(sch_detailinfo['info_32']==="" || sch_detailinfo['info_33']==="" || sch_detailinfo['info_34']==="" || sch_detailinfo['info_26']===""){
		temp_return += "大专及以上学历教师比例（%）：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_26']!="0"){
			temp_return += "大专及以上学历教师比例（%）：" + ((sch_detailinfo['info_32'] + sch_detailinfo['info_33'] + sch_detailinfo['info_34']) / sch_detailinfo['info_26'] * 100).toFixed(2) + "";
		}else{
			temp_return += "大专及以上学历教师比例（%）：0.00";
		}
	}
	
	
	return temp_return;
}

function show_fun_143(){
	var temp_return = "";
	if(sch_detailinfo['info_51']==="" || sch_detailinfo['info_52']==="" || sch_detailinfo['info_53']==="" || sch_detailinfo['info_28']===""){
		temp_return += "高中及以上学历保育员比例（%）：" + return_null_msg + "<br>";
	}else{
		if(sch_detailinfo['info_28']!="0"){
			temp_return += "高中及以上学历保育员比例（%）：" + ((sch_detailinfo['info_51'] + sch_detailinfo['info_52'] + sch_detailinfo['info_53']) / sch_detailinfo['info_28'] * 100).toFixed(2) + "" + "<br>";
		}else{
			temp_return += "高中及以上学历保育员比例（%）：0.00" + "<br>";
		}
	}
	
	if(sch_detailinfo['info_32']==="" || sch_detailinfo['info_33']==="" || sch_detailinfo['info_34']==="" || sch_detailinfo['info_35']==="" || sch_detailinfo['info_26']===""){
		temp_return += "高中及以上学历教师比例（%）：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_26']!="0"){
			temp_return += "高中及以上学历教师比例（%）：" + ((sch_detailinfo['info_32'] + sch_detailinfo['info_33'] + sch_detailinfo['info_34'] + sch_detailinfo['info_35']) / sch_detailinfo['info_26'] * 100).toFixed(2) + "";
		}else{
			temp_return += "高中及以上学历教师比例（%）：0.00";
		}
	}
	
	
	return temp_return;
}

function show_fun_144(){
	if(sch_detailinfo['info_55']==="" || sch_detailinfo['info_28']===""){
		return "受过幼儿保育职业培训的保育员比例（%）：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_28']!="0"){
			return "受过幼儿保育职业培训的保育员比例（%）：" + (sch_detailinfo['info_55'] / sch_detailinfo['info_28'] *100).toFixed(2) + "";
		}else{
			return "受过幼儿保育职业培训的保育员比例（%）：0.00";
		}
	}
}

function show_fun_146(){
	var temp_return = "";
	if(sch_detailinfo['info_19']==="" || sch_detailinfo['info_27']===""){
		temp_return += "每名卫生保健人员照料幼儿数：" + return_null_msg + "<br>";
	}else{
		if(sch_detailinfo['info_27']!="0"){
			temp_return += "每名卫生保健人员照料幼儿数：" + (sch_detailinfo['info_19'] / sch_detailinfo['info_27']).toFixed(2) + "" + "<br>";
		}else{
			temp_return += "每名卫生保健人员照料幼儿数：0.00" + "<br>";
		}
	}
	
	if(sch_detailinfo['info_56']===""){
		temp_return += "兼职卫生保健人员数：" + return_null_msg;
	}else{
		temp_return += "兼职卫生保健人员数：" + sch_detailinfo['info_56'].toFixed(2);
	}
	
	return temp_return;
}

function show_fun_148(){
	var temp_return = "";
	if(sch_detailinfo['info_19']==="" || sch_detailinfo['info_58']===""){
		temp_return += "每名炊事员服务幼儿数：" + return_null_msg + "<br>";
	}else{
		if(sch_detailinfo['info_58']!="0"){
			temp_return += "每名炊事员服务幼儿数：" + (sch_detailinfo['info_19'] / sch_detailinfo['info_58']).toFixed(2) + "<br>";
		}else{
			temp_return += "每名炊事员服务幼儿数：0.00";
		}
	}
	
	if(sch_detailinfo['info_57']===""){
		temp_return += "供餐数量（几餐）：" + return_null_msg + "<br>";
	}else{
		temp_return += "供餐数量（几餐）：" + (sch_detailinfo['info_57']).toFixed(2) + "<br>";
	}
	if(sch_detailinfo['info_59']===""){
		temp_return += "兼职炊事员数：" + return_null_msg;
	}else{
		temp_return += "兼职炊事员数：" + sch_detailinfo['info_59'].toFixed(2);
	}
	
	return temp_return;
}

function show_fun_149(){
	var temp_return = "";
	if(sch_detailinfo['info_13']===""){
		temp_return += "安全保卫人员数：" + return_null_msg + "<br>";
	}else{
		temp_return += "安全保卫人员数：" + (sch_detailinfo['info_13']).toFixed(2) + "<br>";
	}
	
	if(sch_detailinfo['info_19']===""){
		temp_return += "在园人数：" + return_null_msg + "<br>";
	}else{
		temp_return += "在园人数：" + (sch_detailinfo['info_19']).toFixed(2) + "<br>";
	}
	if(sch_detailinfo['info_60']===""){
		temp_return += "兼职安保人员数：" + return_null_msg;
	}else{
		temp_return += "兼职安保人员数：" + sch_detailinfo['info_60'].toFixed(2);
	}
	
	return temp_return;
}

function show_fun_163(){
	if(sch_detailinfo['info_49']==="" || sch_detailinfo['info_24']===""){
		return "与幼儿园签订聘用合同或劳动合同的教职工比例（%）：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_24']!="0"){
			return "与幼儿园签订聘用合同或劳动合同的教职工比例（%）：" + (sch_detailinfo['info_49'] / sch_detailinfo['info_24'] * 100).toFixed(2) + "";
		}else{
			return "与幼儿园签订聘用合同或劳动合同的教职工比例（%）：0.00";
		}
	}
}

function show_fun_164(){
	if(sch_detailinfo['info_50']==="" || sch_detailinfo['info_24']===""){
		return "工资不低于当地最低工资标准的教职工比例（%）：" + return_null_msg;
	}else{
		if(sch_detailinfo['info_24']!="0"){
			return "工资不低于当地最低工资标准的教职工比例（%）：" + (sch_detailinfo['info_50'] / sch_detailinfo['info_24'] * 100).toFixed(2) + "";
		}else{
			return "工资不低于当地最低工资标准的教职工比例（%）：0.00";
		}
	}
}