//
//  SQLiteManager.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/17.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLiteManager : NSObject

//类方法生成单例对象
+(instancetype)shareInstance;
//打开数据库
-(BOOL)openDB;
//执行SQL语句
-(BOOL)execSQL:(NSString *)SQL;
//获取表中数据
-(NSArray *)querySQL:(NSString *)SQL;

@end
