
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

function proveItemClick(aproveitemid,aproveitemtype,questionid)
{
    //alert(questionid);
    var param ={
        "type":aproveitemtype,
        "id":aproveitemid,
        "questionid":questionid
    };
    var dicmsg ={
        "operation":"clickaprove",
        "param":param
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
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
    var tContent = $("#"+pkId+"_desc").attr("sdesc");
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
            $("#school_name").html(kindergarteninfo.name);
            $("#thirdlevelname").html(thirdlevelname);
            if(headData.evaluateTimeInfo){
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
}


