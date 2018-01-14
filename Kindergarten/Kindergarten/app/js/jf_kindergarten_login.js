function hello()
{
    //alert("hello");
    var edt_account=document.getElementById("edt_account");
    var edt_password=document.getElementById("edt_password");
    var params = {
        "username":edt_account.value,
        "password":edt_password.value
    };

    //将用户名、密码传递到OC代码中，调用接口进行登录
    window.webkit.messageHandlers.AppModel.postMessage(params);
}

function alertLoginResult(args)
{
    alert(args);
}
