function logout()
{
    //alert("hello");
    var dicmsg ={
        "operation":"logout",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

function goback()
{
    //alert("goback");
    var dicmsg ={
        "operation":"goback",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

function showLevelQuestion(args)
{
    //alert(args);
    $("#levelQuestion").html(args);
}

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

function pageDown()
{
    //alert("hello");
    var dicmsg ={
        "operation":"pageDown",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

function pageUp()
{
    //alert("hello");
    var dicmsg ={
        "operation":"pageUp",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

function addaprove()
{
    //alert("hello");
    var dicmsg ={
        "operation":"addaprove",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

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

