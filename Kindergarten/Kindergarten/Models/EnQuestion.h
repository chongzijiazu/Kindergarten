//
//  EnQuestion.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/14.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnQuestion : NSObject
{
    NSString* _pkId; //试题唯一id（uuid）
    NSString* _fkLevel;//试题所属三级指标编码
    NSString* _seqLevel;//试题评估指标全编码
    NSString* _fkFormula;//计算公式名称
    NSString* _contenttip;//蓝色提示字
    NSString* _content;//题干内容
    NSString* _desc;//题目解释信息
    int seq;//题目在三级指标下的序号
    int type;//题目类型
    float weight;//试题权重
    int veto;//是否关键指标
    int appendprove;//是否可添加证据
    int calculated;//是否为计算题
    int deleted;//是否删除
    int questionnum;//试卷中的试题序号
    NSMutableArray* _optionArray;//选项数组
}

@property(nonatomic,copy)NSString* pkId;
@property(nonatomic,copy)NSString* fkLevel;
@property(nonatomic,copy)NSString* seqLevel;
@property(nonatomic,copy)NSString* fkFormula;
@property(nonatomic,copy)NSString* contenttip;
@property(nonatomic,copy)NSString* content;
@property(nonatomic,copy)NSString* desc;
@property(nonatomic,assign)int seq;
@property(nonatomic,assign)int type;
@property(nonatomic,assign)float weight;
@property(nonatomic,assign)int veto;
@property(nonatomic,assign)int appendprove;
@property(nonatomic,assign)int calculated;
@property(nonatomic,assign)int deleted;
@property(nonatomic,assign)int questionnum;
@property(nonatomic,strong)NSMutableArray* optionArray;

-(id)initWithPKID:(NSString *)mpkId andLevel:(NSString *)mlevel andSeqLevel:(NSString*)mseqlevel andFormula:(NSString*)mformula andContentTip:(NSString*)mcontenttip andContent:(NSString*)mcontent andDescription:(NSString*)mdescription andSeq:(int)mSeq andType:(int)mType andWeight:(float)mweight andVeto:(int)mveto andAppendProve:(int)mappendprove andCalculated:(int)mcalculated andDeleted:(int)mdeleted andQuestionNum:(int)mquestionnum;


+(id)questionWithPKID:(NSString *)mpkId andLevel:(NSString *)mlevel andSeqLevel:(NSString*)mseqlevel andFormula:(NSString*)mformula andContentTip:(NSString*)mcontenttip andContent:(NSString*)mcontent andDescription:(NSString*)mdescription andSeq:(int)mSeq andType:(int)mType andWeight:(float)mweight andVeto:(int)mveto andAppendProve:(int)mappendprove andCalculated:(int)mcalculated andDeleted:(int)mdeleted andQuestionNum:(int)mquestionnum;

-(instancetype)initWithDict:(NSDictionary *)dict;
//将本身插入数据库
-(BOOL)insertSelfToDB;
//数据库中所有对象
+(NSArray *)allQuestionFromDB;

@end
