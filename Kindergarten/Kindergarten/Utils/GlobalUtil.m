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

+(void)deleteExistDownloadFile
{
    //Document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString* downloadPath = [documentPath stringByAppendingPathComponent:@"DownloadFiles"];
    if([[NSFileManager defaultManager] fileExistsAtPath:downloadPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:downloadPath error:nil];//删除原来
        //重新创建目录
        [[NSFileManager defaultManager] createDirectoryAtPath:downloadPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    else
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:downloadPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
}

@end
