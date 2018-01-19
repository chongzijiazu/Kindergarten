//
//  Base64Util.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/19.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "Base64Util.h"

@implementation Base64Util

+(NSString*)Encode:(NSString*)str
{
    NSData *nsdata = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    return base64Encoded;
}

+(NSString*)Decode:(NSString*)str
{
    NSData *nsdataFromBase64String = [[NSData alloc]initWithBase64EncodedString:str options:0];
    NSString *base64Decoded = [[NSString alloc] initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    return base64Decoded;
}

@end
