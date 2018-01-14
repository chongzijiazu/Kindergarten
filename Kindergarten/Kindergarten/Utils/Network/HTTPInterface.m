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
    return [baseUrlString stringByAppendingString:@"loginout.do"];
}

//下载指标数据
+(NSString*)downloadlevelcontent;
{
    //return [baseUrlString stringByAppendingString:@"downloadlevelcontent.do"];
    return @"http://10.3.1.29:8032/msgcat/2.zip";
    //return [NSString stringWithFormat:@"%@%@%@",baseUrlString,@"downloadlevelcontent.do?ticketid=",TICKETID ];
}

//下载评估试卷
+(NSString*)downloadpapercontent;
{
    //return [baseUrlString stringByAppendingString:@"downloadpapercontent.do"];
    return @"http://10.3.1.29:8032/msgcat/2.zip";
    //return [NSString stringWithFormat:@"%@%@%@",baseUrlString,@"downloadpapercontent.do?ticketid=",TICKETID ];
}

//下载公式
+(NSString*)downloadformulacontent
{
    //return [baseUrlString stringByAppendingString:@"downloadformulacontent.do"];
    return @"http://10.3.1.29:8032/msgcat/2.zip";
    //return [NSString stringWithFormat:@"%@%@%@",baseUrlString,@"downloadformulacontent.do?ticketid=",TICKETID ];
}
//下载证据数据
+(NSString*)downloadattachmentcontent
{
    //return [baseUrlString stringByAppendingString:@"downloadattachmentcontent.do"];
    return @"http://10.3.1.29:8032/msgcat/2.zip";
    //return [NSString stringWithFormat:@"%@%@%@",baseUrlString,@"downloadattachmentcontent.do?ticketid=",TICKETID ];
}

@end
