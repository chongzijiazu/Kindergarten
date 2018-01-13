/**
 * 本地語言
 **/
function LocalLanguage(languageType){
	// var lang = localstorageGet(ls_lang);
	var cLang = new Object();
	var lFun = eval("Language_"+languageType);
	cLang = lFun(cLang);
	return cLang;
}
/**
 * 繁體中文
 */
function Language_tw(cLang){
	return cLang;
}
/**
 * 簡體中文
 */
function Language_ch(cLang){
	cLang["001"] = "请观看“评估指导”，如在评估过程中需再次观看，请点击页面右上角";
	cLang["002"] = "按钮。";
	cLang["003"] = "点击“确定开始”后请务必在120小时（5天）内完成评估并提交评估数据。超过120个小时系统将自动关闭！";
	cLang["003_1"] = "请点击“确定开始”按钮开始评估。";
	cLang["004"] = "点击“确定开始”后您可以在90天内反复提交、修改数据，系统默认最后一次数据，超过90天系统将自动关闭！";
	cLang["004_1"] = "请点击“确定开始”按钮开始评估。";
	cLang["005"] = "点击“确定开始”后请务必在120小时（5天）内完成评估并提交评估数据。超过120个小时系统将自动关闭！";
	cLang["005_1"] = "请点击“确定开始”按钮开始评估。";
	cLang["006"] = "评估数据已提交，如需修改请联系组长。";
	cLang["007"] = "账号和密码不匹配，请重试！";
	cLang["008"] = "系统已因超时关闭！如想再次登录系统请联络客服，电话：13716710580。";
	cLang["009"] = "园长尚未启动评估，您还不能进入评估页面。";
	cLang["010"] = "组长尚未启动评估，您还不能进入评估页面。";
	cLang["011"] = "该园尚未进行县级评估，不能开始复评。";
	cLang["012"] = "评估数据已提交，系统已关闭！如想再次登录系统请联络客服， 电话：13716710580。";
	cLang["013"] = "不能登录，督评未完成。";

	cLang["error_msg"] = "网络状态不佳，请在联网状态下重试。";
	return cLang;
}
/**
 * 英文
 */
function Language_eng(cLang){
	return cLang;
}





























