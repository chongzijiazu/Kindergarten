//
//  EnOption.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/14.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnOption : NSObject
{
    NSString* _content;
    NSString* _fkQuestion;
    NSString* _optionValue;
    NSString* _pkId;
    int disabled;
    float weight;
}

@property(nonatomic,copy)NSString* content;
@property(nonatomic,copy)NSString* fkQuestion;
@property(nonatomic,copy)NSString* optionValue;
@property(nonatomic,copy)NSString* pkId;
@property(nonatomic,assign)float weight;
@property(nonatomic,assign)int disabled;

-(id)initWithContent:(NSString*)mContent andOptionValue:(NSString*)mOptionValue andWeight:(int)mweight andpkId:(NSString*)mpkId andfkQuestion:(NSString*)mfkQuestion;

+(id)OptionWithContent:(NSString*)mContent andOptionValue:(NSString*)mOptionValue andWeight:(int)mweight andpkId:(NSString*)mpkId andfkQuestion:(NSString*)mfkQuestion;

-(instancetype)initWithDict:(NSDictionary *)dict;
//将本身插入数据库
-(BOOL)insertSelfToDB;
//数据库中所有对象
+(NSArray *)allOptionFromDB;
@end
