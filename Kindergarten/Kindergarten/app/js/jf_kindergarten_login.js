function mb_user_login()
{
    //alert("hello");
    var edt_account=document.getElementById("edt_account");
    var edt_password=document.getElementById("edt_password");
    var params = {
        "username":edt_account.value,
        "password":edt_password.value
    };
    
    var dicmsg ={
        "operation":"login",
        "param":params
    };
    //将用户名、密码传递到OC代码中，调用接口进行登录
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

function alertLoginResult(args)
{
    alert(args);
}

function online_login()
{
    var dicmsg ={
        "operation":"logonline",
        "param":""
    };
    //将用户名、密码传递到OC代码中，调用接口进行登录
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

//显示历史登录成功的账号
function showAccounts(historyAccounts)
{
    //alert(historyAccounts[historyAccounts.length-1]);
    if(historyAccounts)
    {
        $("#edt_account").typeahead({
                                    source: historyAccounts
                                    });
        
        var lastAccount = historyAccounts[historyAccounts.length-1];
        $("#edt_account").val(lastAccount);
    }
}
