//
//  GlobalUtil.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/13.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalUtil : NSObject

+(NSString*)getAprovePath;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *)jsonStringWithObject:(id)obj;
+(void)deleteExistDownloadFile;
+(void)deleteAssLevelFile;
+(void)deleteLevelHtmlFile;
+(BOOL)deleteAllDocumentsFile;
+(NSString*)getLoginInfoPath;
+(NSString*)getFormulaXMLPathPath;
+(NSString*)getUploadPath;
+(NSString*)getHelpFilePath;
+(NSString*)getDownloadFilesPath;
+(NSString*)getPaperXMLPath;
+(NSString*)getHelpFileDirectPath;
@end

