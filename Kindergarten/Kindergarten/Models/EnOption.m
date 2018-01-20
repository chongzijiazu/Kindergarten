//
//  EnOption.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/14.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnOption.h"
#import "SQLiteManager.h"

@implementation EnOption

@synthesize content=_content;
@synthesize optionValue=_optionValue;
@synthesize pkId=_pkId;
@synthesize fkQuestion=_fkQuestion;
@synthesize weight;
@synthesize disabled;

-(id)initWithContent:(NSString*)mContent andOptionValue:(NSString*)mOptionValue andWeight:(int)mweight andpkId:(NSString*)mpkId andfkQuestion:(NSString*)mfkQuestion
{
    if (self=[super init]) {
        self.content = mContent;
        self.optionValue = mOptionValue;
        self.weight = mweight;
        self.pkId=mpkId;
        self.fkQuestion=mfkQuestion;
    }
    return self;
}

+(id)OptionWithContent:(NSString*)mContent andOptionValue:(NSString*)mOptionValue andWeight:(int)mweight andpkId:(NSString*)mpkId andfkQuestion:(NSString*)mfkQuestion
{
    EnOption* option = [[EnOption alloc] initWithContent:mContent andOptionValue:mOptionValue andWeight:mweight andpkId:mpkId andfkQuestion:mfkQuestion];
    return option;
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(BOOL)insertSelfToDB{
    //插入对象的SQL语句
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO 'tbl_ass_question_option' (pkId,optionValue,content,fkQuestion,weight) VALUES ('%@','%@','%@','%@','%f');",self.pkId,self.optionValue,self.content,self.fkQuestion,self.weight];
    return [[SQLiteManager shareInstance] execSQL:insertSQL];
}
+(NSArray *)allOptionFromDB{
    //查询表中所有数据的SQL语句
    NSString *SQL = @"SELECT pkId,optionValue,content,fkQuestion,weight FROM 'tbl_ass_question_option'";
    //取出数据库用户表中所有数据
    NSArray *allOptioDictArr = [[SQLiteManager shareInstance] querySQL:SQL];
    NSLog(@"%@",allOptioDictArr);
    //将字典数组转化为模型数组
    NSMutableArray *modelArrM = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in allOptioDictArr) {
        [modelArrM addObject:[[EnOption alloc] initWithDict:dict]];
    }
    return modelArrM;
}


/*
 选项html示例：
<label class="radio-inline">
<input type="radio" name="A" id="optionsRadios4" value="option2"/>
A.园舍独立，产权清晰，规划科学，布局合理，民办园自有房产需要有效的房产证，租用园舍的，需要有效期3年及以上的租赁合同及月舞房产证或土地证。
</label>
 */
//按html格式描述选项
-(NSString*)description
{
    NSString* optionHtml;
    if (self.disabled==1) {
        optionHtml = [NSString stringWithFormat:@"<label class=\"radio-inline\"><input disabled readonly=\"true\" type=\"radio\" name=\"%@\" id=\"%@\" value=\"%@\" onclick=\"optionClicked(this)\"/>%@.%@</label><br></br>",self.fkQuestion,self.pkId,self.optionValue,self.optionValue,self.content];
    }
    else
    {
        optionHtml = [NSString stringWithFormat:@"<label class=\"radio-inline\"><input type=\"radio\" name=\"%@\" id=\"%@\" value=\"%@\" onclick=\"optionClicked(this)\"/>%@.%@</label><br></br>",self.fkQuestion,self.pkId,self.optionValue,self.optionValue,self.content];
    }
    
    return optionHtml;
}

@end
