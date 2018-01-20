//
//  EnProcessInfo.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/17.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnProcessInfo : NSObject
{
    NSString* _fkQuestionid;//试题id
    NSString* _attachmentpath;//证据路径
    NSString* _answer;//试题答案
}
@property(strong,nonatomic)NSString* fkQuestionid;
@property(strong,nonatomic)NSString* attachmentpath;
@property(strong,nonatomic)NSString* answer;

-(instancetype)initWithfkQuestionid:(NSString *)mFKQuestionid andAttachmentPath:(NSString*)mattachmentpath andAnswer:(NSString *)manswer;
-(instancetype)initWithDict:(NSDictionary *)dict;
//将本身插入数据库
-(BOOL)insertSelfToDB;
//数据库中所有对象
+(NSArray *)allProcessInfoFromDB;

-(BOOL)deleteAttachmentPathByQuestionId:(NSString*)mquestionid andNeedDeletedAttachmentPath:(NSString*)attachmentPath;
+(BOOL)saveQuestionAnswer:(NSDictionary*)dicQuesAns;

+(BOOL)isFinished:(NSString*)questionid;
+(NSString*)toJsonProcessInfo;

@end
