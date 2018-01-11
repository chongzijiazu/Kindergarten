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

//下载指标数据
+(NSString*)downloadlevelcontent;
{
    return [baseUrlString stringByAppendingString:@"downloadlevelcontent.do"];
}

//下载评估试卷
+(NSString*)downloadpapercontent;
{
    return [baseUrlString stringByAppendingString:@"downloadpapercontent.do"];
}

//下载公式
+(NSString*)downloadformulacontent
{
    return [baseUrlString stringByAppendingString:@"downloadformulacontent.do"];}

//下载证据数据
+(NSString*)downloadattachmentcontent
{
    return [baseUrlString stringByAppendingString:@"downloadattachmentcontent.do"];
}

@end
