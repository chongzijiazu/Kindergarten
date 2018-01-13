function hello()
{
    alert("hello");
    var edt_account=document.getElementById("edt_account");
    var edt_password=document.getElementById("edt_password");
    //将用户名、密码传递到OC代码中，调用接口进行登录
CallEachModel.jsCallOCWithTitleMessage(edt_account.value,edt_password.value)
}
