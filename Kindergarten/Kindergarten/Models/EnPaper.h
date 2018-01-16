//
//  EnPaper.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/15.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnLevelQuestion.h"

@interface EnPaper : NSObject
{
    //NSString* _paperid;//试卷id
    //NSString* _papername;//试卷名称
    NSMutableArray* _levelquestionArray;//三级指标试题数组
}
//@property(nonatomic,copy)NSString* paperid;
//@property(nonatomic,copy)NSString* papername;
@property(nonatomic,strong)NSMutableArray* levelquestionArray;

//-(id)initWithPaperID:(NSString*)mpaperid andPaperName:(NSString*)mpapername;
//+(id)paperWithPaperID:(NSString*)mpaperid andPaperName:(NSString*)mpapername;

-(BOOL)isExistLevelQuestionByLevelID:(NSString*)levelid;
-(EnLevelQuestion*)getLevelQuestionByLevelID:(NSString*)levelid;

@end
