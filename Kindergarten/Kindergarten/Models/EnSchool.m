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

//是否包含公式中的元素
-(NSString*)replaceFormulaElement:(NSString*)fromulaElement
{
    //NSLog(@"%@",self.info15)
    return @"";
}


@end
