//
//  EnProcessInfo.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/17.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnProcessInfo.h"
#import "SQLiteManager.h"

@implementation EnProcessInfo

@synthesize fkQuestionid=_fkQuestionid;
@synthesize attachmentpath=_attachmentpath;
@synthesize answer=_answer;

-(instancetype)initWithfkQuestionid:(NSString *)mFKQuestionid andAttachmentPath:(NSString*)mattachmentpath andAnswer:(NSString *)manswer
{
    if (self = [super init]) {
        self.fkQuestionid = mFKQuestionid;
        self.attachmentpath = mattachmentpath;
        self.answer = manswer;
    }
    return self;
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(BOOL)insertSelfToDB{
    //插入对象的SQL语句
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO 'tbl_ass_process' (fkQuestionid,attachmentpath,answer) VALUES ('%@','%@','%@');",self.fkQuestionid,self.attachmentpath,self.answer];
    return [[SQLiteManager shareInstance] execSQL:insertSQL];
}
+(NSArray *)allProcessInfoFromDB{
    //查询表中所有数据的SQL语句
    NSString *SQL = @"SELECT fkQuestion,attachmentpath,answer FROM 'tbl_ass_process'";
    //取出数据库用户表中所有数据
    NSArray *allProcessDictArr = [[SQLiteManager shareInstance] querySQL:SQL];
    NSLog(@"%@",allProcessDictArr);
    //将字典数组转化为模型数组
    NSMutableArray *modelArrM = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in allProcessDictArr) {
        [modelArrM addObject:[[EnProcessInfo alloc] initWithDict:dict]];
    }
    return modelArrM;
}

@end
