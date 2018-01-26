//
//  JFKGLevelController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/13.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "JFKGLevelController.h"
#import "JFKGRootViewController.h"
#import "LevelTableCreator.h"
#import "UploadViewController.h"
#import "JFKGCommonController.h"
#import "SQLiteManager.h"

@interface JFKGLevelController()
{
    NSString* _assLevelPath;//处理过的评估指标保存路径，html需要的内容
}
@property(nonatomic,copy)NSString* assLevelPath;

@end

@implementation JFKGLevelController

@synthesize sortedThirdLevelArray=_sortedThirdLevelArray;

//生成指标体系table格式文件，并保存
-(BOOL)makeAssLevelFile
{
    NSString* levelTable=@"";
    NSString* assLevelSavePath = [self.assLevelPath stringByAppendingPathComponent:@"assLevel.txt"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:assLevelSavePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:self.assLevelPath error:nil];
    }
 
    //NSString* levelXMLPath = [[NSBundle mainBundle] pathForResource:@"level" ofType:@"xml"];
    NSString* levelXMLPath = [GlobalUtil getLevelXMLPath];
    LevelTableCreator* levelTabelC =[[LevelTableCreator alloc]init];
    levelTable = [levelTabelC CreateTreeFromLevelXML:levelXMLPath];
    [[NSFileManager defaultManager] createDirectoryAtPath:self.assLevelPath withIntermediateDirectories:YES attributes:nil error:nil];
    [[NSFileManager defaultManager] createFileAtPath:assLevelSavePath contents:[levelTable dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    return true;
}

//读取页面所需数据
-(NSString*)readLevelData
{
    //读取院所信息数据
    //读取评估时间
    //读取个人信息
    
    //读取评估指标数据
    //生成评估指标内容后,保存到沙盒／document/assLevel/,文件夹下，名称为asslevel.txt,以备加载页面使用
    NSString* levelTable=@"";
    NSString* assLevelSavePath = [self.assLevelPath stringByAppendingPathComponent:@"assLevel.txt"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:assLevelSavePath])
    {
        NSData* asslevelData = [[NSFileManager defaultManager] contentsAtPath:assLevelSavePath];
        levelTable = [[NSString alloc] initWithData:asslevelData encoding:NSUTF8StringEncoding];
        
    }
    else
    {
        //NSString* levelXMLPath = [[NSBundle mainBundle] pathForResource:@"level" ofType:@"xml"];
        NSString* levelXMLPath = [GlobalUtil getLevelXMLPath];
        LevelTableCreator* levelTabelC = [[LevelTableCreator alloc] init];
        levelTable = [levelTabelC CreateTreeFromLevelXML:levelXMLPath];
        [[NSFileManager defaultManager] createDirectoryAtPath:self.assLevelPath withIntermediateDirectories:YES attributes:nil error:nil];
        [[NSFileManager defaultManager] createFileAtPath:assLevelSavePath contents:[levelTable dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    }
    
    
    return levelTable;
}

-(void)sendLevelTableToView
{
    //向页面发送评估指标数据
    NSString* levelTable = [self readLevelData];
    if(levelTable!=nil && levelTable.length>0) {
        NSString* scriptStr = [NSString stringWithFormat:@"showLevelTable('%@');",levelTable];
        
        [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
        }];
    }
    
    //计算三级指标完成状态，并刷新
    NSString* strResult = [self getFinishState];
    NSString* scriptStr = [NSString stringWithFormat:@"refreshFinished(%@);",strResult];
    
    [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"response: %@ error: %@", response, error);
    }];
    
    //向页面发送基本信息（院所信息，评估开始结束时间）
    strResult = [JFKGCommonController getBaseInfo];
    scriptStr = [NSString stringWithFormat:@"loadPageData(%@);",strResult];
    
    [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"response: %@ error: %@", response, error);
    }];
    
    //如果尚未计算，则计算公式表中的公式
    if(![ISFORMULACALCULATED isEqualToString:@"1"])
    {
        [self calculateFormula];
    }
}

//计算按三级指标的完成状态
-(NSString*)getFinishState
{
    NSString* strSql=@"SELECT question.fkLevel thirdlevelid, COUNT(question.fkLevel)-SUM(length(answer)) result FROM tbl_ass_quesstion question LEFT JOIN tbl_ass_process process ON question.pkId=process.fkQuestionid GROUP BY question.fkLevel";
    NSArray* resultArray = [[SQLiteManager shareInstance] querySQL:strSql];
    if (resultArray!=nil && resultArray.count>0) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:resultArray options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        if (data == nil) {
            return nil;
        }
        
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

//计算按三级指标的完成状态
-(BOOL)getFinishStateByThirdLevelID:(NSString*)thirdlevelid
{
    NSString* strSql=@"SELECT COUNT(question.fkLevel)-SUM(length(answer)) result FROM tbl_ass_quesstion question LEFT JOIN tbl_ass_process process ON question.pkId=process.fkQuestionid WHERE question.fkLevel='%@' GROUP BY question.fkLevel";
    strSql = [NSString stringWithFormat:strSql,thirdlevelid];
    NSArray* resultArray = [[SQLiteManager shareInstance] querySQL:strSql];
    if (resultArray!=nil && resultArray.count==0) {
        if (resultArray[0][@"result"]!=nil) {
            int ret =  [resultArray[0][@"result"] intValue];
            if (ret==0) {
                return true;
            }
        }
    }
    return false;
}

//计算表达式的值
-(void)calculateFormula
{
    JFKGCommonController* commonC = [[JFKGCommonController alloc]init];
    commonC.webView=self.webView;
    [commonC processFormulaInfo];
}

//保存表达式的计算结果
-(BOOL)saveFormulaValue:(NSDictionary*)dicFormula
{
    return [JFKGCommonController saveFormulaValue:dicFormula];
}

-(void)uploadData
{
    //上传评估数据
    UploadViewController *uploadVC = [[UploadViewController alloc]init];
    uploadVC.currentVC = self.currentVC;
    uploadVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键
    //UIModalPresentationOverFullScreen全屏效果
    uploadVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.625f];
    
    [self.currentVC presentViewController:uploadVC animated:YES completion:nil];
}

