function logout()
{
    //alert("hello");
    var dicmsg ={
        "operation":"logout",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

function showQuestion(thirdLevelid)
{
    //alert(thirdLevelid);
    var dicmsg ={
        "operation":"showQuestion",
        "param":thirdLevelid
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

function uploadData()
{
    //alert("hello");
    var dicmsg ={
        "operation":"uploadData",
        "param":""
    };
    window.webkit.messageHandlers.AppModel.postMessage(dicmsg);
}

function showLevelTable(data){
    //data = '[{"fid":"001","fname":"A1办园条件","sid":"001001","sname":"B1办园资质","tid":"001001001","tname":"C1办园许可"}]';
    //alert(data);
    var arrayData = eval("(" + data + ")");
    var dataHtml = "";
    for(var i = 0; i<arrayData.length;i++){
        var level = arrayData[i];
        var row = '<tr> <td id="'+level.fid+'" style="background-color:#EBF7C2;padding-left:5%;">'+level.fname+'</td> ';
        row += '<td id='+level.sid+' style="background-color:#FDFFF5;padding-left:8%;">'+level.sname+'</td>';
        row += '<td onclick=showQuestion(this.id); id='+level.tid+' style="background-color:#FEF0FA;padding-left:20%;">'+level.tname+'</td>';
        row += '<td style="background-color:#FEFBFD;text-align:center;"><img src="images/finish.png"></img></td>';
        row += '</tr>';
        dataHtml += row;
    }
    $("#asslevelid").html(dataHtml);
    
    mergin("levelTableId","0");
    mergin("levelTableId","1");
}
