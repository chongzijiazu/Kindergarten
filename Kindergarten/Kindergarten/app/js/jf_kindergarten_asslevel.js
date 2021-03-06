function logout()
{
    //alert("hello");
    var dicmsg ={
        "operation":"logout",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

function showQuestion(thirdLevelid,thirdLevelName)
{
    //alert(thirdLevelName);
    var params={
        "thirdlevelid":thirdLevelid,
        "thirdlevelname":thirdLevelName
    };
    //alert(thirdLevelid);
    var dicmsg ={
        "operation":"showQuestion",
        "param":params
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

function uploadData()
{
    //alert("hello");
    var dicmsg ={
        "operation":"uploadData",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

function showLevelTable(data){
    //data = '[{"fid":"001","fname":"A1办园条件","sid":"001001","sname":"B1办园资质","tid":"001001001","tname":"C1办园许可"}]';
    //alert(data);
    var arrayData = eval("(" + data + ")");
    var dataHtml = "";
    for(var i = 0; i<arrayData.length;i++){
        var level = arrayData[i];
        var row = '<tr> <td onclick=showQuestion(\"'+level.tid+'\",\"'+level.tname+'\"); id="'+level.fid+'" style="background-color:#EBF7C2;padding-left:5%;">'+level.fname+'</td> ';
        row += '<td <td onclick=showQuestion(\"'+level.tid+'\",\"'+level.tname+'\"); id='+level.sid+' style="background-color:#FDFFF5;padding-left:8%;">'+level.sname+'</td>';
        row += '<td onclick=showQuestion(this.id,\"'+level.tname+'\"); id='+level.tid+' style="background-color:#FEF0FA;padding-left:20%;">'+level.tname+'</td>';
        row += '<td id=\"'+level.tid+'_finish\" '+'style="background-color:#FEFBFD;text-align:center;"><img src="images/finish.png"></img></td>';
        row += '</tr>';
        dataHtml += row;
    }
    $("#asslevelid").html(dataHtml);
    //alert(dataHtml);
    
    mergin("levelTableId","0");
    mergin("levelTableId","1");
}

function refreshFinished(thirdLevelidArray)
{
    //alert(thirdLevelidArray);
    if(thirdLevelidArray)
    {
        for(var i=0;i<thirdLevelidArray.length;i++)
        {
            if(thirdLevelidArray[i].result.length>0)
            {
                if(thirdLevelidArray[i].result!=0)
                {
                    var imgfinishid=thirdLevelidArray[i].thirdlevelid+"_finish";
                    var td = document.getElementById(imgfinishid);
                    //alert(td);
                    td.innerHTML = "";
                }
            }
            else
            {
                var imgfinishid=thirdLevelidArray[i].thirdlevelid+"_finish";
                var td = document.getElementById(imgfinishid);
                //alert(td);
                td.innerHTML = "";
            }
            
        }
        
    }
}

function calculateFormula(dicFormula)
{
    //alert(dicFormula);
    if(dicFormula)
    {
        var params={};
        var base = new Base64();
        for(var key in dicFormula)
        {
            var expression = base.decode(dicFormula[key]);
            //alert(expression);
            try
            {
                var value = eval('(function(){'+expression+'})()');
                //alert(value);
                params[key]=value;
            }
            catch(err)
            {
                //alert(err);
            }
        }
        //alert(params);
        var dicmsg ={
            "operation":"calculateFormula",
            "param":params
        };
        window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
    }
}

function mergin(tableid,column)
{
    var tr = document.getElementById(tableid);
    for(var i=1; i<tr.rows.length; i++){
        var f = i-1;
        var up = tr.rows[f].cells[column];
        var down = tr.rows[i].cells[column];
        if(up.innerHTML == down.innerHTML) {
            var rs = 1;
            while(down && up.innerHTML == down.innerHTML){
                down.style.display="none";
                rs++;
                i++;
                if(i<tr.rows.length)
                    down = tr.rows[i].cells[column];
                else
                    down = undefined;
            }
            up.rowSpan = rs;
        }
    }
}


function loadPageData(pageData){
    
    if(pageData){
        var headData = pageData;
        if(headData){
            var kindergarteninfo = headData.kindergarteninfo;
            //kindergarteninfo = eval("(" + kindergarteninfo + ")");
            for (var key in kindergarteninfo){
                //alert(kindergarteninfo[key]);
                $("#"+key).html(kindergarteninfo[key]);
            }
            $("#school_name").html(kindergarteninfo.name);
            calculateBaseInfo();
            var personInfo = headData.personInfo;
            for (var pinfo in personInfo) {
                //alert(pinfo);
                $("#s" + pinfo).html(personInfo[pinfo]);
            }
            if(headData.evaluateTimeInfo){
                //alert(pageData.kindergarteninfo["address"]);
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
    
    var info55 = $("#info55").html();
    if(info55 != ""){
        if(parseInt(info55) == 0 ){
            $("#info55").html("否");
        }else{
            $("#info55").html("是");
        }
    }
    
    var info47 = $("#info47").html();
    if(info47 != ""){
        if(parseInt(info47) == 0 ){
            $("#info47").html("否");
        }else{
            $("#info47").html("是");
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

function openHelp()
{
    //alert("hello");
    var dicmsg ={
        "operation":"openHelpFile",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

//根据题号滚动到该试题
function scrollToLevel(levelid)
{
    //alert(levelid);
    if(levelid)
    {
        $("html,body").animate({scrollTop: $("td[id = '"+levelid+"']").offset().top}, 800);
    }
}

