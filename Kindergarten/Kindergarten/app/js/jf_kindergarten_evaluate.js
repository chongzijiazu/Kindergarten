
//退出操作
function logout()
{
    //alert("hello");
    var dicmsg ={
        "operation":"logout",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

//返回操作
function goback()
{
    saveQuestionAnswer();//返回操作时，保存答案
    //alert("goback");
    var dicmsg ={
        "operation":"goback",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

//显示试题
function showLevelQuestion(args)
{
    //alert(args);
    $("#levelQuestion").html(args);
    //decodeViewBase64();
}

//显示试题答案
function showLevelAnswer(args)
{
    //alert(args);
    var arrayData = eval("(" + args + ")");
    for(var i = 0; i<arrayData.length;i++){
        var QA = arrayData[i];
        //alert(QA);
        if(QA.optionid.length>0)
        {
            var op = document.getElementById(QA.optionid);
            op.checked=true;
            op.tag=1;
            //将有答案的的试题标记为已完成
            showFinished(op);
        }
    }
}

//显示试题证据
function showLevelAprove(arrayData)
{
    //alert(arrayData);
    for(var i = 0; i<arrayData.length;i++){
        var QA = arrayData[i];
        if(QA.aproveid.length>0)
        {
            var aprove = document.getElementById(QA.aproveid);
            aprove.innerHTML = QA.aproveitem;
        }
    }
}

//显示试题说明
function showLevelMemo(arrayData)
{
    //alert(arrayData);
    for(var i = 0; i<arrayData.length;i++){
        var QA = arrayData[i];
        if(QA.memoid.length>0)
        {
            //alert(QA.memoid);
            var memo = document.getElementById(QA.memoid+"_memo");
            memo.innerText = QA.memocontent;
        }
    }
}

//下一页操作
function pageDown()
{
    saveQuestionAnswer();//下一页操作时，保存答案
    //alert("hello");
    var dicmsg ={
        "operation":"pageDown",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

//上一页操作
function pageUp()
{
    saveQuestionAnswer();//上一页操作时，保存答案
    //alert("hello");
    var dicmsg ={
        "operation":"pageUp",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

//添加证据操作
function addaprove()
{
    //alert("hello");
    var dicmsg ={
        "operation":"addaprove",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

//选项单击取反
function optionClicked(obj)
{
    //alert(obj.tag);
    var radio=obj;
    if (radio.tag==1)
    {
        hideFinished(radio);
        radio.checked=false;
        radio.tag=0;
        //取消选中将答案设置为空
        var param={};
        param[radio.name]="";
        var dicmsg ={
            "operation":"saveAnswer",
            "param":param
        };
        window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
    }
    else
    {
        showFinished(radio);
        radio.checked=true;
        radio.tag=1
    }
    //alert(obj.checked);
}

function hideFinished(obj)
{
    var radio = obj;
    var fid = "quesFinish_"+radio.name;
    var font = document.getElementById(fid);
    font.style.display = "none";
}

function showFinished(obj)
{
    var radio = obj;
    var fid = "quesFinish_"+radio.name;
    var font = document.getElementById(fid);
    font.style.display = "inline";
}

function proveItemClick(aproveitemid,aproveitemtype,questionid,fklevel)
{
    var isChosen = isQuestionChosen(questionid);//判断是否已做答
    //alert(questionid);
    if(isChosen)
    {
        var param ={
            "type":aproveitemtype,
            "id":aproveitemid,
            "questionid":questionid,
            "fklevel":fklevel
        };
        var dicmsg ={
            "operation":"clickaprove",
            "param":param
        };
        window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
    }
    else
    {
        alert("该试题尚未作答，不允许添加证据。");
    }
}

//判断当前题是否已选择选项
function isQuestionChosen(questionid)
{
    var options = $("input[name='"+questionid+"']");
    if(options)
    {
        for(var i=0;i<options.length;i++)
        {
            if(options[i].checked)
            {
                return true;
            }
        }
        return false;
    }
}


function showAlertMessage(msg)
{
    alert(msg);
}

//保存当前页面答案
function saveQuestionAnswer()
{
    var checkedEles = $("input[type='radio']:checked");
    if(checkedEles)
    {
        var param={};
        for(var i=0;i<checkedEles.length;i++)
        {
            param[checkedEles[i].name]=checkedEles[i].value;
        }
        var dicmsg ={
            "operation":"saveAnswer",
            "param":param
        };
        window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
    }
    
    //保存答案的时候，同时保存说明信息
    var memoEles = $("textarea");
    if(memoEles)
    {
        var txtparam={};
        for(var i=0;i<memoEles.length;i++)
        {
            txtparam[memoEles[i].id]=memoEles[i].value;
        }
        var dicmsg ={
            "operation":"saveMemo",
            "param":txtparam
        };
        window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
    }
}

//查看试题描述信息
function showQuesDesc(pkId)
{
    var idArr= pkId.split("_");
    pkId=idArr[0];
    var base = new Base64();
    var tContent = $("#"+pkId+"_desc").attr("sdesc");
    tContent=base.decode(tContent);
    tContent = tContent.replace(/NEW_LINE/g, '<br/>');
    $("#tipModalBody").html(tContent);
    $('#tipModal').modal({show:true,backdrop:false,keyboard:false});
}

function loadBaseInfo(pageData,thirdlevelname){
    //alert(thirdlevelname);
    if(pageData){
        var headData = pageData;
        if(headData){
            var kindergarteninfo = headData.kindergarteninfo;
            //kindergarteninfo = eval("(" + kindergarteninfo + ")");
            for (var key in kindergarteninfo){
                $("#"+key).html(kindergarteninfo[key]);
            }
            calculateBaseInfo();
            
            var personInfo = headData.personInfo;
            for (var pinfo in personInfo) {
                $("#s" + pinfo).html(personInfo[pinfo]);
            }
            $("#school_name").html(kindergarteninfo.name);
            $("#thirdlevelname").html(thirdlevelname);
            if(headData.evaluateTimeInfo){
                //alert(headData.evaluateTimeInfo.beginTime);
                $("#eva_starttime").html(headData.evaluateTimeInfo.beginTime);
                $("#eva_endtime").html(headData.evaluateTimeInfo.endTime);
            }
        }
    }
}

function calculateBaseInfo(){
    var infosum1 = 0;
    if(!isNaN(parseInt($("#info15").html()))){
        infosum1 += parseInt($("#info15").html());
    }
    if(!isNaN(parseInt($("#info16").html()))){
        infosum1 += parseInt($("#info16").html());
    }if(!isNaN(parseInt($("#info17").html()))){
        infosum1 += parseInt($("#info17").html());
    }if(!isNaN(parseInt($("#info18").html()))){
        infosum1 += parseInt($("#info18").html());
    }
    $("#infosum1").html(infosum1);
    
    var infosum2 = 0;
    if(!isNaN(parseInt($("#info20").html()))){
        infosum2 += parseInt($("#info20").html());
    }
    if(!isNaN(parseInt($("#info21").html()))){
        infosum2 += parseInt($("#info21").html());
    }if(!isNaN(parseInt($("#info22").html()))){
        infosum2 += parseInt($("#info22").html());
    }if(!isNaN(parseInt($("#info23").html()))){
        infosum2 += parseInt($("#info23").html());
    }
    $("#infosum2").html(infosum2);
    
    var infosum3 = 0;
    if(!isNaN(parseInt($("#info25").html()))){
        infosum3 += parseInt($("#info25").html());
    }
    if(!isNaN(parseInt($("#info26").html()))){
        infosum3 += parseInt($("#info26").html());
    }if(!isNaN(parseInt($("#info27").html()))){
        infosum3 += parseInt($("#info27").html());
    }if(!isNaN(parseInt($("#info28").html()))){
        infosum3 += parseInt($("#info28").html());
    }
    if(!isNaN(parseInt($("#info29").html()))){
        infosum3 += parseInt($("#info29").html());
    }
    $("#infosum3").html(infosum3);
    
    var infosum4 = 0;
    if(!isNaN(parseFloat($("#info44").html()))){
        infosum4 += parseFloat($("#info44").html());
    }
    if(!isNaN(parseFloat($("#info45").html()))){
        infosum4 += parseFloat($("#info45").html());
    }
    $("#infosum4").html(infosum4);
    
    var isprivate = $("#isprivate").html();
    if(isprivate != ""){
        if(parseInt(isprivate) == 0 ){
            $("#isprivate").html("否");
        }else if(parseInt(isprivate) == 1){
            $("#isprivate").html("是");
        }
    }
    
    var isprivate = $("#isprivate").html();
    if(isprivate != ""){
        if(parseInt(isprivate) == 0 ){
            $("#isprivate").html("否");
        }else if(parseInt(isprivate) == 1){
            $("#isprivate").html("是");
        }
    }
    
    var iscenter = $("#iscenter").html();
    if(iscenter != ""){
        if(parseInt(iscenter) == 0 ){
            $("#iscenter").html("否");
        }else if(parseInt(iscenter) == 1){
            $("#iscenter").html("是");
        }
    }
    
    var info47 = $("#info47").html();
    if(info47 != ""){
        if(parseInt(info47) == 0 ){
            $("#info47").html("否");
        }else if(parseInt(info47) == 1){
            $("#info47").html("是");
        }
    }
    
}

function decodeViewBase64()
{
    
    var allRadio = $("label[base64='true']");
    alert(allRadio.length);
    if(allRadio)
    {
        var base = new Base64();
        for(var i=0;i<allRadio.length;i++)
        {
            //alert(allRadio[i].innerText);
            allRadio[i].innerText = base.decode(allRadio[i].innerText);
        }
    }
}

function Base64() {
    // private property
    _keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    // public method for encoding
    this.encode = function (input) {
        var output = "";
        var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
        var i = 0;
        input = _utf8_encode(input);
        while (i < input.length) {
            chr1 = input.charCodeAt(i++);
            chr2 = input.charCodeAt(i++);
            chr3 = input.charCodeAt(i++);
            enc1 = chr1 >> 2;
            enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
            enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
            enc4 = chr3 & 63;
            if (isNaN(chr2)) {
                enc3 = enc4 = 64;
            } else if (isNaN(chr3)) {
                enc4 = 64;
            }
            output = output +
            _keyStr.charAt(enc1) + _keyStr.charAt(enc2) +
            _keyStr.charAt(enc3) + _keyStr.charAt(enc4);
        }
        return output;
    }
    
    // public method for decoding
    this.decode = function (input) {
        var output = "";
        var chr1, chr2, chr3;
        var enc1, enc2, enc3, enc4;
        var i = 0;
        input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
        while (i < input.length) {
            enc1 = _keyStr.indexOf(input.charAt(i++));
            enc2 = _keyStr.indexOf(input.charAt(i++));
            enc3 = _keyStr.indexOf(input.charAt(i++));
            enc4 = _keyStr.indexOf(input.charAt(i++));
            chr1 = (enc1 << 2) | (enc2 >> 4);
            chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
            chr3 = ((enc3 & 3) << 6) | enc4;
            output = output + String.fromCharCode(chr1);
            if (enc3 != 64) {
                output = output + String.fromCharCode(chr2);
            }
            if (enc4 != 64) {
                output = output + String.fromCharCode(chr3);
            }
        }
        output = _utf8_decode(output);
        return output;
    }
    
    // private method for UTF-8 encoding
    _utf8_encode = function (string) {
        string = string.replace(/\r\n/g,"\n");
        var utftext = "";
        for (var n = 0; n < string.length; n++) {
            var c = string.charCodeAt(n);
            if (c < 128) {
                utftext += String.fromCharCode(c);
            } else if((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            } else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }
            
        }
        return utftext;
    }
    
    // private method for UTF-8 decoding
    _utf8_decode = function (utftext) {
        var string = "";
        var i = 0;
        var c = c1 = c2 = 0;
        while ( i < utftext.length ) {
            c = utftext.charCodeAt(i);
            if (c < 128) {
                string += String.fromCharCode(c);
                i++;
            } else if((c > 191) && (c < 224)) {
                c2 = utftext.charCodeAt(i+1);
                string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                i += 2;
            } else {
                c2 = utftext.charCodeAt(i+1);
                c3 = utftext.charCodeAt(i+2);
                string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                i += 3;
            }
        }
        return string;
    }
}

function openHelpFile()
{
    //alert("hello");
    var dicmsg ={
        "operation":"openHelpFile",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

