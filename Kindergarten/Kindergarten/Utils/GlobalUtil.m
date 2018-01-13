//
//  GlobalUtil.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/13.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "GlobalUtil.h"

@implementation GlobalUtil

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    NSLog(@"%@",jsonString);
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
