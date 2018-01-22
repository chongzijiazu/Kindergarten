//
//  GlobalUtil.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/13.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "GlobalUtil.h"

@implementation GlobalUtil

//证据文件夹路径
+(NSString*)getAprovePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"aprove"];
    NSFileManager* fileM = [NSFileManager defaultManager];
    if (![fileM fileExistsAtPath:documentsDirectory])
    {
        [fileM createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentsDirectory;
}

//公式文件路径路径
+(NSString*)getFormulaXMLPathPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"DownloadFiles"];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"formula.xml"];
    
    return documentsDirectory;
}

//登录成功信息文件路径（院所、系统配置等）
+(NSString*)getLoginInfoPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"LoginInfo"];
    NSFileManager* fileM = [NSFileManager defaultManager];
    if (![fileM fileExistsAtPath:documentsDirectory])
    {
        [fileM createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"loginfo.txt"];
    return documentsDirectory;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    //NSLog(@"%@",jsonString);
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

//清理按三级指标分类的html文件
+(void)deleteLevelHtmlFile
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString* asslevelPath = [documentPath stringByAppendingPathComponent:@"assLevel"];
    if([[NSFileManager defaultManager] fileExistsAtPath:asslevelPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:asslevelPath error:nil];//删除原来
    }
}

//清理
+(void)deleteAssLevelFile
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString* levelhtml = [documentPath stringByAppendingPathComponent:@"levelhtml"];
    if([[NSFileManager defaultManager] fileExistsAtPath:levelhtml])
    {
        [[NSFileManager defaultManager] removeItemAtPath:levelhtml error:nil];//删除原来
    }
}

//清理所有数据
+(BOOL)deleteAllDocumentsFile
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    if([[NSFileManager defaultManager] fileExistsAtPath:documentPath])
    {
        return [[NSFileManager defaultManager] removeItemAtPath:documentPath error:nil];
    }
    return true;
}

//上传文件夹路径
+(NSString*)getUploadPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Upload"];
    NSFileManager* fileM = [NSFileManager defaultManager];
    if (![fileM fileExistsAtPath:documentsDirectory])
    {
        [fileM createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentsDirectory;
}

//帮助文件路径
+(NSString*)getHelpFilePath
{
    NSFileManager* fileM = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"helpfile"];
    if (![fileM fileExistsAtPath:documentsDirectory]) {
        [fileM createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSArray* helpfileArra = [fileM contentsOfDirectoryAtPath: documentsDirectory error:nil];
    if (helpfileArra!=nil && helpfileArra.count>0) {
        NSString* tmp =  [documentsDirectory stringByAppendingPathComponent:helpfileArra[0]];
        return tmp;
    }
    
    return nil;
}

//帮助文件夹路径
+(NSString*)getHelpFileDirectPath
{
    NSFileManager* fileM = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"helpfile"];
    if (![fileM fileExistsAtPath:documentsDirectory]) {
        [fileM createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return documentsDirectory;
}

//获取下载资源路径
+(NSString*)getDownloadFilesPath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString* downloadPath = [documentPath stringByAppendingPathComponent:@"DownloadFiles"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:downloadPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:downloadPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return downloadPath;
}

//获取解压后的paper.xml文件路径
+(NSString*)getPaperXMLPath
{
    NSString* downloadfilePath = [self getDownloadFilesPath];
    return [downloadfilePath stringByAppendingPathComponent:@"paper.xml"];
}

@end

