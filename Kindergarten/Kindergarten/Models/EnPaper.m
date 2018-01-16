//
//  EnPaper.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/15.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnPaper.h"
#import "EnLevelQuestion.h"

@implementation EnPaper

-(id)init
{
    if (self=[super init]) {
        self.levelquestionArray = [[NSMutableArray alloc] init];
    }
    return self;
}

//@synthesize paperid=_paperid;
//@synthesize papername=_papername;
//@synthesize levelquestionArray = _levelquestionArray;

/*-(id)initWithPaperID:(NSString *)mpaperid andPaperName:(NSString *)mpapername
{
    if (self=[super init]) {
        self.paperid = mpaperid;
        self.papername=mpapername;
        self.levelquestionArray = [[NSMutableArray alloc] init];
    }
    return self;
}*/

/*+(id)paperWithPaperID:(NSString *)mpaperid andPaperName:(NSString *)mpapername
{
    EnPaper* paper = [[EnPaper alloc] initWithPaperID:mpaperid andPaperName:mpapername];
    return paper;
}*/

//根据三级指标id(levelid),
//判断levelQuestionArray是否已存在此levelQuestion
-(BOOL)isExistLevelQuestionByLevelID:(NSString*)levelid
{
    BOOL isexist = false;
    
    EnLevelQuestion* levelQuestion;
    for (int i=0; i<self.levelquestionArray.count; i++) {
        levelQuestion = (EnLevelQuestion*)self.levelquestionArray[i];
        if ([levelQuestion.levelID isEqualToString:levelid]) {
            isexist = true;
            break;
        }
        
    }
    
    return isexist;
}

//根据三级指标id(levelid)
//获取levelQuestionArray中的levelQuestion
-(EnLevelQuestion*)getLevelQuestionByLevelID:(NSString*)levelid
{
    EnLevelQuestion* levelQuestion = nil;
    
    EnLevelQuestion* tmpLevelQ;
    for (int i=0; i<self.levelquestionArray.count; i++) {
        tmpLevelQ = (EnLevelQuestion*)self.levelquestionArray[i];
        if ([tmpLevelQ.levelID isEqualToString:levelid]) {
            levelQuestion = tmpLevelQ;
            break;
        }
        
    }
    
    return levelQuestion;
}

@end
