//
//  ZipUtil.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/9.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipArchive.h"

@interface ZipUtil : NSObject

//根据一组文件路径，压缩文件
+(BOOL)ZipArchiveWithFiles:(NSString *)zipFileName :(NSArray*)filesPath;

//根据文件夹路径，压缩文件夹
+(BOOL)ZipArchiveWithFolder:(NSString*)directoryPath;

//根据文件路径，解压文件
+(BOOL)UZipArchive:(NSString*)zippedFilePath;

@end
