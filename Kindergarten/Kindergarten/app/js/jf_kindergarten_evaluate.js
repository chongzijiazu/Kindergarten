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