//获得排序后的三级指标id数组
-(NSArray*)getSortedThirdlevelArray
{
    NSArray* stArray=nil;
    //NSString* levelXMLPath = [[NSBundle mainBundle] pathForResource:@"level" ofType:@"xml"];
    NSString* levelXMLPath = [GlobalUtil getLevelXMLPath];
    LevelTableCreator* levelTabelC = [[LevelTableCreator alloc] init];
    NSArray* levelArray = [levelTabelC getSortedLevelArrayFromLevelXmlFile:levelXMLPath];
    
    NSMutableArray* tmpArray;
    if (levelArray!=nil && levelArray.count>0) {
        tmpArray = [[NSMutableArray alloc] init];
        NSString* strpkId=nil;
        for (int i=0; i<levelArray.count; i++) {
            strpkId = (NSString*)levelArray[i][@"pkId"];
            if (strpkId.length==9) {
                [tmpArray addObject:strpkId];
            }
        }
        stArray = (NSArray*)tmpArray;
        [stArray sortedArrayUsingSelector:@selector(compare:)];
        
    }
    
    return stArray;
}


-(NSDictionary*)getThirdlevelDict
{
    NSDictionary* stDict=nil;
    //NSString* levelXMLPath = [[NSBundle mainBundle] pathForResource:@"level" ofType:@"xml"];
    NSString* levelXMLPath = [GlobalUtil getLevelXMLPath];
    LevelTableCreator* levelTabelC = [[LevelTableCreator alloc] init];
    NSArray* levelArray = [levelTabelC getSortedLevelArrayFromLevelXmlFile:levelXMLPath];
    
    NSMutableDictionary* tmpDict;
    if (levelArray!=nil && levelArray.count>0) {
        tmpDict = [[NSMutableDictionary alloc] init];
        NSString* strpkId=nil;
        NSString* strname=nil;
        for (int i=0; i<levelArray.count; i++) {
            strpkId = (NSString*)levelArray[i][@"pkId"];
            strname = (NSString*)levelArray[i][@"name"];
            //if (strpkId.length==9) {
                [tmpDict setObject:strname forKey:strpkId];
            //}
        }
        stDict = (NSDictionary*)tmpDict;
    }
    
    return stDict;
}

-(NSString*)getNextThirdLevelIdByCurrentThirdLevelId:(NSString*)currentThirdLevelId
{
    NSString* nextid=nil;
    
    if (self.sortedThirdLevelArray!=nil && self.sortedThirdLevelArray.count>0) {
        NSString* tmpid;
        for (int i=0; i<self.sortedThirdLevelArray.count; i++) {
            tmpid = (NSString*)self.sortedThirdLevelArray[i];
            if ([tmpid isEqualToString:currentThirdLevelId]) {
                if ((i+1)<self.sortedThirdLevelArray.count) {
                    nextid=(NSString*)self.sortedThirdLevelArray[i+1];
                }
                break;
            }
        }
    }
    
    return nextid;
}

-(NSString*)getPreThirdLevelIdByCurrentThirdLevelId:(NSString*)currentThirdLevelId
{
    NSString* preid=nil;
    
    if (self.sortedThirdLevelArray!=nil && self.sortedThirdLevelArray.count>0) {
        NSString* tmpid;
        for (int i=0; i<self.sortedThirdLevelArray.count; i++) {
            tmpid = (NSString*)self.sortedThirdLevelArray[i];
            if ([tmpid isEqualToString:currentThirdLevelId]) {
                if ((i-1)>=0) {
                    preid=(NSString*)self.sortedThirdLevelArray[i-1];
                }
                break;
            }
        }
    }
    
    return preid;
}

-(NSString*)getThirdLevelNameByCurrentThirdLevelId:(NSString*)currentThirdLevelId
{
    if (currentThirdLevelId!=nil && currentThirdLevelId.length==9) {
        NSString* strFirstLevel = self.thirdLevelDic[[currentThirdLevelId substringToIndex:currentThirdLevelId.length-6]];
        NSString* strSecondLevel = self.thirdLevelDic[[currentThirdLevelId substringToIndex:currentThirdLevelId.length-3]];
        NSString* strThirdLevel =self.thirdLevelDic[currentThirdLevelId];
        NSString* allName = [NSString stringWithFormat:@"%@/%@/%@",strFirstLevel,strSecondLevel,strThirdLevel];
        return allName;
    }
    return @"";
}

-(NSString *)assLevelPath {
    if (_assLevelPath == nil) {
        //Document路径
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        _assLevelPath = [documentPath stringByAppendingPathComponent:@"assLevel"];
    }
    
    return _assLevelPath;
}

-(NSArray*)sortedThirdLevelArray {
    if (_sortedThirdLevelArray == nil) {
        _sortedThirdLevelArray = [self getSortedThirdlevelArray];
    }
    
    return _sortedThirdLevelArray;
}

-(NSDictionary*)thirdLevelDic {
    if (_thirdLevelDic == nil) {
        _thirdLevelDic = [self getThirdlevelDict];
    }
    
    return _thirdLevelDic;
}
@end
