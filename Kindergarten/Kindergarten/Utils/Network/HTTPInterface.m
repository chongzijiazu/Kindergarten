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

@end
