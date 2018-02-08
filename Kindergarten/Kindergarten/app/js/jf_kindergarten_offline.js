function refresh()
{
    var dicmsg ={
        "operation":"refresh",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}
