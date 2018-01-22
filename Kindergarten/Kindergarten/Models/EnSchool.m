//
//  EnSchool.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/19.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnSchool.h"
#import "SQLiteManager.h"

@implementation EnSchool

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(NSArray *)allSchoolFromDB
{
    //查询表中所有数据的SQL语句
    NSString *SQL = @"SELECT * FROM 'tbl_school'";
    //取出数据库用户表中所有数据
    NSArray *allSchoolDictArr = [[SQLiteManager shareInstance] querySQL:SQL];
    
    return allSchoolDictArr;
}

+(NSDictionary*)loadSchoolInfoToDBFromFile
{
    NSString* loginfoPath = [GlobalUtil getLoginInfoPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:loginfoPath]) {
        return false;
    }
    else
    {
        NSString* strLoginfo = [NSString stringWithContentsOfFile:loginfoPath encoding:NSUTF8StringEncoding error:nil];
        NSDictionary* dicLoginfo = [GlobalUtil dictionaryWithJsonString:strLoginfo];
        //NSLog(@"%@",[dicLoginfo objectForKey:@"idcode"]);
        if (dicLoginfo!=nil && dicLoginfo.count>0) {
            NSDictionary* dicSchool = [dicLoginfo objectForKey:@"kindergarteninfo"];
            return dicSchool;
        }
        else
        {
            return nil;
        }
    }
    return nil;
}

@end
