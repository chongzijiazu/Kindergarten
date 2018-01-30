//
//  EnLevelQuestion.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/15.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnLevelQuestion.h"
#import "EnAprove.h"

@implementation EnLevelQuestion

@synthesize levelID=_levelID;
@synthesize questionArray=_questionArray;

-(id)initWithLevelID:(NSString*)mlevelID
{
    if (self=[super init]) {
        self.levelID=mlevelID;
        self.questionArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+(id)LevelQuestionWithLevelID:(NSString*)mlevelID
{
    EnLevelQuestion* levelQuestion = [[EnLevelQuestion alloc] initWithLevelID:mlevelID];
    return levelQuestion;
}

/*
 <table class="table table-condensed">
 <thead>
 <tr>
 <td style="vertical-align: middle; background-color: white; width: 69%;">
    试题
 </td>
 <td style="vertical-align: middle; width: 1%;">
 </td>
 <td style="vertical-align: middle; background-color: white; width: 30%;">
    证据
 </td>
 </tr>
 </thead>
 </table>
 */
//按html格式描述三级节点试题
//及证据添加部分
-(NSString*)description
{
    NSString* levelHtml=@"";
   
    EnQuestion* question;
    EnAprove* aprove;
    NSString* questionAndProveHtml=@"";
    for (int i=0; i<self.questionArray.count; i++) {
        question = (EnQuestion*)self.questionArray[i];
        aprove = [EnAprove aproveWithPkId:question.pkId andSeqLevel:question.seqLevel andAproveItemNum:0];
        questionAndProveHtml = [NSString stringWithFormat:@"<table class=\"table table-condensed\"><thead><tr><td style=\"vertical-align: middle; background-color: white; width: 74%%; \">%@</td><td style=\"vertical-align: middle; width: 1%%;\"></td><td style=\"vertical-align: middle; background-color: white; width: 25%%;\">%@</td></tr></thead></table>",[question description],[aprove description]];
        
        levelHtml= [levelHtml stringByAppendingString:questionAndProveHtml];
    }
   
    return levelHtml;
}

@end
