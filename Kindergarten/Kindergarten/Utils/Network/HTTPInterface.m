//
//  HTTPInterface.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "HTTPInterface.h"

@implementation HTTPInterface

//登录
+(NSString*)login
{
    return [baseUrlString stringByAppendingString:@"login.do"];
}

//登出
+(NSString*)logout
{
    //return [baseUrlString stringByAppendingString:@"loginout.do"];
    return [NSString stringWithFormat:@"%@%@%@",baseUrlString,@"loginout.do?ticketid=",TICKETID];
}

//获取评估信息
+(NSString*)processinfo
{
    return [NSString stringWithFormat:@"%@%@%@",baseUrlString,@"getprocessinfo.do?ticketid=",TICKETID ];
}

//下载指标数据
+(NSString*)downloadlevelcontent;
{
    return [NSString stringWithFormat:@"%@%@%@",baseUrlString,@"downloadlevelcontent.do?ticketid=",TICKETID ];
}

//下载评估试卷
+(NSString*)downloadpapercontent;
{
    return [NSString stringWithFormat:@"%@%@%@",baseUrlString,@"downloadpapercontent.do?ticketid=",TICKETID ];
}

//下载公式
+(NSString*)downloadformulacontent
{
    return [NSString stringWithFormat:@"%@%@%@",baseUrlString,@"downloadformulacontent.do?ticketid=",TICKETID ];
}
//下载证据数据
+(NSString*)downloadattachmentcontent
{
    return [NSString stringWithFormat:@"%@%@%@",baseUrlString,@"downloadattachmentcontent.do?ticketid=",TICKETID ];
}

//下载帮助文档
+(NSString*)downloadhelpfile
{
    //return @"http://10.3.1.29:8032/msgcat/2.zip";
    return [NSString stringWithFormat:@"%@%@%@",baseUrlString,@"downloadhelpdoc.do?ticketid=",TICKETID ];
}

//上传评估数据
+(NSString*)uploadevaluatedata;
{
    return [NSString stringWithFormat:@"%@%@",baseUrlString,@"uploadevaluatedata.do"];
}

@end

