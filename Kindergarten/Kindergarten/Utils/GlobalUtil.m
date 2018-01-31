//
//  GlobalUtil.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/13.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "GlobalUtil.h"

@implementation GlobalUtil

//获取数据库文件路径
+(NSString*)getDBPath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    if(![[NSFileManager defaultManager] fileExistsAtPath:documentPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *DBPath = [documentPath stringByAppendingPathComponent:@"KGDB.sqlite"];
    return DBPath;
}

//证据文件夹路径
+(NSString*)getAprovePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"aproves"];
    NSFileManager* fileM = [NSFileManager defaultManager];
    if (![fileM fileExistsAtPath:documentsDirectory])
    {
        [fileM createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentsDirectory;
}

//证据文件项文件夹路径
+(NSString*)getAproveItemPath
{
    NSString* aprovesPath = [self getAprovePath];
    NSString* aproveitemPath = [aprovesPath stringByAppendingPathComponent:@"proves"];
    NSFileManager* fileM = [NSFileManager defaultManager];
    if (![fileM fileExistsAtPath:aproveitemPath])
    {
        [fileM createDirectoryAtPath:aproveitemPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return aproveitemPath;
}

//公式文件路径路径
+(NSString*)getFormulaXMLPathPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"DownloadFiles"];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"formula/formula.xml"];
    
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

//上传文件夹压缩路径
+(NSString*)getUploadZipPath
{
    NSString *documentsDirectory = [self getUploadPath];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"content"];
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
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"help"];
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
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"help"];
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
    return [downloadfilePath stringByAppendingPathComponent:@"paper/paper.xml"];
}

//获取解压后的level.xml文件路径
+(NSString*)getLevelXMLPath
{
    NSString* downloadfilePath = [self getDownloadFilesPath];
    return [downloadfilePath stringByAppendingPathComponent:@"level/level.xml"];
}

//获取account.txt账户文件路径
+(NSString*)getAccountFilePath
{
    // 获取Caches目录路径
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString* accountPath = [cachesDir stringByAppendingPathComponent:@"account.txt"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:accountPath]) {
        [[NSFileManager defaultManager] createFileAtPath:accountPath contents:nil attributes:nil];
    }
    return accountPath;
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

+ (NSString *)jsonStringWithObject:(id)obj
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
    if (data == nil) {
        return nil;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

//获取路径下的文件大小
+(long long) fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager =[NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil]fileSize];
    }
    return 0;
}

@end

