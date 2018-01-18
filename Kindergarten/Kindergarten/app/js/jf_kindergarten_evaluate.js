
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
    var radio=obj;
    if (radio.tag==1)
    {
        radio.checked=false;
        radio.tag=0;
    }
    else
    {
        radio.checked=true;
        radio.tag=1
    }
    //alert(obj.checked);
}



