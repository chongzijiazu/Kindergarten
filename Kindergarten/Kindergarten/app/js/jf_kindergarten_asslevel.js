function logout()
{
    alert("hello");
    window.webkit.messageHandlers.AppModel.postMessage({body: 'logout'});
}
