//
//  ZipUtil.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/9.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "ZipUtil.h"

@implementation ZipUtil

//根据文件路径，压缩文件（默认压缩文件保存到沙盒的Document文件夹下）
+(BOOL)ZipArchiveWithFiles:(NSString *)zipFileName :(NSArray*)filesPath
{
    //Document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    //为压缩文件的文件名
    zipFileName = [zipFileName stringByAppendingPathExtension:@"zip"];
    //zip压缩包保存路径
    NSString *path = [documentPath stringByAppendingPathComponent:zipFileName];
    //创建不带密码zip压缩包
    BOOL isSuccess = [SSZipArchive createZipFileAtPath:path withFilesAtPaths:filesPath];
    //创建带密码zip压缩包
    //BOOL isSuccess = [SSZipArchive createZipFileAtPath:path withFilesAtPaths:filesPath withPassword:@"SSZipArchive.zip"];
    return isSuccess;
}

//根据文件夹路径，压缩文件夹（默认压缩文件保存到沙盒的Document文件夹下）
+(BOOL)ZipArchiveWithFolder:(NSString *)directoryPath
{
    //Document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    //根据文件夹路径获取文件夹的名称，作为压缩文件的文件名
    NSString* zipFileName = [directoryPath lastPathComponent];
    zipFileName = [zipFileName stringByAppendingPathExtension:@"zip"];
    //压缩包保存路径
    NSString* zipSavePath = [documentPath stringByAppendingPathComponent:zipFileName];
    //创建不带密码zip压缩包
    BOOL isSuccess = [SSZipArchive createZipFileAtPath:zipSavePath withContentsOfDirectory:[documentPath stringByAppendingPathComponent:directoryPath]];
    //创建带密码zip压缩包
    //BOOL isSuccess = [SSZipArchive createZipFileAtPath:path withContentsOfDirectory:folderPath withPassword:@"SSZipArchive.zip"];
    return isSuccess;
}

//根据文件路径，解压文件(默认跟路径为沙盒的Document文件夹)
+(BOOL)UZipArchive:(NSString *)zippedFilePath
{
    //Document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    //解压文件夹名自称
    NSString* uZipName = [[zippedFilePath lastPathComponent] stringByDeletingPathExtension];
    //解压目标路径
    NSString *destinationPath =[documentPath stringByAppendingPathComponent:uZipName];
    //zip压缩包的路径
    NSString *path = [documentPath stringByAppendingPathComponent:zippedFilePath];
    //解压
    BOOL isSuccess = [SSZipArchive unzipFileAtPath:path toDestination:destinationPath];
    return isSuccess;
}
@end
