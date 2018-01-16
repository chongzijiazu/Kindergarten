//
//  EnLevelQuestion.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/15.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnQuestion.h"

@interface EnLevelQuestion : NSObject
{
    NSString* _levelID;//三级指标id
    NSMutableArray* _questionArray;//三级指标下的试题
}

@property(nonatomic,strong)NSString* levelID;
@property(nonatomic,strong)NSMutableArray* questionArray;

-(id)initWithLevelID:(NSString*)mlevelID;
+(id)LevelQuestionWithLevelID:(NSString*)mlevelID;

@end
