//
//  EnParam.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/19.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnParam.h"
#import "SQLiteManager.h"

@implementation EnParam
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(BOOL)insertSelfToDB{
    //插入对象的SQL语句
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO 'tbl_param' (keyname,value) VALUES ('%@','%@');",self.keyname,self.value];
    return [[SQLiteManager shareInstance] execSQL:insertSQL];
}
+(NSArray *)allParamFromDB{
    //查询表中所有数据的SQL语句
    NSString *SQL = @"SELECT keyname,value FROM 'tbl_param'";
    //取出数据库用户表中所有数据
    NSArray *allParamDictArr = [[SQLiteManager shareInstance] querySQL:SQL];
    NSLog(@"%@",allParamDictArr);
    //将字典数组转化为模型数组
    NSMutableArray *modelArrM = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in allParamDictArr) {
        [modelArrM addObject:[[EnParam alloc] initWithDict:dict]];
    }
    return modelArrM;
}
@end
