function reload()
{
    var dicmsg ={
        "operation":"refresh",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}
