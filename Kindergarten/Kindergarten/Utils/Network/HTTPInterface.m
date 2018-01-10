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
+ (NSString *)login
{
    return [baseUrlString stringByAppendingString:@"login.do"];
}

@end
