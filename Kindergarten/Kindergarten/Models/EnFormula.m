//
//  EnFormula.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/19.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnFormula.h"
#import "SQLiteManager.h"
#import "EnSchool.h"
#import "XMLDictionary.h"

@implementation EnFormula

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(BOOL)insertSelfToDB{
    //插入对象的SQL语句
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO 'tbl_formula' (pkId,name,expression,memo,value) VALUES ('%@','%@','%@','%@','%@');",self.pkId,self.name,self.expression,self.memo,self.value];
    return [[SQLiteManager shareInstance] execSQL:insertSQL];
}

-(BOOL)updateValueToDB
{
    //更新对象的SQL语句
    NSString *updateSQL = [NSString stringWithFormat:@"UPDATE  'tbl_formula' SET value='%@' WHERE pkId='%@';",self.value,self.pkId];
    return [[SQLiteManager shareInstance] execSQL:updateSQL];
}

+(NSArray *)allFormulaFromDB{
    //查询表中所有数据的SQL语句
    NSString *SQL = @"SELECT pkId,name,expression,memo,value FROM 'tbl_formula'";
    //取出数据库用户表中所有数据
    NSArray *allFormulaDictArr = [[SQLiteManager shareInstance] querySQL:SQL];
    //NSLog(@"%@",allFormulaDictArr);
    //将字典数组转化为模型数组
    NSMutableArray *modelArrM = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in allFormulaDictArr) {
        [modelArrM addObject:[[EnFormula alloc] initWithDict:dict]];
    }
    return modelArrM;
}

//计算表达式结果，根据表达式,院校信息
+(NSDictionary*)translateExpression:(NSArray*)formulaArra bySchoolInfo:(NSDictionary*)dicSchool
{
    EnFormula* f;
    if (formulaArra!=nil && formulaArra.count>0) {
        for (int i=0; i<formulaArra.count; i++) {
            f=(EnFormula*)formulaArra[i];
            if(f.expression!=nil && f.expression.length>0)
            {
                f.expression = [Base64Util Decode:f.expression];
                //f.expression=[f.expression stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
                //f.expression=[f.expression stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                NSString *pattern = @"\\{([^\\{\\}]+)\\}";//创建正则表达式，匹配表达式中的变量
                NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
                //利用规则测试字符串获取匹配结果
                NSArray *results = [regular matchesInString:f.expression options:0 range:NSMakeRange(0, f.expression.length)];
                //NSLog(@"%@",results);
                NSString* newStr = [[NSString alloc] init];
                int end=0;
                for (NSTextCheckingResult *result in results)
                {
                    newStr = [newStr stringByAppendingString:[f.expression substringWithRange:NSMakeRange(end, result.range.location-end)]];
                    NSLog(@"%@",dicSchool[[f.expression substringWithRange:result.range]]);
                    if ([dicSchool.allKeys containsObject:[f.expression substringWithRange:result.range]]) {
                        NSString* tmpRet = [NSString stringWithFormat:@"%@",dicSchool[[f.expression substringWithRange:result.range]]];
                        newStr = [newStr stringByAppendingString:tmpRet];
                    }
                    else
                    {
                        newStr = [newStr stringByAppendingString:[f.expression substringWithRange:result.range]];
                    }
                    end = (int)result.range.location+(int)result.range.length;
                }
                newStr = [newStr stringByAppendingString:[f.expression substringWithRange:NSMakeRange(end, f.expression.length-end)]];
                f.expression = [Base64Util Encode:newStr];
            }
        }
    }
    NSMutableDictionary* dicTmp = [[NSMutableDictionary alloc] init];
    if (formulaArra!=nil && formulaArra.count>0) {
        for (int i=0; i<formulaArra.count; i++) {
            f = (EnFormula*)formulaArra[i];
            [dicTmp setObject:f.expression forKey:f.pkId];
        }
        return dicTmp;
    }
    
    return nil;
}

+(BOOL)loadFormulaXMLToDB
{
    
    //NSString* xmlPath = [[NSBundle mainBundle] pathForResource:@"formula" ofType:@"xml"];
    NSString* xmlPath = [GlobalUtil getFormulaXMLPathPath];
    XMLDictionaryParser* parser = [[XMLDictionaryParser alloc] init];
    NSDictionary* dicFormula = [parser dictionaryWithFile:xmlPath];
    EnFormula* f;
    NSDictionary* dicF;
    if ([dicFormula[@"formula"] isKindOfClass:[NSDictionary class]]) {
        dicF = (NSDictionary*)dicFormula[@"formula"];
        f = [[EnFormula alloc] initWithDict:dicF];
        if (![f insertSelfToDB]) {
            return false;
        }
    }
    else
    {
        NSArray* formulaArray = dicFormula[@"formula"];
        for (int i=0; i<formulaArray.count; i++) {
            dicF = (NSDictionary*)formulaArray[i];
            f = [[EnFormula alloc] initWithDict:dicF];
            if (![f insertSelfToDB]) {
                return false;
            }
        
        }
    }
    
    return true;
}

//翻译字符串中的表达式，根据表达式的值
+(NSString*)translateDesc:(NSString*)strDesc
{
    if (strDesc==nil || strDesc.length==0) {
        return @"";
    }
    
    NSDictionary* dicFormula = [self getDicFormulaForExpress];
    NSString *pattern = @"\\{([^\\{\\}]+)\\}";//创建正则表达式，匹配表达式中的变量
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    //利用规则测试字符串获取匹配结果
    NSArray *results = [regular matchesInString:strDesc options:0 range:NSMakeRange(0, strDesc.length)];
    //NSLog(@"%@",results);
    NSString* newStr = [[NSString alloc] init];
    int end=0;
    for (NSTextCheckingResult *result in results)
    {
        newStr = [newStr stringByAppendingString:[strDesc substringWithRange:NSMakeRange(end, result.range.location-end)]];
        if ([dicFormula.allKeys containsObject:[strDesc substringWithRange:result.range]])
        {
            newStr = [newStr stringByAppendingString:dicFormula[[strDesc substringWithRange:result.range]]];
        }
        else
        {
            newStr = [newStr stringByAppendingString:[strDesc substringWithRange:result.range]];
        }
        end = (int)result.range.location+(int)result.range.length;
    }
    return newStr = [newStr stringByAppendingString:[strDesc substringWithRange:NSMakeRange(end, strDesc.length-end)]];
}

+(NSDictionary*)getDicFormulaForExpress
{
    NSArray* formulaArr = [self allFormulaFromDB];
    EnFormula* formula;
    NSMutableDictionary* dicRet = [[NSMutableDictionary alloc]init];
    for (int i=0; i<formulaArr.count; i++) {
        formula = (EnFormula*)formulaArr[i];
        [dicRet setObject:formula.value forKey:[NSString stringWithFormat:@"{%@}",formula.name]];
    }
    return dicRet;
}

+(NSString*)getValueByPKID:(NSString*)mPKID
{
    NSArray* formulaArr = [self allFormulaFromDB];
    EnFormula* formula;
    for (int i=0; i<formulaArr.count; i++) {
        formula = (EnFormula*)formulaArr[i];
        if ([formula.pkId isEqualToString:mPKID]) {
            return formula.value;
        }
    }
    return nil;
}

+(NSString*)getValueByName:(NSString*)mName
{
    NSArray* formulaArr = [self allFormulaFromDB];
    EnFormula* formula;
    for (int i=0; i<formulaArr.count; i++) {
        formula = (EnFormula*)formulaArr[i];
        if ([formula.name isEqualToString:mName]) {
            return formula.value;
        }
    }
    return nil;
}

@end
