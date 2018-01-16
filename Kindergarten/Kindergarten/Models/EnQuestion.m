//
//  EnQuestion.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/14.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnQuestion.h"
#import "EnOption.h"

@implementation EnQuestion

@synthesize pkId=_pkId;
@synthesize fkLevel=_fkLevel;
@synthesize seqLevel=_seqLevel;
@synthesize fkFormula=_fkFormula;
@synthesize contenttip=_contenttip;
@synthesize content=_content;
@synthesize description=_description;
@synthesize seq;
@synthesize type;
@synthesize weight;
@synthesize veto;
@synthesize appendprove;
@synthesize calculated;
@synthesize deleted;
@synthesize optionArray=_optionArray;

-(id)initWithPKID:(NSString *)mpkId andLevel:(NSString *)mlevel andSeqLevel:(NSString*)mseqlevel andFormula:(NSString*)mformula andContentTip:(NSString*)mcontenttip andContent:(NSString*)mcontent andDescription:(NSString*)mdescription andSeq:(int)mSeq andType:(int)mType andWeight:(float)mweight andVeto:(int)mveto andAppendProve:(int)mappendprove andCalculated:(int)mcalculated andDeleted:(int)mdeleted
{
    if(self=[super init]){ //super代表父类
        self.pkId = mpkId;
        self.fkLevel = mlevel;
        self.seqLevel = mseqlevel;
        self.fkFormula = mformula;
        self.contenttip = mcontenttip;
        self.content = mcontent;
        self.description = mdescription;
        self.seq = mSeq;
        self.type = mType;
        self.weight = mweight;
        self.veto =mveto;
        self.appendprove = mappendprove;
        self.calculated = mcalculated;
        self.deleted = mdeleted;
        self.optionArray = [[NSMutableArray alloc] init];
    }
    return self;
}


+(id)questionWithPKID:(NSString *)mpkId andLevel:(NSString *)mlevel andSeqLevel:(NSString*)mseqlevel andFormula:(NSString*)mformula andContentTip:(NSString*)mcontenttip andContent:(NSString*)mcontent andDescription:(NSString*)mdescription andSeq:(int)mSeq andType:(int)mType andWeight:(float)mweight andVeto:(int)mveto andAppendProve:(int)mappendprove andCalculated:(int)mcalculated andDeleted:(int)mdeleted
{
    EnQuestion* question = [[EnQuestion alloc] initWithPKID:mpkId andLevel:mlevel andSeqLevel:mseqlevel andFormula:mformula andContentTip:mcontenttip andContent:mcontent andDescription:mdescription andSeq:mSeq andType:mType andWeight:mweight andVeto:mveto andAppendProve:mappendprove andCalculated:mcalculated andDeleted:mdeleted];
    return question;
}

/*
 试题模板示例：
<div style="font-size: 18px;">
1.园舍产权
<img src="images/question.png" />
<a href="#">查看题目解释</a>
</div>
<hr/>
<div>
    选项
</div>
 */
//html格式描述试题
-(NSString*)description
{
    NSString* optionHtml=@"";
    EnOption* option;
    for (int i=0; i<self.optionArray.count; i++) {
        option = (EnOption*)self.optionArray[i];
        optionHtml=[optionHtml stringByAppendingString:[option description]];
    }
    NSString* questionHtml = [NSString stringWithFormat:@"<div style=\"font-size: 18px;\">%d.%@<img src=\"images/question.png\" /><a href=\"#\">查看题目解释</a></div><hr/><div>%@</div>",self.seq,self.content,optionHtml];
    return questionHtml;
}

@end
