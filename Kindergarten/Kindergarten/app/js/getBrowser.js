// JavaScript Document
/**
* 獲取當前系統
*/
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
	} else {
		curBrowser = "window";
	}
	return curBrowser;
}