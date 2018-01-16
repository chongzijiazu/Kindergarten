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
    float weight;
}

@property(nonatomic,copy)NSString* content;
@property(nonatomic,copy)NSString* fkQuestion;
@property(nonatomic,copy)NSString* optionValue;
@property(nonatomic,copy)NSString* pkId;
@property(nonatomic,assign)float weight;

-(id)initWithContent:(NSString*)mContent andOptionValue:(NSString*)mOptionValue andWeight:(int)mweight andpkId:(NSString*)mpkId andfkQuestion:(NSString*)mfkQuestion;

+(id)OptionWithContent:(NSString*)mContent andOptionValue:(NSString*)mOptionValue andWeight:(int)mweight andpkId:(NSString*)mpkId andfkQuestion:(NSString*)mfkQuestion;
@end
