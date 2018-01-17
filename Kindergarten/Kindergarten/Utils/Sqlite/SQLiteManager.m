//
//  SQLiteManager.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/17.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "SQLiteManager.h"
#import <sqlite3.h>

@interface SQLiteManager ()
@property (nonatomic,assign) sqlite3 *db;
@end

@implementation SQLiteManager

static SQLiteManager *instance;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - 打开/创建数据库
-(BOOL)openDB{
    //app内数据库文件存放路径-一般存放在沙盒中
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    if(![[NSFileManager defaultManager] fileExistsAtPath:documentPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *DBPath = [documentPath stringByAppendingPathComponent:@"KGDB.sqlite"];
    //创建(指定路径不存在数据库文件)/打开(已存在数据库文件) 数据库文件
    //sqlite3_open(<#const char *filename#>, <#sqlite3 **ppDb#>)  filename:数据库路径  ppDb:数据库对象
    if (sqlite3_open(DBPath.UTF8String, &_db) != SQLITE_OK) {
        //数据库打开失败
        return NO;
    }else{
        //打开成功创建表
        return [self creatTable];
    }
}
-(BOOL)creatTable{
    //创建表的SQL语句
    //评估过程表
    NSString *creatProcessTable = @"CREATE TABLE IF NOT EXISTS 'tbl_ass_process' ( 'fkQuestionid' TEXT NOT NULL PRIMARY KEY,'attachmentpath' TEXT,'answer' TEXT);";
    
    //评估试题表
    NSString *creatQuestionTable = @"CREATE TABLE IF NOT EXISTS 'tbl_ass_quesstion' ( 'pkId' TEXT NOT NULL PRIMARY KEY,'fkLevel' TEXT,'seqLevel' TEXT,'fkFormula' TEXT,'contenttip' TEXT,'content' TEXT,'description' TEXT,'seq' INTEGER,'type' INTEGER,'weight' REAL,'veto' INTEGER,'appendprove' INTEGER,'calculated' INTEGER,'deleted' INTEGER,'questionnum' INTEGER);";
    
    //试题选项表
    NSString *creatOptionTable = @"CREATE TABLE IF NOT EXISTS 'tbl_ass_question_option' ( 'pkId' TEXT NOT NULL PRIMARY KEY,'optionValue' TEXT,'content' TEXT,'fkQuestion' TEXT,'weight' REAL);";
    
    //项目中一般不会只有一个表
    NSArray *SQL_ARR = [NSArray arrayWithObjects:creatProcessTable,creatQuestionTable,creatOptionTable, nil];
    return [self creatTableExecSQL:SQL_ARR];
}
-(BOOL)creatTableExecSQL:(NSArray *)SQL_ARR{
    for (NSString *SQL in SQL_ARR) {
        if (![self execSQL:SQL]) {
            return NO;
        }
    }
    return YES;
}
#pragma 执行SQL语句
-(BOOL)execSQL:(NSString *)SQL{
    char *error;
    if (sqlite3_exec(self.db, SQL.UTF8String, nil, nil, &error) == SQLITE_OK) {
        return YES;
    }else{
        NSLog(@"SQLiteManager执行SQL语句出错:%s",error);
        return NO;
    }
}
#pragma mark - 查询数据库中数据
-(NSArray *)querySQL:(NSString *)SQL{
    sqlite3_stmt *stmt = nil;
    if (sqlite3_prepare_v2(self.db, SQL.UTF8String, -1, &stmt, nil) != SQLITE_OK) {
        NSLog(@"准备查询失败!");
        return NULL;
    }
    //准备成功,开始查询数据
    //定义一个存放数据字典的可变数组
    NSMutableArray *dictArrM = [[NSMutableArray alloc] init];
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        //一共获取表中所有列数(字段数)
        int columnCount = sqlite3_column_count(stmt);
        //定义存放字段数据的字典
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < columnCount; i++) {
            // 取出i位置列的字段名,作为字典的键key
            const char *cKey = sqlite3_column_name(stmt, i);
            NSString *key;
            if (cKey==NULL)
            {
                key=@"";
            }
            else
            {
                key = [NSString stringWithUTF8String:cKey];
            }
            
            
            //取出i位置存储的值,作为字典的值value
            const char *cValue = (const char *)sqlite3_column_text(stmt, i);
            NSString *value;
            if (cValue==NULL)
            {
                value=@"";
            }
            else
            {
                value = [NSString stringWithUTF8String:cValue];
            }
            
            //将此行数据 中此字段中key和value包装成 字典
            [dict setObject:value forKey:key];
        }
        [dictArrM addObject:dict];
    }
    return dictArrM;
}

@end
