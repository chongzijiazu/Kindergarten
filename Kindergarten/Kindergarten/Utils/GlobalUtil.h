//
//  GlobalUtil.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/13.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalUtil : NSObject
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+(void)deleteExistDownloadFile;
+(void)deleteAssLevelFile;
+(void)deleteLevelHtmlFile;
+(BOOL)deleteAllDocumentsFile;
@end
