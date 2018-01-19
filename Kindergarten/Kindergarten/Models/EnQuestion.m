//
//  EnQuestion.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/14.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnQuestion.h"
#import "EnOption.h"
#import "SQLiteManager.h"
#import "EnProcessInfo.h"

@implementation EnQuestion

@synthesize pkId=_pkId;
@synthesize fkLevel=_fkLevel;
@synthesize seqLevel=_seqLevel;
@synthesize fkFormula=_fkFormula;
@synthesize contenttip=_contenttip;
@synthesize content=_content;
@synthesize desc=_desc;
@synthesize seq;
@synthesize type;
@synthesize weight;
@synthesize veto;
@synthesize appendprove;
@synthesize calculated;
@synthesize deleted;
@synthesize questionnum;
@synthesize optionArray=_optionArray;

-(id)initWithPKID:(NSString *)mpkId andLevel:(NSString *)mlevel andSeqLevel:(NSString*)mseqlevel andFormula:(NSString*)mformula andContentTip:(NSString*)mcontenttip andContent:(NSString*)mcontent andDescription:(NSString*)mdescription andSeq:(int)mSeq andType:(int)mType andWeight:(float)mweight andVeto:(int)mveto andAppendProve:(int)mappendprove andCalculated:(int)mcalculated andDeleted:(int)mdeleted andQuestionNum:(int)mquestionnum
{
    if(self=[super init]){ //super代表父类
        self.pkId = mpkId;
        self.fkLevel = mlevel;
        self.seqLevel = mseqlevel;
        self.fkFormula = mformula;
        self.contenttip = mcontenttip;
        self.content = mcontent;
        self.desc = mdescription;
        self.seq = mSeq;
        self.type = mType;
        self.weight = mweight;
        self.veto =mveto;
        self.appendprove = mappendprove;
        self.calculated = mcalculated;
        self.deleted = mdeleted;
        self.questionnum=mquestionnum;
        self.optionArray = [[NSMutableArray alloc] init];
    }
    return self;
}


+(id)questionWithPKID:(NSString *)mpkId andLevel:(NSString *)mlevel andSeqLevel:(NSString*)mseqlevel andFormula:(NSString*)mformula andContentTip:(NSString*)mcontenttip andContent:(NSString*)mcontent andDescription:(NSString*)mdescription andSeq:(int)mSeq andType:(int)mType andWeight:(float)mweight andVeto:(int)mveto andAppendProve:(int)mappendprove andCalculated:(int)mcalculated andDeleted:(int)mdeleted andQuestionNum:(int)mquestionnum
{
    EnQuestion* question = [[EnQuestion alloc] initWithPKID:mpkId andLevel:mlevel andSeqLevel:mseqlevel andFormula:mformula andContentTip:mcontenttip andContent:mcontent andDescription:mdescription andSeq:mSeq andType:mType andWeight:mweight andVeto:mveto andAppendProve:mappendprove andCalculated:mcalculated andDeleted:mdeleted andQuestionNum:mquestionnum];
    return question;
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(BOOL)insertSelfToDB
{
    //插入对象的SQL语句
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO 'tbl_ass_quesstion' (pkId,fkLevel,seqLevel,fkFormula,contenttip,content,description,seq,type,weight,veto,appendprove,calculated,deleted,questionnum) VALUES ('%@','%@','%@','%@','%@','%@','%@','%d','%d','%f','%d','%d','%d','%d','%d');",self.pkId,self.fkLevel,self.seqLevel,self.fkFormula,self.contenttip,self.content,self.desc,self.seq,self.type,self.weight,self.veto,self.appendprove,self.calculated,self.deleted,self.questionnum];
    return [[SQLiteManager shareInstance] execSQL:insertSQL];
}
+(NSArray *)allQuestionFromDB
{
    //查询表中所有数据的SQL语句
    NSString *SQL = @"SELECT pkId,fkLevel,seqLevel,fkFormula,contenttip,content,description,seq,type,weight,veto,appendprove,calculated,deleted,questionnum FROM 'tbl_ass_quesstion'";
    //取出数据库用户表中所有数据
    NSArray *allQuestionDictArr = [[SQLiteManager shareInstance] querySQL:SQL];
    NSLog(@"%@",allQuestionDictArr);
    //将字典数组转化为模型数组
    NSMutableArray *modelArrM = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in allQuestionDictArr) {
        [modelArrM addObject:[[EnQuestion alloc] initWithDict:dict]];
    }
    return modelArrM;
}


/*
 试题模板示例：
<div style="font-size: 18px;">
1.园舍产权
 <span style="color: red; font-weight: bold;display:none">（关键指标）</span>
<img src="images/question.png" />
<a href="#">查看题目解释</a>
 <font style="display: 1; font-size: 18px; border: 2px solid orange; padding: 4px;border-radius: 4px; font-weight: bold;" color="orange" id="quesFinish_0d0ecc66c2964929a132bd7337d39d88">
    已完成
 </font>
</div>
<hr/>
<div id="pkId">
    选项
</div>
<div class="questips">
    <img src="images/result.png" />
    <span>根据您填写的院所信息，在园人数：485.00</span>
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
    
    //是否关键指标
    NSString* strVeto=@"";
    if (self.veto==0) {
        strVeto=@"none";
    }
    /*//是否完成
    NSString* strFinish=@"";
    BOOL isFinished = [EnProcessInfo isFinished:self.pkId];
    if(!isFinished)
    {
        strFinish=@"none";
    }*/
    
    NSString* questionHtml = [NSString stringWithFormat:@"<div style=\"font-size: 18px;\">%d.%@<span style=\"color: red; font-weight: bold;display:%@\">（关键指标）</span><img src=\"images/question.png\" /><a id=\"%@_desclink\" onclick=\"showQuesDesc(this.id)\" href=\"#\"><span>查看题目解释<span><span sdesc=\"%@\" id=\"%@_desc\" /></a> <font style=\"display:none; font-size: 18px; border: 2px solid orange; padding: 4px;border-radius: 4px; font-weight: bold;\" color=\"orange\" id=\"quesFinish_%@\">已完成</font></div><hr/><div id=\"%@\">%@</div><div class=\"questips\"><img src=\"images/result.png\" /><span>%@</span></div>",self.seq,self.content,strVeto,self.pkId,self.desc,self.pkId,self.pkId,self.pkId,optionHtml,self.contenttip];
    return questionHtml;
}

@end
