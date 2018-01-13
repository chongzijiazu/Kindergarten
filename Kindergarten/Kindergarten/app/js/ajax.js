//login.html
//获取用户选取的数据
var lock_user_login_btn = 0;
function mb_user_login(){
	if(lock_user_login_btn==0){
		lock_user_login_btn = 1;
	}else{
		return;
	}

	if(BrowserSystem=="android"){
		if(typeof(Android)!="undefined"){
			Android.hide_keyboard();
		}
	}
	if(BrowserSystem=="android"){
		if(typeof(Android)!="undefined"){
			Android.openAlertTrue();
		}
	}

	
	create_alert_box();
	var account  = $("#edt_account").val();
	var password = $("#edt_password").val();
	if(account == "" && password == ""){
		$("#btn_popup_cencel").hide();
		$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
		$("#btn_popup_sueecss").html("确定");
		$("#myModalLabel").css("min-height", "180px");
		$("#popup_content").css("min-height", "270px");

		var temp_html = "";
		temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
		temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 text-center class_bt_11 popup_text popup_text_2'>账号和密码不能为空。</p>";
		$("#myModalLabel").html(temp_html);
		$(".popup_img_btn_box").hide();
		$(".pp_btn_class").css("padding-left", "19%");
		$('#myModal').modal();
		return;
	}
	if(account == "" || password == ""){
		$("#btn_popup_cencel").hide();
		$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
		$("#btn_popup_sueecss").html("确定");
		$("#myModalLabel").css("min-height", "180px");
		$("#popup_content").css("min-height", "270px");

		var temp_html = "";
		temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
		if(account == ""){
			temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 text-center class_bt_11 popup_text popup_text_2'>账号不能为空。</p>";
		}else{
			temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 text-center class_bt_11 popup_text popup_text_2'>密码不能为空。</p>";
		}
		$("#myModalLabel").html(temp_html);
		$(".popup_img_btn_box").hide();
		$(".pp_btn_class").css("padding-left", "19%");
		$('#myModal').modal();
		return;
	}
	$.ajax({
		url       : api_prototype_user_qa_login,
		// url       : "http://192.168.10.170/prototype2/index.php/login/dologin",
		type      : "post",
		dataType  : 'json',
		data      : {
			account  : account,
			password : password
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	// console.log(data);
	    	var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	$(".pp_btn_class").css("padding-left", "2%");
	    	if(error_code==0){//成功
	    		localstorageAdd("user_info", jsondata.list.user_info);
	    		localstorageAdd("school_info", jsondata.list.school_info);
	    		localstorageAdd("login_name_show", account);
	    		//清空由查看进入的本地数据
	    		localstorageRemove("is_goto");
	    		localstorageRemove("school_info_check");
	    		localstorageRemove("sch_end_time");
	    		//保存账号名在下次登录时不用输入账号名
	    		localstorageAdd("login_account", account);
	    		
	    		if(jsondata.list.user_info.user_type=="8" || jsondata.list.user_info.user_type=="9"){//教委和专家
	    			if(BrowserSystem=="window"){
	    				window.location.href = "qa_assessment_check.html";
	    			}else{
	    				$("#btn_popup_cencel").hide();
	    				$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	    				$("#btn_popup_sueecss").html("确定");
	    				$("#myModalLabel").css("min-height", "180px");
	    				$("#popup_content").css("min-height", "270px");

	    				var temp_html = "";
	    				temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
	    				if(jsondata.list.user_info.user_type=='8'){
	    					temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>您的账号是教委账号，请在网站登录进入系统。</p>";
	    				}else{
	    					temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>您的账号是专家账号，请在网站登录进入系统。</p>";
	    				}
	    				$("#myModalLabel").html(temp_html);
	    				$(".popup_img_btn_box").hide();
	    				$(".pp_btn_class").css("padding-left", "19%");
	    				$('#myModal').modal();
	    			}
	    			
	    		}else if(jsondata.list.user_info.user_type=="10"){//客服
	    			if(BrowserSystem=="window"){
	    				window.location.href = "qa_customer_service.html";
	    			}else{
	    				$("#btn_popup_cencel").hide();
	    				$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	    				$("#btn_popup_sueecss").html("确定");
	    				$("#myModalLabel").css("min-height", "180px");
	    				$("#popup_content").css("min-height", "270px");

	    				var temp_html = "";
	    				temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
	    				temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>您的账号是客服账号，请在网站登录进入系统。</p>";
	    				$("#myModalLabel").html(temp_html);
	    				$(".popup_img_btn_box").hide();
	    				$(".pp_btn_class").css("padding-left", "19%");
	    				$('#myModal').modal();
	    			}
	    		}else if(jsondata.list.user_info.user_type=="11"){//此账号没有功能
	    			/*$("#btn_popup_cencel").hide();
	    			$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	    			$("#btn_popup_sueecss").html("确定");
	    			$("#myModalLabel").css("min-height", "180px");
	    			$("#popup_content").css("min-height", "270px");

	    			var temp_html = "";
	    			temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
	    			temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 text-center class_bt_11 popup_text_3'>还没有开发此账号功能</p>";
	    			$("#myModalLabel").html(temp_html);
	    			$(".popup_img_btn_box").hide();
	    			$(".pp_btn_class").css("padding-left", "19%");
	    			$('#myModal').modal();*/

	    			if(BrowserSystem=="window"){
	    				window.location.href = "qa_beijing.html";
	    			}else{
	    				$("#btn_popup_cencel").hide();
	    				$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	    				$("#btn_popup_sueecss").html("确定");
	    				$("#myModalLabel").css("min-height", "180px");
	    				$("#popup_content").css("min-height", "270px");

	    				var temp_html = "";
	    				temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
	    				temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>您的账号是管理员账号，请在网站登录进入系统。</p>";
	    				$("#myModalLabel").html(temp_html);
	    				$(".popup_img_btn_box").hide();
	    				$(".pp_btn_class").css("padding-left", "19%");
	    				$('#myModal').modal();
	    			}
	    		}else if(jsondata.list.user_info.user_type=="12"){//超级管理员
	    			if(BrowserSystem=="window"){
	    				window.location.href = "qa_superadmin.html";
	    			}else{
	    				$("#btn_popup_cencel").hide();
	    				$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	    				$("#btn_popup_sueecss").html("确定");
	    				$("#myModalLabel").css("min-height", "180px");
	    				$("#popup_content").css("min-height", "270px");

	    				var temp_html = "";
	    				temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
	    				temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>您的账号是管理员账号，请在网站登录进入系统。</p>";
	    				$("#myModalLabel").html(temp_html);
	    				$(".popup_img_btn_box").hide();
	    				$(".pp_btn_class").css("padding-left", "19%");
	    				$('#myModal').modal();
	    			}
	    		}else{
	    			// $("#myModalLabel").css("min-height", "300px");
	    			$("#popup_content").css("min-height", "");
	    			mb_user_get_evaprogress();
	    		}
	    		
	    	}else if(error_code==1 || error_code==2){
	    		$("#btn_popup_cencel").hide();
	    		$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	    		$("#btn_popup_sueecss").html("确定");
	    		$("#myModalLabel").css("min-height", "180px");
	    		$("#popup_content").css("min-height", "270px");
	    		$(".popup_img_btn_box").hide();

	    		var temp_html = "";
	    		temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
	    		temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 text-center class_bt_11 popup_text popup_text_2'>"+LocalLanguage("ch")['007']+"</p>";
	    		$("#myModalLabel").html(temp_html);
	    		$(".pp_btn_class").css("padding-left", "19%");
	    		$('#myModal').modal();
	    	}else if(error_code==4){
	    		alert(jsondata.msg);
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

//获取用户进度
function mb_user_get_evaprogress(){
	if(localstorageGet("is_goto")==1){
		var school_id = localstorageGet("school_info_check")['id'];
		var data_type = localstorageGet("data_type");
		var user_type = 1;
		if(data_type=='2'){
			var user_type = 3;
		}else if(data_type=='3'){
			var user_type = 5;
		}else if(data_type=='4'){
			var user_type = 6;
		}else if(data_type=='5'){
			var user_type = 7;
		}
	}else{
		var school_id = localstorageGet("user_info")['school_id'];
		var user_type = localstorageGet("user_info")['user_type'];
	}
	
	$.ajax({
		url       : api_prototype_user_qa_get_evaprogress,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id  : school_id,
			user_type  : user_type
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	console.log(data);
	    	var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		// create_alert_box();

	    		localstorageAdd("sch_start_time", jsondata.list.start_time);
	    		localstorageAdd("sch_end_time", jsondata.list.end_time);
	    		localstorageAdd("sch_eva_progress", jsondata.list.eva_progress);
	    		$("#btn_popup_cencel").attr("onclick", "control_popup_close();");
	    		$("#btn_popup_sueecss").html("下一步");
	    		if(localstorageGet("is_goto")==1){
	    			check_time_out_2();
	    			check_time_obj = setInterval(check_time_out_2,1000);
	    			$(".class_bt_02").html(jsondata.list.start_time);
	    			return;
	    		}
	    		var temp_html = "";
	    		temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>温馨提示</p>";
	    		temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>"+LocalLanguage("ch")['001']+"<img src='../images/login/btn_shiping_s1.png' width='35' style='margin-left:0.5em;margin-right:0.5em;'>"+LocalLanguage("ch")['002']+"</p>";
	    		$("#myModalLabel").html(temp_html);
	    		$(".popup_img_btn_box").show();
	    		$("#btn_popup_cencel").show();
	    		if((user_type=='5' || user_type=='6' || user_type=='7')){
	    			if(data.list.have_supervisor_data=="0"){//督评没开始
	    				$("#btn_popup_sueecss").attr("onclick", "rewite_popup_div(4);");
	    				$('#myModal').modal();
	    			}else if(data.list.have_supervisor_data=="1"){//督评正在进行
	    				if(data.list.eva_progress=='2'){
	    					var temp_html = "";
	    					temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
	    					temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>"+LocalLanguage("ch")['012']+"</p>";
	    					$("#myModalLabel").html(temp_html);
	    					$("#btn_popup_sueecss").html("确定");
	    					$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	    					$(".popup_img_btn_box").hide();
	    					$("#btn_popup_cencel").hide();
	    					$(".pp_btn_class").css("padding-left", "19%");
	    					$('#myModal').modal();
	    				}else{
	    					$("#btn_popup_sueecss").attr("onclick", "rewite_popup_div(5);");
	    					$('#myModal').modal();
	    				}
	    				
	    			}else if(data.list.have_supervisor_data=="2"){//督评已经完成
	    				if(data.list.eva_progress=='1'){
	    					if(data.list.time_out==1){
	    						$("#btn_popup_sueecss").html("确定");
	    						$(".popup_img_btn_box").hide();
	    						$("#btn_popup_cencel").hide();
	    						
	    						$(".pp_btn_class").css("padding-left", "19%");
	    						$("#myModalLabel").css("min-height", "180px");
	    						$("#popup_content").css("min-height", "290px");

	    						var temp_html = "";
	    						temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
	    						temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>"+LocalLanguage("ch")['008']+"</p>";
	    						$("#myModalLabel").html(temp_html);
	    						$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	    						$('#myModal').modal();
	    					}else{
	    						control_goto_category();
	    					}
	    				}else if(data.list.eva_progress=='2'){
	    					var temp_html = "";
	    					temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
	    					temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>"+LocalLanguage("ch")['012']+"</p>";
	    					$("#myModalLabel").html(temp_html);
	    					$("#btn_popup_sueecss").html("确定");
	    					$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	    					$(".popup_img_btn_box").hide();
	    					$("#btn_popup_cencel").hide();
	    					$(".pp_btn_class").css("padding-left", "19%");
	    					$('#myModal').modal();
	    				}else{
	    					$("#btn_popup_sueecss").attr("onclick", "rewite_popup_div(1);");
	    					$('#myModal').modal();
	    				}
	    			}
	    			
	    		}else{
	    			if(data.list.time_out==1){//超过评估时间
	    				// $("#btn_popup_sueecss").attr("onclick", "rewite_popup_div(3);");
	    				$("#btn_popup_sueecss").html("确定");
	    				$(".popup_img_btn_box").hide();
	    				$("#btn_popup_cencel").hide();
	    				
	    				$(".pp_btn_class").css("padding-left", "19%");
	    				$("#myModalLabel").css("min-height", "180px");
	    				$("#popup_content").css("min-height", "290px");

	    				var temp_html = "";
	    				temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
	    				temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>"+LocalLanguage("ch")['008']+"</p>";
	    				$("#myModalLabel").html(temp_html);
	    				$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	    				$('#myModal').modal();
	    			}else if(data.list.eva_progress==0){//如果是第一次登录
	    				$("#btn_popup_sueecss").attr("onclick", "rewite_popup_div(1);");
	    				$('#myModal').modal();
	    			}else if(data.list.eva_progress==2){//如果是已经提交
	    				if(user_type==3){
	    					control_goto_category();
	    				}else{
	    					// $("#btn_popup_sueecss").attr("onclick", "rewite_popup_div(2);");
	    					$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	    					$(".popup_img_btn_box").hide();
	    					$("#btn_popup_sueecss").html("确定");
	    					$("#btn_popup_cencel").hide();
	    					
	    					$(".pp_btn_class").css("padding-left", "19%");

	    					var temp_html = "";
	    					temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
	    					if(user_type=='1' || user_type=='2' || user_type=='5' || user_type=='6' || user_type=='7'){
	    						$("#myModalLabel").css("min-height", "180px");
	    						$("#popup_content").css("min-height", "290px");
	    						temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>"+LocalLanguage("ch")['012']+"</p>";
	    					}else{
	    						$("#myModalLabel").css("min-height", "180px");
	    						$("#popup_content").css("min-height", "270px");
	    						temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 text-center class_bt_11 popup_text popup_text_2'>"+LocalLanguage("ch")['006']+"</p>";
	    					}
	    					
	    					$("#myModalLabel").html(temp_html);
	    					$('#myModal').modal();
	    				}
	    				
	    			}else{
	    				control_goto_category();
	    			}
	    		}
	    		
	    		
	    	}else if(error_code==4){
	    		alert(jsondata.msg);
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

function rewite_popup_div(check_type){
	var user_type = localstorageGet("user_info")['user_type'];
	if(check_type==1){//第一次登录
		$(".popup_img_btn_box").hide();
		var temp_html = "";
		temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>注意事项</p>";
		if(user_type=="1"){//学园长开始
			temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>"+LocalLanguage("ch")['003']+"</p>";
			temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text_1'>"+LocalLanguage("ch")['003_1']+"</p>";
			$("#myModalLabel").html(temp_html);
			$("#btn_popup_sueecss").html("确定开始");
		}else if(user_type=="3"){//督学长开始
			// $("#popup_content").css("min-height", "450px");
			temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>"+LocalLanguage("ch")['004']+"</p>"
			temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text_1'>"+LocalLanguage("ch")['004_1']+"</p>"
			$("#myModalLabel").html(temp_html);
			$("#btn_popup_sueecss").html("确定开始");
		}else if(user_type=="5" || user_type=="6" || user_type=="7"){//复评类开始
			temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>"+LocalLanguage("ch")['005']+"</p>"
			temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text_1'>"+LocalLanguage("ch")['005_1']+"</p>"
			$("#myModalLabel").html(temp_html);
			$("#btn_popup_sueecss").html("确定开始");
		}else if(user_type=="2"){//提示需要学园长开始
			$("#btn_popup_cencel").hide();
			$("#btn_popup_sueecss").html("确定");
			$(".popup_img_btn_box").hide();
			$(".pp_btn_class").css("padding-left", "19%");
			$("#popup_content").css("min-height", "270px");
			$("#myModalLabel").css("min-height", "180px");

			temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text popup_text_2'>"+LocalLanguage("ch")['009']+"</p>";
			$("#myModalLabel").html(temp_html);
		}else if(user_type=="4"){//提示需要督学长开始
			$("#btn_popup_cencel").hide();
			$("#btn_popup_sueecss").html("确定");
			$(".popup_img_btn_box").hide();
			$(".pp_btn_class").css("padding-left", "19%");
			$("#popup_content").css("min-height", "270px");
			$("#myModalLabel").css("min-height", "180px");

			temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text popup_text_2'>"+LocalLanguage("ch")['010']+"</p>";
			$("#myModalLabel").html(temp_html);
		}
	}else if(check_type==2){//已提交
		$("#btn_popup_sueecss").html("确定");
		$(".popup_img_btn_box").hide();

		var temp_html = "";
		temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
		temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text popup_text_2'>"+LocalLanguage("ch")['006']+"</p>";
		$("#myModalLabel").html(temp_html);
	}else if(check_type==3){//已超时
		$("#btn_popup_sueecss").html("确定");
		$(".popup_img_btn_box").hide();

		var temp_html = "";
		temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
		temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 class_bt_11 popup_text'>"+LocalLanguage("ch")['008']+"</p>";
		$("#myModalLabel").html(temp_html);
	}else if(check_type==4){//没有督评评估
		$("#btn_popup_cencel").hide();
		
		$("#btn_popup_sueecss").html("确定");
		$(".popup_img_btn_box").hide();
		$(".pp_btn_class").css("padding-left", "19%");
		$("#popup_content").css("min-height", "270px");
		$("#myModalLabel").css("min-height", "180px");

		var temp_html = "";
		temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
		temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 text-center class_bt_11 popup_text popup_text_2'>"+LocalLanguage("ch")['011']+"</p>";
		$("#myModalLabel").html(temp_html);
	}else if(check_type==5){//开始督评评估，但还没有完成
		$("#btn_popup_cencel").hide();
		
		$("#btn_popup_sueecss").html("确定");
		$(".popup_img_btn_box").hide();
		$(".pp_btn_class").css("padding-left", "19%");
		$("#popup_content").css("min-height", "270px");
		$("#myModalLabel").css("min-height", "180px");

		var temp_html = "";
		temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
		temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 text-center class_bt_11 popup_text popup_text_2'>"+LocalLanguage("ch")['013']+"</p>";
		$("#myModalLabel").html(temp_html);
	}
	
	if(check_type==1 && (user_type=="1" || user_type=="3" || user_type=="5" || user_type=="6" || user_type=="7")){
		$("#btn_popup_sueecss").attr("onclick", "control_start_time();");
	}else{
		$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	}
	
}

//点击开始校园评估时间
function control_start_time(){
	var school_id = localstorageGet("user_info")['school_id'];
	var user_type = localstorageGet("user_info")['user_type'];
	$.ajax({
		url       : api_prototype_school_start_time,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id  : school_id,
			user_type  : user_type
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	console.log(data);
	    	var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		localstorageAdd("sch_start_time", jsondata.list.start_time);
	    		localstorageAdd("sch_end_time", jsondata.list.end_time);
	    		localstorageAdd("sch_eva_progress", 1);
	    		window.location.href = "mb_category.html";
	    	}else if(error_code==4){
	    		alert(jsondata.msg);
	    	}
    	},
    	//请求失败时将调用此方法
    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    		$('#myModal').modal('hide');
    		setTimeout(function(){
    			$(".modal-backdrop").remove();
    			create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
    		},1200);
    	}
	});
}
function control_goto_category(){
	window.location.href = "mb_category.html";
}
function control_popup_close(){
	$('#myModal').modal('hide');
	$(".popup_hide_2").find("input").val("");
	$("#pop_msg_show1").html("");
	$("#pop_msg_show2").html("");
	$("#pop_msg_show3").html("");
	$("#pop_msg_show4").html("");
	second_val = 0;//倒数时间归0
	// $("body").css("overflow", "auto");

}
//mb_category.html
//获取所有评估范畴
var check_all_eva_progress = 0;//检查是否完成全部评估

function mb_get_evacontent(){
	if(localstorageGet("is_goto")==1){
		var school_id = localstorageGet("school_info_check")['id'];
		var data_type = localstorageGet("data_type");
		var user_type = 1;
		if(data_type=='2'){
			var user_type = 3;
		}else if(data_type=='3'){
			var user_type = 5;
		}else if(data_type=='4'){
			var user_type = 6;
		}else if(data_type=='5'){
			var user_type = 7;
		}
	}else{
		var school_id = localstorageGet("user_info")['school_id'];
		var user_type = localstorageGet("user_info")['user_type'];
	}
	
	
	var user_id   = localstorageGet("user_info")['id'];
	$.ajax({
		url       : api_prototype_get_evacontent,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id : school_id,
			user_type : user_type
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	// console.log(data);
	    	var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;

	    	var save_lv_arr = [];
	    	if(error_code==0){//成功
	    		var temp_html = "";
	    		var lv1_count = 0;
	    		var lv2_count = 0;
	    		var save_lv1_count_arr = [];
	    		var save_lv2_count_arr = [];
	    		check_all_eva_progress = 0;
	    		var has_no_progress = false;
	    		this_time = jsondata.this_time.replace(/-/g,"/");

	    		var total_index = 0;

	    		check_time_out();
	    		// check_time_obj = setInterval(check_time_out,1000);

	    		temp_html += "<tr><th class='class_th_1'>一级指标</th><th class='class_th_2'>二级指标</th><th>三级指标</th><th class='class_th_2'>评估状态</th><th class='class_th_2'>操作</th></tr>";
	    		$.each(jsondata.list, function(index, val) {
	    			temp_html += "<tr valign='middle'>";
	    			temp_html += "<td id='td_lv1_"+index+"' class='td_lv1 text-center'>"+val.content+"</td>";
	    			
	    			
	    			
	    			lv1_count = 0;
	    			$.each(val.child_level, function(index_lv2, tObj) {
	    				if(index_lv2>0){
	    					temp_html += "<tr valign='middle'>";
	    				}
	    				temp_html += "<td id='td_lv2_"+index+"_"+index_lv2+"' class='td_lv2 text-center'>"+tObj.content+"</td>";
	    				
	    				lv2_count = 0;
	    				$.each(tObj.child_level, function(index_lv3, tObj_1) {
	    					if(index_lv3>0){
	    						temp_html += "<tr>";
	    					}
	    					var type_name = "";
	    					if(tObj_1.lv_progress==0){//其中一条未开始
	    						var temp_class_name = "not_start";
	    						if(user_type!='5' || user_type!='6' || user_type!='7'){
    								//还有没有完成
    								has_no_progress = true;
	    						}
	    						type_name = "未开始";
	    					}else if(tObj_1.lv_progress==1){//其中一条未评完
	    						var temp_class_name = "not_evaluate";console.log(tObj_1)
	    						if(user_type!='5' || user_type!='6' || user_type!='7'){
	    							//还有没有完成
	    							has_no_progress = true;
	    						}
	    						type_name = "未评完";
	    					}else if(tObj_1.lv_progress==2){//其中已评完
	    						var temp_class_name = "already_evaluate";
	    						if(check_all_eva_progress!=1){//有一条没有完成都算没有全部完成
	    							if(localstorageGet("sch_eva_progress")==1){
	    								//全部完成，并且还没有提交
	    								check_all_eva_progress = 1;
	    							}else if(localstorageGet("sch_eva_progress")==2){
	    								//全部完成，并且已经提交
	    								check_all_eva_progress = 2;
	    							}
	    						}
	    						type_name = "已评完";
	    					}
	    					temp_html += "<td class='td_lv3 text-center "+temp_class_name+"'>"+tObj_1.content+"</td>";
	    					temp_html += "<td class='td_lv3 text-center "+temp_class_name+"'>"+type_name+"</td>";
	    					if(localstorageGet("sch_eva_progress")==2){
	    						temp_html += "<td class='td_lv4 text-center "+temp_class_name+"'><div id='go_eva_"+tObj_1.id+"' class='go_eva_btn control_disabled' onclick='go_evaluate_fun(this);' lv1_val='"+val.id+"' lv2_val='"+tObj.id+"' lv3_val='"+tObj_1.id+"' lv_arr_index='"+total_index+"'>进入</div></td>";
	    					}else{
	    						temp_html += "<td class='td_lv4 text-center "+temp_class_name+"'><div id='go_eva_"+tObj_1.id+"' class='go_eva_btn' onclick='go_evaluate_fun(this);' lv1_val='"+val.id+"' lv2_val='"+tObj.id+"' lv3_val='"+tObj_1.id+"' lv_arr_index='"+total_index+"'>进入</div></td>";
	    					}
	    					
	    					save_lv_arr.push([val.id, tObj.id, tObj_1.id]);
	    					temp_html += "</tr>";
	    					lv1_count++;
	    					lv2_count++;

	    					total_index++;
	    				});
	    				if(!save_lv2_count_arr[index]){
	    					save_lv2_count_arr[index] = [];
	    				}
	    				save_lv2_count_arr[index].push(lv2_count);
	    			});
	    			save_lv1_count_arr.push(lv1_count);
	    		});
				//按顺序保存每级lv
	    		localstorageAdd("save_lv_arr", save_lv_arr);
				
	    		
	    		//有其中一条没有完成
	    		if(has_no_progress==true){
	    			check_all_eva_progress = 0;
	    		}
	    		$("#content_table").html(temp_html);
	    		for(var i=0;i<save_lv1_count_arr.length;i++){
	    			$("#td_lv1_"+i).attr("rowspan", save_lv1_count_arr[i]);

	    			for(var j=0;j<save_lv2_count_arr[i].length;j++){
	    				$("#td_lv2_"+i+"_"+j).attr("rowspan", save_lv2_count_arr[i][j]);
	    			}
	    		}

	    		if(localstorageGet("is_goto")==1){//check_all_eva_progress==0
	    			//$("#btn_submit_evadata").attr("disabled", "disabled");
	    			$("#btn_submit_evadata").addClass('disabled');
	    			$("#btn_submit_evadata").attr("onclick", "");
	    		}else{
	    			if(check_all_eva_progress==0){
	    				$("#btn_submit_evadata").removeClass('disabled');
	    				$("#btn_submit_evadata").attr("onclick", "popup_whether_submit();");
	    			}else if(check_all_eva_progress==1){
	    				$("#btn_submit_evadata").removeClass('disabled');
	    				$("#btn_submit_evadata").attr("onclick", "popup_whether_submit();");
	    			}else if(check_all_eva_progress==2){
	    				$("#btn_submit_evadata").addClass('disabled');
	    				$("#btn_submit_evadata").attr("onclick", "");
	    			}
	    		}
	    		
	    	}else if(error_code==4){
	    		alert(jsondata.msg);
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

//检查复评用户是否正在进行评估
function check_user_type_fp_progress(){
	var school_id = localstorageGet("user_info")['school_id'];

	
	$.ajax({
		url       : api_qa_check_user_type_fp_progress,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id  : school_id
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	// console.log(data);
	    	var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(localstorageGet("sch_eva_progress")==2){
	    		if(error_code==0){//成功
	    			$("#btn_edit_evaprogress").attr("onclick", "edit_evaprogress();");
	    		}else if(error_code==1){//复评员正在进行评估
	    			$("#btn_edit_evaprogress").attr("onclick", "show_evaprogress_message();");
	    		}
	    	}
    	},
    	//请求失败时将调用此方法
    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    		// $('#myModal').modal('hide');
    		// setTimeout(function(){
    		// 	create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
    		// },1200);
    	}
	});
}

//提交手机号获取验证码
var count_down_obj;
var second_val = 0;
function get_smscode_fun(){
	var school_id = localstorageGet("user_info")['school_id'];
	var user_type = localstorageGet("user_info")['user_type'];
	var user_id   = localstorageGet("user_info")['id'];
	var phone_number = $("#edt_phone_number").val();

	var check_val = 0;
	if(phone_number==""){
		$("#pop_msg_show3").html("手机号码不能为空");
		check_val = 1;
	}else if(phone_number.length!=11){
		$("#pop_msg_show3").html("手机号码为11位");
		check_val = 1;
	}else{
		if(checkMobile(phone_number)==1){
			check_val = 1;
		}
	}
	if(check_val==1){
		return;
	}

	//限制60秒后才可以重发
	second_val = 60;
	$("#btn_get_smscode").attr("onclick", "").addClass('disabled');
	$("#btn_get_smscode").html("重发 "+second_val+"");
	count_down_obj = setInterval(check_count_down_fun,1000);
	$.ajax({
		url       : api_qa_get_smscode,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id    : school_id,
			user_type    : user_type,
			user_id      : user_id,
			phone_number : phone_number
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	console.log(data);
	    	var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		
	    	}else if(error_code==2){
	    		$("#pop_msg_show4").html(jsondata.msg);
	    	}else if(error_code==4){
	    		alert(jsondata.msg);
	    	}
    	},
    	//请求失败时将调用此方法
    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    		// $('#myModal').modal('hide');
    		// setTimeout(function(){
    		// 	create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
    		// },1200);
			$(".popup_hide_control").hide();
    		$(".popup_hide_5").show();
    		$(".class_bt_11").html(LocalLanguage("ch")['error_msg']);
    		$("#btn_popup_cencel").hide();
    		$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
    		$("#btn_popup_sueecss").html("确定");
    		$("#myModalLabel").css("min-height", "180px");
    		$("#popup_content").css("min-height", "270px");
    		$(".control_btn_padding").css("padding-left", "19%");
    	}
	});
}
//倒计时60秒
function check_count_down_fun(){
	second_val--;
	$("#btn_get_smscode").html("重发 "+second_val+"");
	if(second_val<=0){
		clearInterval(count_down_obj);
		$("#btn_get_smscode").attr("onclick", "get_smscode_fun();").html("点击发送验证码").removeClass('disabled');
	}
}
//提交評估時提交相關人員信息以及驗證碼驗證
//功能是提交数据并关闭系统
function submit_evainfo_fun(){
	var school_id            = localstorageGet("user_info")['school_id'];
	var user_type            = localstorageGet("user_info")['user_type'];
	var user_id              = localstorageGet("user_info")['id'];
	var submit_user          = $("#edt_user_name").val();
	var asubmit_groupmenbers = $("#edt_supervisor_name").val();
	var sms_code             = $("#edt_sms_code").val();
	var phone_number = $("#edt_phone_number").val();

	var check_val = 0;

	if(user_type=='3'){
		//督评成员
		if(asubmit_groupmenbers==""){
			$("#pop_msg_show1").html("姓名不能为空");
			check_val = 1;
		}else{
			$("#pop_msg_show1").html("");
		}
	}
	

	if(submit_user==""){
		$("#pop_msg_show2").html("姓名不能为空");
		check_val = 1;
	}else{
		$("#pop_msg_show2").html("");
	}

	if(phone_number==""){
		$("#pop_msg_show3").html("手机号码不能为空");
		check_val = 1;
	}else{
		if(checkMobile(phone_number)==1){
			check_val = 1;
		}
		// $("#pop_msg_show3").html("");
	}

	if(sms_code==""){
		$("#pop_msg_show4").html("短信验证码不能为空");
		check_val = 1;
	}else{
		$("#pop_msg_show4").html("");
	}
	
	if(user_type!='5' && user_type!='6' && user_type!='7'){
		if(check_all_eva_progress!=1){
			check_val = 1;
		}
	}
	if(check_val==1){
		return;
	}

	$.ajax({
		url       : api_qa_submit_evainfo,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id            : school_id,
			user_type            : user_type,
			user_id              : user_id,
			submit_user          : submit_user,
			asubmit_groupmenbers : asubmit_groupmenbers,
			phone_number         : phone_number,
			sms_code             : sms_code
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	console.log(data);
	    	var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		submit_evadata_fun();
	    	}else if(error_code==2){//超时
	    		$("#pop_msg_show4").html(jsondata.msg);
	    	}else if(error_code==3){//填写的验证码不正确
	    		$("#pop_msg_show4").html(jsondata.msg);
	    	}else if(error_code==4){//输入的手机号不是接收验证码的手机号
	    		$("#pop_msg_show4").html(jsondata.msg);
	    		// alert(jsondata.msg);
	    	}else if(error_code==5){//输入的手机号不是接收验证码的手机号
	    		create_alert_box("提示", "评估数据已经提交了，不能继续修改数据。", "header_logout", "", "", "", 1, "320px")
	    		$(".popup_text").addClass('popup_text_2').removeClass('text-center');
	    		$(".popup_hide_1").show();
	    		$(".popup_hide_2,.popup_hide_3,.popup_hide_4").hide();
	    		
	    		$("#btn_popup_sueecss").attr("onclick", "header_logout();").css("margin-left", "15%").html("确定");
	    		$("#close_btn").attr("onclick", "header_logout();")
	    		$("#btn_popup_cencel").hide();
	    		$('#myModal').modal();

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
	    	}
    	},
    	//请求失败时将调用此方法
    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    		$(".popup_hide_control").hide();
    		$(".popup_hide_5").show();
    		$(".class_bt_11").html(LocalLanguage("ch")['error_msg']);
    		$("#btn_popup_cencel").hide();
    		$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
    		$("#btn_popup_sueecss").html("确定");
    		$("#myModalLabel").css("min-height", "180px");
    		$("#popup_content").css("min-height", "270px");
    		$(".control_btn_padding").css("padding-left", "19%");
    		// alert('网络连接失败，请检查后重试');
    	}
	});
}

//提交手机号获取验证码
function submit_evadata_fun(){
	var school_id = localstorageGet("user_info")['school_id'];
	var user_type = localstorageGet("user_info")['user_type'];
	var user_id   = localstorageGet("user_info")['id'];

	$.ajax({
		url       : api_qa_submit_evadata,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id  : school_id,
			user_type  : user_type,
			user_id    : user_id
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	console.log(data);
	    	var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		$(".popup_text").html("成功提交！").addClass('text-center');
	    		$("#popup_content").css("min-height", "270px");
	    		$("#myModalLabel").css("min-height", "180px");

	    		$(".popup_hide_control").hide();
	    		$(".popup_hide_1").show();
	    		
	    		$("#btn_popup_sueecss").attr("onclick", "header_logout();").css("margin-left", "28.5%").html("确定");
	    		
	    		$("#btn_popup_cencel").hide();

	    		//提交完成后清空本地数据
	    		// if(user_type=='1' || user_type=='2' || user_type=='4'){
	    			
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

	    			$("#close_btn").attr("onclick", "header_logout();");
	    		// }
	    		
	    	}else if(error_code==4){
	    		alert(jsondata.msg);
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

//提示复评员正在进行评估暂不能修改
function show_evaprogress_message(){
	
	$(".popup_hide_control").hide();
	$(".popup_hide_4").show();
	$("#btn_popup_sueecss").attr("onclick", "control_popup_close();");
	$("#btn_popup_sueecss").html("确定");
	$("#btn_popup_cencel").attr("onclick", "control_popup_close();");
	$("#myModal").modal();
}

//询问督学长是否重置
function edit_evaprogress(){
	// var temp_html = "";
	// temp_html += "<p class='col-md-12 col-sm-12 col-xs-12 text-center class_bt_13'>提示</p>";
	// temp_html += "<p class='lead col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1 popup_text popup_text_2'>您已提交过数据，是否确认需要修改并且再次提交数据？</p>";
	// $("#myModalLabel").html(temp_html);

	$("#myModalLabel").html(save_html_for_modal);
	$(".popup_hide_control").hide();
	$(".popup_hide_3").show();
	$("#btn_popup_sueecss").attr("onclick", "edit_evaprogress_go();");
	$("#btn_popup_sueecss").html("确定修改");
	$("#btn_popup_cencel").attr("onclick", "control_popup_close();");
	$("#myModal").modal();
	// edit_evaprogress_go();
}
//督学长重置
function edit_evaprogress_go(){
	var school_id = localstorageGet("user_info")['school_id'];
	var user_type = localstorageGet("user_info")['user_type'];
	$.ajax({
		url       : api_qa_edit_evaprogress,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id  : school_id,
			user_type  : user_type
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	console.log(data);
	    	$("#myModal").modal('hide');
	    	var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		$("#btn_edit_evaprogress").addClass('disabled').attr("onclick", "");
	    		$("#btn_submit_evadata").removeClass('disabled');
	    		$("#btn_submit_evadata").attr("onclick", "popup_whether_submit();");
	    		$(".control_disabled").attr("onclick", "go_evaluate_fun(this);").addClass('go_eva_btn');
	    		localstorageAdd("sch_eva_progress", 1);
	    		check_all_eva_progress = 1;//还没有提交
	    	}else if(error_code==4){
	    		alert(jsondata.msg);
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

//mb_evaluate.html
var mb_level_1 = localstorageGet("ass_level1_autoid") ? localstorageGet("ass_level1_autoid") : 0;
var mb_level_2 = localstorageGet("ass_level2_autoid") ? localstorageGet("ass_level2_autoid") : 0;
var mb_level_3 = localstorageGet("ass_level3_autoid") ? localstorageGet("ass_level3_autoid") : 0;

var check_drag = false;//是否正在拖放
var qa_user_attachment_id = 0;//记录拖放的是哪一个图片

var mb_eva_data_type;
if(localstorageGet("is_goto")==1){
	var data_type = localstorageGet("data_type");
	var user_type = 1;
	if(data_type=='2'){
		user_type = 3;
	}else if(data_type=='3'){
		user_type = 5;
	}else if(data_type=='4'){
		user_type = 6;
	}else if(data_type=='5'){
		user_type = 7;
	}
	mb_eva_data_type = data_type;
}else{
	var user_type = localstorageGet("user_info") ? localstorageGet("user_info")['user_type'] : 1;//记录选择查看的用户类型，默认选择自己
	if(user_type=='1' || user_type=='2'){
		mb_eva_data_type = 1;
	}else if(user_type=='3' || user_type=='4'){
		mb_eva_data_type = 2;
	}else if(user_type=='5'){
		mb_eva_data_type = 3;
	}else if(user_type=='6'){
		mb_eva_data_type = 4;
	}else if(user_type=='7'){
		mb_eva_data_type = 5;
	}
}




//选取不同用户类型的值
function swap_type(tObj){
	mb_eva_data_type = $(tObj).val();
	//重置上传证明文件按钮
	//qb_submit_stand表progress为1，正在进行时
	if(localstorageGet("sch_eva_progress")==1){
		$(".s_pic").attr("class","s_pic sp2 glyphicon class_img_13");
		$(".s_pic").attr("onclick", "setSend_pic(this);");
	}
	
	$(".rds").prop("checked", false);

	var user_type = localstorageGet("user_info")['user_type'];
	var temp_val = 0;
	if(user_type==1 || user_type==2){
		temp_val = 1;
	}else if(user_type==3 || user_type==4){
		temp_val = 2;
	}else if(user_type==5){
		temp_val = 3;
	}else if(user_type==6){
		temp_val = 4;
	}else if(user_type==7){
		temp_val = 5;
	}
	if(mb_eva_data_type!=temp_val || localstorageGet("sch_eva_progress")!=1 || localstorageGet("is_goto")==1){// || (mb_eva_data_type!='1' && mb_eva_data_type!='2')
		$(".rds").prop("disabled", true);
		$(".is_input").prop("disabled", true);
		$(".ta_content").prop("disabled", true).attr("placeholder", "");
	}else{
		$(".rds").prop("disabled", false);
		$(".is_input").prop("disabled", false);

		//如果是选择了复评
		if(mb_eva_data_type==3 || mb_eva_data_type==4 || mb_eva_data_type==5){
			$(".ta_content").prop("disabled", true).attr("placeholder", "");
		}else{
			$(".ta_content").prop("disabled", false).attr("placeholder", "输入文字记录");
		}
		
	}
	get_options();
	
	//切换园所信息
	if(localstorageGet("is_goto")==1){//在查看跳转过来
		// var data_type = localstorageGet("data_type");
		if(mb_eva_data_type=="1"){
			sch_detailinfo = localstorageGet("school_info_check").detailinfo[0].detailinfo;
		}else{
			sch_detailinfo = localstorageGet("school_info_check").detailinfo[1].detailinfo;
		}
		
	}else{
		if(mb_eva_data_type=="1"){
			sch_detailinfo = localstorageGet("school_info").detailinfo[0];
		}else{
			sch_detailinfo = localstorageGet("school_info").detailinfo[1];
		}
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
	$(".blue_font_class").each(function(index, el) {
		var re_val = "根据您填写的园所信息表，" + eval($(el).attr("save_fun"))();
		$(el).html(re_val);
	});
	
}

//弹出图片

var isTouch = 0;
var check_popup = 0;

function del_fun(){
	var school_id    = localstorageGet("user_info")['school_id'];
	var data_type = mb_eva_data_type;//localstorageGet("user_info")['user_type'];
	var user_id   = localstorageGet("user_info")['id'];
	$.ajax({
		url       : api_prototype_delete_pic,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id             : school_id,
			data_type             : data_type,
			user_id               : user_id,
			mb_level_1            : mb_level_1,
			qa_user_attachment_id : save_popup_arr[1]
			},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
    		var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功删除
	    		$('#myModal').modal('hide');
	    		if(localstorageGet("sch_eva_progress")==1){
	    			$(".s_pic[qa_user_attachment_id='"+save_popup_arr[1]+"']").attr("class","s_pic sp2 glyphicon class_img_13").attr("onclick","setSend_pic(this);");
	    		}
	    	}else if(error_code==3){//APP正在上传数据到服务器，暂不能修改数据
	    		$('#myModal').modal('hide');
	    		setTimeout(function(){
	    			create_alert_box("提示", jsondata.msg, control_popup_close, "", "", "", 1, "320px", "1");
	    			$(".popup_text").addClass('popup_text_2');
	    			
	    			// $(".control_padding_btn_box").css("padding-left", "19%");
	    			
	    			$('#myModal').modal();
	    		},1200);
	    	}
    	},
    	//请求失败时将调用此方法
    	error:function(XMLHttpRequest, textStatus, errorThrown) {
    		// $(".s_pic[qa_user_attachment_id='"+save_popup_arr[1]+"']").attr("class","s_pic sp2 glyphicon class_img_13").attr("onclick","setSend_pic(this);");
    		$('#myModal').modal('hide');
    		setTimeout(function(){
    			create_alert_box_ajax_error("提示", LocalLanguage("ch")['error_msg'], 1);
    		},1200);
    	}
	});
}


//获取lv4的数据
function get_lv4_content(){

	$.ajax({
		url       : api_prototype_get_lv4_result,
		type      : "post",
		dataType  : 'json',
		data      : {
			ass_level1_autoid : mb_level_1,
			ass_level2_autoid : mb_level_2,
			ass_level3_autoid : mb_level_3
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	// console.log(data);
	    	// $("#sch_name").html(data.school_name);
	    	var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	this_time = jsondata.this_time.replace(/-/g,"/");
	    	if(localstorageGet("is_goto")==1){

	    	}else{
	    		check_time_out_2();
	    		check_time_obj = setInterval(check_time_out_2,1000);
	    	}

	    	if(localstorageGet("is_goto")==1){
	    		var sch_name = localstorageGet("school_info_check")['info_2'];
	    	}else{
	    		var sch_name = localstorageGet("school_info")['info_2'];
	    	}
	    	var temp_html = "<span class='col-md-12 col-sm-12 col-xs-12 sch_name_text'>名称：</span>";
	    	temp_html += "<span class='col-md-12 col-sm-12 col-xs-12 class_bt_14'>"+ sch_name +"</span>";
	    	$("#sch_name").html(temp_html);

	    	temp_html = "<span class='col-md-12 col-sm-12 col-xs-12 lv_name_style_text'>指标：</span>";
	    	temp_html += "<span class='col-md-12 col-sm-12 col-xs-12 class_bt_15'>" + jsondata.lv1_ass_text + " / " + jsondata.lv2_ass_text + " / " + jsondata.lv3_ass_text + "</span>";
	    	$("#lv_name").html(temp_html);
	    	var temp_html = "";
	    	var temp_lv4 = 0;//记录上一个lv4,转换了第二题时用
	    	var temp_seq_bylevel = "";
	    	var temp_weigh_bylevel = "";//记录上一个weigh_bylevel
	    	var swap_str = ["A", "B", "C", "D", "E", "F", "G"];
	    	var str_index = 0;
	    	var save_option_type = 1;//记录是否需要输入框,循环完后用
	    	var save_is_uploadprove = 0;//记录上一个题目要显示几多个证明文件
	    	var question_index = 0;
	    	$.each(jsondata.option_data, function(index, val) {
	    		if(index==0){
	    			temp_lv4 = $(val)[0].ass_level4_autoid;
	    			temp_seq_bylevel = $(val)[0].seq_bylevel;
	    			save_is_uploadprove = $(val)[0].is_uploadprove;
	    			temp_weigh_bylevel = $(val)[0].weigh_bylevel;
	    			var temp_biaoti_shu = "<span class='biaoti_shu_control_"+temp_lv4+"'>"+(question_index+1)+".</span>";

	    			//替换一票否决项的文字
	    			var temp_ass_text = $(val)[0].ass_text.replace("一票否决项", "<span style='color:#ff0000;font-weight: bold;'>（关键指标）</span>");
	    			temp_ass_text = temp_ass_text.replace("<Br>", "");
	    			temp_html += "<div class='question_box'>";
	    			temp_html += "<span class='class_bt_17' seq_bylevel='"+temp_seq_bylevel+"'>";
	    			temp_html += 	"<span class='class_bt_17_sz'>" + temp_biaoti_shu + " </span>";
	    			temp_html += 	"<span class='class_bt_17_chd'>" + "<span class='class_bt_17_zi'>" + temp_ass_text;// + "--><span style='color:#ff0000;'>" + $(val)[0].weigh_bylevel + "</span>";
	    			if($(val)[0].comment!="" && $(val)[0].comment!=null){
	    				temp_html += "<span id='btn_popup_img' class='button button--moema button--text-upper button--color-red' onclick='popup_pic_ok_3(this);' text_val='"+$(val)[0].comment+"'>题目解释</span>";// + temp_seq_bylevel;
	    			}
	    			temp_html += 	"<div class='complete_logo_"+temp_lv4+"'></div>";
	    			temp_html += 	"</span>";
	    			temp_html += "</span>";
	    			
	    			temp_html += "<div class='cb_min_height' id='"+ temp_seq_bylevel +"_ans'>";
	    			if($.inArray(temp_seq_bylevel, show_sch_info_id_arr)!=-1){//显示学校具体信息
	    				temp_html += "<div class='blue_font_class "+ temp_seq_bylevel +"_inf' save_fun='"+show_sch_info_fun_arr[$.inArray(temp_seq_bylevel, show_sch_info_id_arr)]+"'>根据您填写的园所信息表，" + eval(show_sch_info_fun_arr[$.inArray(temp_seq_bylevel, show_sch_info_id_arr)])() + "</div>";
	    			}
	    			question_index++;
	    		}
	    		if(temp_lv4 != $(val)[0].ass_level4_autoid){
	    			
	    			if(save_option_type==2){
	    				temp_html += "<div class='col-md-12 col-sm-12 col-xs-12'><input class='input_"+temp_lv4+" is_input' lv4='"+temp_lv4+"' onblur='submit_options(this);' /></div>";
	    			}
	    			

	    			temp_html += "</div>";

	    			temp_html += "<div class='upload_file_box'>";
	    			for(var i=0;i<12;i++){
	    				if(localstorageGet("sch_eva_progress")==1 && localstorageGet("is_goto")!=1 && user_type!='5' && user_type!='6' && user_type!='7'){
	    					if(i<save_is_uploadprove){//可以操作的按钮
	    						if(i==0 || i==6){
	    							temp_html += "<div class='s_pic sp2 sp3 glyphicon class_img_13' seq='"+i+"' lv4='"+temp_lv4+"' seq_bylevel='"+temp_seq_bylevel+"' is_uploadprove='1'></div>";
	    						}else{
	    							temp_html += "<div class='s_pic sp2 glyphicon class_img_13' seq='"+i+"' lv4='"+temp_lv4+"' seq_bylevel='"+temp_seq_bylevel+"' is_uploadprove='1'></div>";
	    						}
	    					}else{
	    						if(i==0 || i==6){
	    							temp_html += "<div class='s_pic sp2 sp3 glyphicon class_img_13_dim' seq='"+i+"' lv4='"+temp_lv4+"' seq_bylevel='"+temp_seq_bylevel+"' is_uploadprove='0'></div>";
	    						}else{
	    							temp_html += "<div class='s_pic sp2 glyphicon class_img_13_dim' seq='"+i+"' lv4='"+temp_lv4+"' seq_bylevel='"+temp_seq_bylevel+"' is_uploadprove='0'></div>";
	    						}
	    					}
	    				}else{
	    					if(i==0 || i==6){
	    						temp_html += "<div class='s_pic sp2 sp3 glyphicon class_img_13_dim' seq='"+i+"' lv4='"+temp_lv4+"' seq_bylevel='"+temp_seq_bylevel+"' is_uploadprove='0'></div>";
	    					}else{
	    						temp_html += "<div class='s_pic sp2 glyphicon class_img_13_dim' seq='"+i+"' lv4='"+temp_lv4+"' seq_bylevel='"+temp_seq_bylevel+"' is_uploadprove='0'></div>";
	    					}
	    				}
	    				
	    				
	    			}
	    			temp_html += "</div>";


	    			temp_html += "<div class='huan_hang'>";
	    			temp_html += 	"<div class='textarea_box'>";
	    			if(user_type=='5' || user_type=='6' || user_type=='7'){
	    				temp_html += "<textarea class='ta_content ta"+temp_lv4+" ta_min_height' lv4='"+temp_lv4+"' cols='25' rows='5' seq_bylevel='"+temp_seq_bylevel+"' disabled></textarea>";
	    			}else{
	    				temp_html += "<textarea class='ta_content ta"+temp_lv4+" ta_min_height' lv4='"+temp_lv4+"' cols='25' rows='5' seq_bylevel='"+temp_seq_bylevel+"' disabled></textarea>";
	    			}
	    			temp_html += 	"</div>";
	    			temp_html += "</div>";

	    			temp_html += "</div>";//question_box
	    			temp_html += "<div class='class_fengexian'></div>";//题目分割线

	    			//新题目开始
	    			temp_lv4 = $(val)[0].ass_level4_autoid;
	    			temp_seq_bylevel = $(val)[0].seq_bylevel;
	    			save_is_uploadprove = $(val)[0].is_uploadprove;
	    			temp_weigh_bylevel = $(val)[0].weigh_bylevel;

	    			var temp_biaoti_shu = "<span class='biaoti_shu_control_"+temp_lv4+"'>"+(question_index+1)+".</span>";

	    			str_index = 0;
	    			//替换一票否决项的文字
	    			var temp_ass_text = $(val)[0].ass_text.replace("一票否决项", "<span style='color:#ff0000;font-weight: bold;'>（关键指标）</span>");
	    			temp_ass_text = temp_ass_text.replace("<Br>", "");
	    			temp_html += "<div class='question_box'>";
	    			temp_html += "<span class='class_bt_17' seq_bylevel='"+temp_seq_bylevel+"'>";
	    			temp_html += 	"<span class='class_bt_17_sz'>" + temp_biaoti_shu + " </span>";
	    			temp_html += 	"<span class='class_bt_17_chd'>" + "<span class='class_bt_17_zi'>" + temp_ass_text;// + "--><span style='color:#ff0000;'>" + $(val)[0].weigh_bylevel + "</span>";
	    			if($(val)[0].comment!="" && $(val)[0].comment!=null){
	    				temp_html += 	"<span id='btn_popup_img' class='button button--moema button--text-upper button--color-red' onclick='popup_pic_ok_3(this);' text_val='"+$(val)[0].comment+"'>题目解释</span>";// + temp_seq_bylevel;
	    			}
	    			temp_html += 	"<div class='complete_logo_"+temp_lv4+"'></div>";
	    			temp_html += 	"</span>";
	    			temp_html += "</span>";

	    			temp_html += "<div class='cb_min_height' id='"+ temp_seq_bylevel +"_ans'>";
	    			if($.inArray(temp_seq_bylevel, show_sch_info_id_arr)!=-1){//显示学校具体信息
	    				temp_html += "<div class='blue_font_class "+ temp_seq_bylevel +"_inf' save_fun='"+show_sch_info_fun_arr[$.inArray(temp_seq_bylevel, show_sch_info_id_arr)]+"'>根据您填写的园所信息表，" + eval(show_sch_info_fun_arr[$.inArray(temp_seq_bylevel, show_sch_info_id_arr)])() + "</div>";
	    			}
	    			question_index++;
	    		}
	    		var wei_arr = $(val)[0].weigh_bylevel.split(",");
	    		var weigh_jieguo = 1000;
	    		for(var ti=0;ti<wei_arr.length;ti++){
	    			weigh_jieguo = weigh_jieguo * (wei_arr[ti]);
	    		}
	    		var qz_val = parseFloat($(val)[0].score * weigh_jieguo).toFixed(2);

	    		temp_html += 	"<div class='col-md-12 col-sm-12 col-xs-12 class_padding_0'>";
	    		temp_html += 		"<span class='class_radio_box'>";
	    		temp_html += 			"<input id='"+ temp_seq_bylevel +"_ans_"+ str_index +"' style='vertical-align: top;' type='radio' class='rds radio_" + temp_lv4 + "_"+$(val)[0].id+" radio_group_"+temp_lv4+"' option_id='"+$(val)[0].id+"' lv4='"+temp_lv4+"' name='group"+temp_lv4+"' min_val='"+$(val)[0].min_compare+"' max_val='"+$(val)[0].max_compare+"' onclick='submit_options(this);' />";
	    		temp_html +=			"<span class='class_bt_18' style='vertical-align: top;'>" + swap_str[str_index]+".</span>";
	    		temp_html +=			"<span class='class_bt_18' style='display: inline-block; width: 85%;'>" + $(val)[0].option_text + "</span>";
	    		temp_html += 		"</span>";
	    		// temp_html +=        "<span class='col-md-12 col-sm-12 col-xs-12 qz' style='color:#ff0000;'>"+$(val)[0].score + "-->" + qz_val +"</span>";
	    		temp_html +=        "<span class='col-md-12 col-sm-12 col-xs-12 qz' style='color:#ff0000;height:15px;'></span>";
	    		temp_html += 	"</div>";

	    		if($(val)[0].option_img){
    			temp_html +=	"<div class='col-md-2 col-sm-2 col-xs-12 '>";
    			temp_html +=		"<div class='option_img' src_val='"+$(val)[0].option_img+"' onclick='c_img_fun(this)'></div>";
    			temp_html += 	"</div>";
	    		}
	    		
	    		save_option_type = $(val)[0].option_type;
	    		str_index++;
	    	});
			if(save_option_type==2){
				temp_html += "<div class='col-md-12 col-sm-12 col-xs-12'><input class='input_"+temp_lv4+" is_input' lv4='"+temp_lv4+"' onblur='submit_options(this);' /></div>";
			}
			
			temp_html += "</div>";
			temp_html += "<div class='upload_file_box'>";
			for(var i=0;i<12;i++){
				if(localstorageGet("sch_eva_progress")==1 && localstorageGet("is_goto")!=1 && user_type!='5' && user_type!='6' && user_type!='7'){
					if(i<save_is_uploadprove){//可操作的
						if(i==0 || i==6){
							temp_html += "<div class='s_pic sp2 sp3 glyphicon class_img_13' seq='"+i+"' lv4='"+temp_lv4+"' seq_bylevel='"+temp_seq_bylevel+"' is_uploadprove='1''></div>";
						}else{
							temp_html += "<div class='s_pic sp2 glyphicon class_img_13' seq='"+i+"' lv4='"+temp_lv4+"' seq_bylevel='"+temp_seq_bylevel+"' is_uploadprove='1'></div>";
						}
					}else{//不可操作
						if(i==0 || i==6){
							temp_html += "<div class='s_pic sp2 sp3 glyphicon class_img_13_dim' seq='"+i+"' lv4='"+temp_lv4+"' seq_bylevel='"+temp_seq_bylevel+"' is_uploadprove='0'></div>";
						}else{
							temp_html += "<div class='s_pic sp2 glyphicon class_img_13_dim' seq='"+i+"' lv4='"+temp_lv4+"' seq_bylevel='"+temp_seq_bylevel+"' is_uploadprove='0'></div>";
						}
					}
				}else{
					if(i==0 || i==6){
						temp_html += "<div class='s_pic sp2 sp3 glyphicon class_img_13_dim' seq='"+i+"' lv4='"+temp_lv4+"' seq_bylevel='"+temp_seq_bylevel+"' is_uploadprove='0'></div>";
					}else{
						temp_html += "<div class='s_pic sp2 glyphicon class_img_13_dim' seq='"+i+"' lv4='"+temp_lv4+"' seq_bylevel='"+temp_seq_bylevel+"' is_uploadprove='0'></div>";
					}
				}
			}
			temp_html += "</div>";

			temp_html += "<div class='huan_hang'>";
	    	temp_html += 	"<div class='textarea_box'>";
	    	if(user_type=='5' || user_type=='6' || user_type=='7'){
	    		temp_html += "<textarea class='ta_content ta"+temp_lv4+" ta_min_height' lv4='"+temp_lv4+"' cols='25' rows='5' seq_bylevel='"+temp_seq_bylevel+"' disabled></textarea>";
	    	}else{
	    		temp_html += "<textarea class='ta_content ta"+temp_lv4+" ta_min_height' lv4='"+temp_lv4+"' cols='25' rows='5' seq_bylevel='"+temp_seq_bylevel+"' disabled></textarea>";
	    	}
	    	temp_html += 	"</div>";
	    	temp_html += "</div>";

	    	temp_html += "</div>";//question_box
	    	$(".content_box").html(temp_html);

	    	if(localstorageGet("is_goto")==1 || localstorageGet("sch_eva_progress")!=1){//点击查看进入
	    		$(".rds").prop("disabled", true);
	    		$(".ta_content").prop("disabled", true).attr("placeholder", "");
	    	}
	    	get_options();
	    	
	    	//显示下一题按钮
	    	if(localstorageGet("is_goto")==1){
	    		$(".next_ques_box_2").css("width", "220px");
	    	}else{
	    		if(BrowserSystem=="window"){
	    			$(".next_ques_box_2").css("width", "130px");
	    		}else{
	    			$(".next_ques_box_2").css("width", "160px");
	    		}
	    	}
	    	$("#btn_next_ques").show();
	    	$("#go_to_mb_category").show();
	    	
	    	//除win版外下调说明图标
	    	if(BrowserSystem=="window"){
	    		$(".btn_popup_img").addClass('btn_popup_img_win');
	    	}else{
	    		$(".btn_popup_img").addClass('btn_popup_img_ios');
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
//获取用户选取的数据
function get_options(){
	var user_type = 1;
	if(localstorageGet("is_goto")==1){
		var school_id = localstorageGet("school_info_check")['id'];

		var data_type = localstorageGet("data_type");
		
		if(data_type=='2'){
			user_type = 3;
		}else if(data_type=='3'){
			user_type = 5;
		}else if(data_type=='4'){
			user_type = 6;
		}else if(data_type=='5'){
			user_type = 7;
		}
	}else{
		var school_id    = localstorageGet("user_info")['school_id'];
		// var user_type = localstorageGet("user_info")['user_type'];
		if(mb_eva_data_type==1){
			user_type = 1;
		}else if(mb_eva_data_type==2){
			user_type = 3;
		}else if(mb_eva_data_type==3){
			user_type = 5;
		}else if(mb_eva_data_type==4){
			user_type = 6;
		}else if(mb_eva_data_type==5){
			user_type = 7;
		}
	}

	
	
	var data_type = mb_eva_data_type;
	
	
	var user_id   = localstorageGet("user_info")['id'];
	$.ajax({
		url       : api_prototype_get_options,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id         : school_id,
			user_type         : user_type,
			data_type         : data_type,
			user_id           : user_id,
			ass_level3_autoid : mb_level_3
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	// console.log(data);
	    	$(".biaoti_shu_class").each(function(index, el) {
	    		// var temp_str = $(el).html();
	    		// temp_str = temp_str + ".";
	    		// $(el).removeClass('biaoti_shu_class').html(temp_str);
	    	});
	    	$(".complete_logo").removeClass('complete_logo');
	    	
	    	$.each(data, function(index, val) {
	    		for(var i=0;i<val.length;i++){
	    			$(".radio_"+val[i][0].ass_level4_autoid+"_"+val[i][0].ass_options_autoid).prop('checked',true).attr("is_checked", "1");
	    			
	    			$(".complete_logo_"+val[i][0].ass_level4_autoid).addClass('complete_logo');

	    			$(".s_pic[lv4='"+ val[i][0].ass_level4_autoid +"']").attr("is_select", "1");
	    			$(".ta"+ val[i][0].ass_level4_autoid).attr("is_select", "1");
	    			// $(".biaoti_shu_control_"+val[i][0].ass_level4_autoid).addClass('biaoti_shu_class');
	    			// var temp_str = $(".biaoti_shu_control_"+val[i][0].ass_level4_autoid).html();
	    			// temp_str = temp_str.replace(".", "");
	    			// $(".biaoti_shu_control_"+val[i][0].ass_level4_autoid).html(temp_str);
	    			if(val[i][0].input_text!=""){
	    				$(".input_"+val[i][0].ass_level4_autoid).val(val[i][0].input_text);
	    			}
	    		}
	    	});

	    	//复评没有证明数据
	    	if(mb_eva_data_type=='1' || mb_eva_data_type=='2'){
    			get_attachment();
    		}else{
    			$(".s_pic").attr("onclick", "").css("cursor", "default").attr("class", "s_pic sp2 sp3 glyphicon class_img_13_dim");
    			$(".ta_content").prop("disabled", true);
    			$(".ta_content").val("");
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

//获取用户提交的qa_saveproves_byself qa_saveproves_bysupervisor表数据
function get_attachment(){
	if(localstorageGet("is_goto")==1){
		var school_id = localstorageGet("school_info_check")['id'];
	}else{
		var school_id    = localstorageGet("user_info")['school_id'];
	}
	var sch_name  = localstorageGet("school_info")['info_2'];
	var data_type = mb_eva_data_type;//localstorageGet("user_info")['user_type'];
	var user_id   = localstorageGet("user_info")['id'];

	$.ajax({
		url       : api_prototype_get_inputproves,
		type      : "post",
		dataType  : 'json',
		data      : {
			sch_id            : school_id,
			sch_name          : sch_name,
			data_type         : data_type,
			user_id           : user_id,
			ass_level3_autoid : mb_level_3
		},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	// console.log(data.attachment_data);
	    	
	    	$(".ta_content").val("");

	    	if(localstorageGet("sch_eva_progress")==1){
	    		var temp_val = 0;
	    		if(localstorageGet("user_info")['user_type']==1 || localstorageGet("user_info")['user_type']==2){
	    			temp_val = 1;
	    		}else if(localstorageGet("user_info")['user_type']==3 || localstorageGet("user_info")['user_type']==4){
	    			temp_val = 2;
	    		}else{
	    			temp_val = localstorageGet("user_info")['user_type'];
	    		}
	    		if(mb_eva_data_type==temp_val){
	    			$(".s_pic").each(function(index, el) {
	    				if($(el).attr("is_uploadprove")==="1" && $(el).attr("is_select")=="1"){
	    					$(el).attr("onclick", "setSend_pic(this);").css("cursor", "pointer");
	    				}else{
	    					$(el).attr("onclick", "").css("cursor", "default").addClass('class_img_13_dim').removeClass('class_img_13');
	    				}
	    			});
	    			$(".ta_content").each(function(index, el) {
	    				if($(el).attr("is_select")=="1"){
	    					$(el).prop("disabled", false);
	    					$(el).attr("onblur", "setTextarea(this);").attr("placeholder", "输入文字记录");
	    				}
	    				
	    			});
	    		}else{
	    			$(".s_pic").attr("onclick", "").css("cursor", "default").attr("class", "s_pic sp2 sp3 glyphicon class_img_13_dim");
	    		}
	    	}else{
	    		$(".s_pic").attr("onclick", "").css("cursor", "default").attr("class", "s_pic sp2 sp3 glyphicon class_img_13_dim");
	    	}
	    	
	    	$.each(data, function(index, val) {
	    		for(var i=0;i<val.length;i++){
	    			for(var j=0;j<val[i].length;j++){
	    				if(val[i][j].seq!='99'){
	    					var resource_type = val[i][j].file_path.split(".")[1].toLowerCase();
	    					if(mb_eva_data_type==temp_val){//localstorageGet("user_info")['user_type']
	    						if(resource_type=="png" || resource_type=="jpg" || resource_type=="jpeg"){
	    							$(".s_pic[lv4='"+val[i][j].ass_level4_autoid+"'][seq='"+val[i][j].seq+"']").addClass('class_img_11').removeClass('class_img_13').removeClass('class_img_13_dim').attr("onclick","popup_pic(this,1);").attr("src_val", val[i][j].file_path).attr("qa_user_attachment_id", val[i][j].id).attr("onblur","hide_popup_pic();").attr("tabindex", "0");
	    						}else if(resource_type=="pdf"){
	    							$(".s_pic[lv4='"+val[i][j].ass_level4_autoid+"'][seq='"+val[i][j].seq+"']").addClass('class_img_9').removeClass('class_img_13').removeClass('class_img_13_dim').attr("onclick","popup_pic(this,3);").attr("src_val", val[i][j].file_path).attr("qa_user_attachment_id", val[i][j].id).attr("onblur","hide_popup_pic();").attr('tabindex', "0");
	    						}else if(resource_type=="ppt" || resource_type=="pptx"){
	    							$(".s_pic[lv4='"+val[i][j].ass_level4_autoid+"'][seq='"+val[i][j].seq+"']").addClass('class_img_10').removeClass('class_img_13').removeClass('class_img_13_dim').attr("onclick","popup_pic(this,3);").attr("src_val", val[i][j].file_path).attr("qa_user_attachment_id", val[i][j].id).attr("onblur","hide_popup_pic();").attr('tabindex', "0");
	    						}else if(resource_type=="doc" || resource_type=="docx"){
	    							$(".s_pic[lv4='"+val[i][j].ass_level4_autoid+"'][seq='"+val[i][j].seq+"']").addClass('class_img_12').removeClass('class_img_13').removeClass('class_img_13_dim').attr("onclick","popup_pic(this,3);").attr("src_val", val[i][j].file_path).attr("qa_user_attachment_id", val[i][j].id).attr("onblur","hide_popup_pic();").attr('tabindex', "0");
	    						}else if(resource_type=="xls" || resource_type=="xlsx"){
	    							$(".s_pic[lv4='"+val[i][j].ass_level4_autoid+"'][seq='"+val[i][j].seq+"']").addClass('class_img_14').removeClass('class_img_13').removeClass('class_img_13_dim').attr("onclick","popup_pic(this,3);").attr("src_val", val[i][j].file_path).attr("qa_user_attachment_id", val[i][j].id).attr("onblur","hide_popup_pic();").attr('tabindex', "0");
	    						}
	    					}else{
	    						if(resource_type=="png" || resource_type=="jpg" || resource_type=="jpeg"){
	    							$(".s_pic[lv4='"+val[i][j].ass_level4_autoid+"'][seq='"+val[i][j].seq+"']").addClass('class_img_11').removeClass('class_img_13').removeClass('class_img_13_dim').attr("onclick","popup_pic(this,1,1);").attr("src_val", val[i][j].file_path).attr("qa_user_attachment_id", val[i][j].id).attr("onblur","hide_popup_pic();").attr("tabindex", "0");
	    						}else if(resource_type=="pdf"){
	    							$(".s_pic[lv4='"+val[i][j].ass_level4_autoid+"'][seq='"+val[i][j].seq+"']").addClass('class_img_9').removeClass('class_img_13').removeClass('class_img_13_dim').attr("onclick","popup_pic(this,3,1);").attr("src_val", val[i][j].file_path).attr("qa_user_attachment_id", val[i][j].id).attr("onblur","hide_popup_pic();").attr('tabindex', "0");
	    						}else if(resource_type=="ppt" || resource_type=="pptx"){
	    							$(".s_pic[lv4='"+val[i][j].ass_level4_autoid+"'][seq='"+val[i][j].seq+"']").addClass('class_img_10').removeClass('class_img_13').removeClass('class_img_13_dim').attr("onclick","popup_pic(this,3,1);").attr("src_val", val[i][j].file_path).attr("qa_user_attachment_id", val[i][j].id).attr("onblur","hide_popup_pic();").attr('tabindex', "0");
	    						}else if(resource_type=="doc" || resource_type=="docx"){
	    							$(".s_pic[lv4='"+val[i][j].ass_level4_autoid+"'][seq='"+val[i][j].seq+"']").addClass('class_img_12').removeClass('class_img_13').removeClass('class_img_13_dim').attr("onclick","popup_pic(this,3,1);").attr("src_val", val[i][j].file_path).attr("qa_user_attachment_id", val[i][j].id).attr("onblur","hide_popup_pic();").attr('tabindex', "0");
	    						}else if(resource_type=="xls" || resource_type=="xlsx"){
	    							$(".s_pic[lv4='"+val[i][j].ass_level4_autoid+"'][seq='"+val[i][j].seq+"']").addClass('class_img_14').removeClass('class_img_13').removeClass('class_img_13_dim').attr("onclick","popup_pic(this,3,1);").attr("src_val", val[i][j].file_path).attr("qa_user_attachment_id", val[i][j].id).attr("onblur","hide_popup_pic();").attr('tabindex', "0");
	    						}
	    					}
	    					$(".s_pic[lv4='"+val[i][j].ass_level4_autoid+"'][seq='"+val[i][j].seq+"']").css("cursor", "pointer");
	    					//添加拖放功能
	    					/*$(".s_pic[lv4='"+val[i][j].ass_level4_autoid+"'][seq='"+val[i][j].seq+"']").draggable({ revert: true, start: function(event){
	    						check_drag=true;
	    						qa_user_attachment_id = $(event.target).attr("qa_user_attachment_id");
	    						$(event.target).css("z-index", "2");
	    					}, stop: function(event){
	    						setTimeout(function(){
	    							check_drag=false;
	    						},200);
	    						$(event.target).css("z-index", "1");
	    					} });*/
	    				}else{
	    					//记录憑證輸入內容
	    					$(".ta"+val[i][j].ass_level4_autoid).val(val[i][j].input_content).attr("save_data", val[i][j].input_content);
	    				}
	    			}
	    		}
	    	});
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

//点击上传图片
function setSend_pic(tObj){
	
	var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
	var name = "";
	for(var i=0;i<10;i++){
		name += chars[Math.floor(Math.random()*(chars.length-1))];
	}
	random_str = name;

	
	var lv4_id = $(tObj).attr("lv4");
	var seq_val = $(tObj).attr("seq");
	var seq_bylevel = $(tObj).attr("seq_bylevel");

	//参数
	$(".sch_id").val(localstorageGet("user_info")['school_id']);
	$(".sch_name").val(localstorageGet("school_info")['info_2']);
	$(".data_type").val(mb_eva_data_type);
	$(".user_id").val(localstorageGet("user_info")['id']);
	$(".formLv1").val(mb_level_1);
	$(".formLv2").val(mb_level_2);
	$(".formLv3").val(mb_level_3);
	$(".formLv4").val(lv4_id);
	$(".seq_bylevel").val(seq_bylevel);
	$(".formSeq").val(seq_val);
	$(tObj).attr("savecontrol", name);

	$(".f1").trigger('click');
}


//提交证明文件的数据
// var ajaxForm_obj;

function send_fileproves_data(){
	var sch_id = $(".sch_id").val();
	var sch_name = $(".sch_name").val();
	var data_type = $(".data_type").val();
	var user_id = $(".user_id").val();
	var lv4_id = $(".formLv4").val();
	var seq_bylevel = $(".seq_bylevel").val();
	var seq_val = $(".formSeq").val();
	var file_name = $(".f1")[0].files[0].name;

	var file_type = file_name.split(".");
	file_type = file_type[file_type.length-1].toLocaleLowerCase();
	// alert(sch_id+"--"+sch_name+"--"+user_type+"--"+user_id+"--"+lv4_id+"--"+seq_val+"--"+file_name)
	var file_size = 5242880;
	if($(".f1")[0].files[0].size>=file_size){
		create_alert_box("提示", "文件大小不能超过5M！", control_popup_close, "", "", "", 1, "320px");
		// $(".popup_text").addClass('popup_text_2');
		$('#myModal').modal();
		return;
	}
	var check_type_ok = 0;
	//判断是否符合格式
	if(file_type=="doc" || file_type=="docx" || file_type=="jpg" || file_type=="jpeg" || file_type=="png" || file_type=="pdf" || file_type=="xls" || 
		file_type=="xlsx" || file_type=="ppt" || file_type=="pptx"){
		check_type_ok = 1;
	}
	if(check_type_ok==0){
		create_alert_box("提示", "上传文件的格式为IMG、PPT、DOC、XLS或PDF。", control_popup_close, "", "", "", 1, "320px", "1");
		$(".popup_text").addClass('popup_text_2');
		return;
	}
	
	$.ajax({
		url       : api_prototype_send_data,
		type      : "post",
		dataType  : 'json',
		data      : {
			sch_id         : sch_id,
			sch_name       : sch_name,
			data_type      : data_type,
			user_id        : user_id,
			random_name    : random_str,
			ass_level1_autoid : mb_level_1,
			ass_level2_autoid : mb_level_2,
			ass_level3_autoid : mb_level_3,
			ass_level4_autoid : lv4_id,
			seq_bylevel       : seq_bylevel,
			seq               : seq_val,
			file_name         : file_name
			},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){       
    		var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		//添加一个正在上传的提示
	    		create_alert_box_ajax_error("提示", "正在上传...", 1);
	    		var temp_str = "";
	    		temp_str += "<div class='progress'>";
	    		temp_str += 	"<div class='bar'></div >";
	    		temp_str += 	"<div class='percent'>0%</div >";
	    		temp_str += "</div >";
	    		$("#myModalLabel").append(temp_str);
	    		$(".popup_text").addClass('text-center').removeClass('popup_text_2');
	    		$("#btn_popup_sueecss").html("取消").attr("onclick", "abort_fun();");
	    		$("#close_btn").hide();

	    		//开始真正上传
	    		var obj = eval ("(" + jsondata.list[3] + ")");
	            $(".OSSAccessKeyId").val(obj['accessid']);
	            $(".policy").val(obj['policy']);
	            $(".signature").val(obj['signature']);
	            $(".key").val(obj['dir']+jsondata.list[0]);
	            $(".callback").val(obj['callback']);
	            $(".file_type").val(file_type);
	            $("#myForm").attr("action", obj['host']);
	    		// save_file_insert_id = jsondata.list[2];
	    		save_file_return_name = jsondata.list[0];
		    	$("#myForm").ajaxForm(form_options).submit();

		    	//添加一个正在上传的提示
		    	/*create_alert_box_ajax_error("提示", "正在上传...", 1);
		    	$(".popup_text").addClass('text-center').removeClass('popup_text_2');
		    	$("#btn_popup_sueecss").hide();
		    	$("#close_btn").hide();*/
	    	}else if(error_code==2){
	    		$('#myModal').modal('hide');
	    		setTimeout(function(){
	    			create_alert_box("提示", jsondata.msg, control_popup_close, "", "", "", 1, "320px", "1");
	    			$(".popup_text").addClass('popup_text_2');
	    		},1200);
	    		
	    		
	    		// $(".control_padding_btn_box").css("padding-left", "19%");
	    		
	    		
	    	}else if(error_code==3){//APP正在上传数据到服务器，暂不能修改数据
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

//中断中传操作
var check_is_abort = 0;//记录中断操作
function abort_fun(){
	check_is_abort = 1;
	ajaxForm_obj.abort();
}

//用户提交数据
function submit_options(tObj){
	var school_id          = localstorageGet("user_info")['school_id'];
	var user_type          = localstorageGet("user_info")['user_type'];
	var user_id            = localstorageGet("user_info")['id'];
	var ass_level4_autoid  = $(tObj).attr("lv4");
	var ass_options_autoid = 0;
	var input_text         = parseInt($(".input_"+ass_level4_autoid).val());

	//如果是点击模糊答案进入则进行筛选
	if(input_text!="" && $(tObj).hasClass('is_input')){
		$(".radio_group_"+ass_level4_autoid).each(function(index, el) {
			var min_val  = parseInt($(el).attr('min_val').split(",")[1]);
			var min_type = $(el).attr('min_val').split(",")[0];
			var max_val = parseInt($(el).attr('max_val').split(",")[1]);
			var max_type = $(el).attr('max_val').split(",")[0];
			var pd_checked = 0;
			if(min_type==4 && max_type==4){
				if(input_text >= min_val){
					pd_checked = 1;
				}
			}else if(min_type==2 && max_type==2){
				if(input_text <= min_val){
					pd_checked = 1;
				}
			}else if(min_type==4 && max_type==1){
				if(input_text >= min_val && input_text < max_val){
					pd_checked = 1;
				}
			}else if(min_type==3 && max_type==2){
				if(input_text > min_val && input_text <= max_val){
					pd_checked = 1;
				}
			}
			if(pd_checked == 1){
				$(".radio_group_"+ass_level4_autoid).prop("checked", false);
				ass_options_autoid = $(el).attr("option_id");
				$(el).prop("checked", true);
				return false;
			}
		});
	}else{
		$(".radio_group_"+ass_level4_autoid).each(function(index, el) {
			if($(el).is(':checked')){
				ass_options_autoid = $(el).attr("option_id");
			}
		});
	}
	
	// $(".biaoti_shu_control_"+ass_level4_autoid).addClass('biaoti_shu_class');
	// var temp_str = $(".biaoti_shu_control_"+ass_level4_autoid).html();
	// temp_str = temp_str.replace(".", "");
	// $(".biaoti_shu_control_"+ass_level4_autoid).html(temp_str);
	$(".complete_logo_"+ass_level4_autoid).addClass('complete_logo');
	$.ajax({
		url       : api_prototype_send_submit,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id          : school_id,
			user_type          : user_type,
			user_id            : user_id,
			mb_level_1         : mb_level_1,
			ass_level4_autoid  : ass_level4_autoid,
			ass_options_autoid : ass_options_autoid,
			input_text         : input_text
			},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
	    	var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==2){
	    		create_alert_box_ajax_error("提示", "评估数据已经提交了，不能继续修改。", 1);
	    		$(".popup_text").addClass('text-center');
	    		$("#popup_content").css("min-height", "270px");
	    		$("#myModalLabel").css("min-height", "180px");

	    		$(".popup_hide_control").hide();
	    		$(".popup_hide_1").show();
	    		
	    		$("#btn_popup_sueecss").attr("onclick", "header_logout();").css("margin-left", "28.5%").html("确定");
	    		
	    		$("#btn_popup_cencel").hide();

	    		//清空本地数据
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

    			$("#close_btn").attr("onclick", "header_logout();");
	    	}else if(error_code==0){//成功提交
	    		if($(".s_pic[lv4='"+ ass_level4_autoid +"']").eq(0).attr("is_select")!="1"){
	    			$(".s_pic[lv4='"+ ass_level4_autoid +"']").each(function(index, el) {
	    				if($(el).attr("is_uploadprove")==="1"){
	    					$(el).attr("onclick", "setSend_pic(this);").css("cursor", "pointer").addClass('class_img_13').removeClass('class_img_13_dim').attr("is_select", "1");
	    				}
	    			});
	    		}
	    		if(user_type<5){
	    			$(".ta"+ass_level4_autoid).prop("disabled", false);
	    			$(".ta"+ass_level4_autoid).attr("onblur", "setTextarea(this);").attr("placeholder", "输入文字记录");
	    		}
	    		
	    		
	    		//记录最后成功传到数据库的是哪一个选项
	    		$(".radio_group_" + ass_level4_autoid).attr("is_checked", "0");
	    		$(tObj).attr("is_checked", "1");
	    	}else if(error_code==3){//APP正在上传数据到服务器，暂不能修改数据
	    		create_alert_box("提示", jsondata.msg, control_popup_close, "", "", "", 1, "320px", "1");
	    		$(".popup_text").addClass('popup_text_2');
	    		
	    		// $(".control_padding_btn_box").css("padding-left", "19%");
	    		
	    		$('#myModal').modal();
	    		var is_null_checked = 1;
	    		$(".radio_group_" + ass_level4_autoid).each(function(index, el) {
	    			if($(el).attr("is_checked")=="1"){
	    				is_null_checked = 0;
	    				$(el).prop("checked", true);
	    			}
	    		});
	    		if(is_null_checked==1){
	    			$(tObj).removeAttr('checked');
	    		}
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

//提交憑證輸入內容
function setTextarea(tObj){
	var school_id        = localstorageGet("user_info")['school_id'];
	var user_type        = localstorageGet("user_info")['user_type'];
	var user_id          = localstorageGet("user_info")['id'];
	var lv4_id           = $(tObj).attr("lv4");
	var seq_bylevel    = $(tObj).attr("seq_bylevel");
	var text_val         = $(tObj).val();

	$.ajax({
		url       : api_prototype_send_textarea,
		type      : "post",
		dataType  : 'json',
		data      : {
			school_id         : school_id,
			user_type         : user_type,
			user_id           : user_id,
			mb_level_1        : mb_level_1,
			ass_level4_autoid : lv4_id,
			seq_bylevel       : seq_bylevel,
			text_val          : text_val
			},
		//请求成功后的回调函数有两个参数
    	success:function(data,textStatus){
    		var jsonstr = JSON.stringify(data);
	    	var jsondata = $.parseJSON(jsonstr);
	    	var error_code = jsondata.error_code;
	    	if(error_code==0){//成功
	    		/*var obj = eval ("(" + jsondata.list[1] + ")");
	            $(".OSSAccessKeyId").val(obj['accessid']);
	            $(".policy").val(obj['policy']);
	            $(".signature").val(obj['signature']);
	            $(".key").val(obj['dir']+jsondata.list[0]);
	            $(".callback").val(obj['callback']);
	            $("#myForm").attr("action", obj['host']);
	            $(".f1").val(obj['dir']+jsondata.list[2]);
		    	$("#myForm").ajaxForm(form_options).submit();*/
		    	$(tObj).attr("save_data", text_val);
	    	}else if(error_code==2){
	    		create_alert_box("提示", jsondata.msg, control_popup_close, "", "", "", 1, "320px", "1");
	    		$(".popup_text").addClass('popup_text_2');
	    		
	    		// $(".control_padding_btn_box").css("padding-left", "19%");
	    		
	    		$('#myModal').modal();
	    	}else if(error_code==3){//APP正在上传数据到服务器，暂不能修改数据
	    		create_alert_box("提示", jsondata.msg, control_popup_close, "", "", "", 1, "320px", "1");
	    		$(".popup_text").addClass('popup_text_2');
	    		
	    		// $(".control_padding_btn_box").css("padding-left", "19%");
	    		
	    		$('#myModal').modal();
	    		$(tObj).val($(tObj).attr("save_data"));
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




