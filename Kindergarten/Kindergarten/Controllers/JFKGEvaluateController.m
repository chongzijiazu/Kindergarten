//
//  JFKGEvaluateController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/14.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "JFKGEvaluateController.h"
#import "JFKGRootViewController.h"
#import "XMLDictionary.h"
#import "EnQuestion.h"
#import "EnLevelQuestion.h"
#import "EnOption.h"
#import "EnPaper.h"

@interface JFKGEvaluateController()

@end

@implementation JFKGEvaluateController

//向界面发送当前三级指标试题
-(void)sendLevelQuestionToView
{
    if(self.currentLevelQuestionID!=nil && self.currentLevelQuestionID.length==9)
    {
        NSString* levelQuestion = [self readLevelQuestionByLevelId:self.currentLevelQuestionID];
        if(levelQuestion!=nil && levelQuestion.length>0)
        {
            NSString* scriptStr = [NSString stringWithFormat:@"showLevelQuestion('%@');",levelQuestion];
        
            [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
            }];
        }
    }
}

//根据三级指标读取试题
-(NSString*)readLevelQuestionByLevelId:(NSString*)levelid
{
    NSString* levelQPath = [self.levelHTMLPath stringByAppendingPathComponent:[levelid stringByAppendingString:@".txt"]];
    NSData* qData = [[NSFileManager defaultManager] contentsAtPath:levelQPath];
    return [[NSString alloc] initWithData:qData encoding:NSUTF8StringEncoding];
}

//根据试卷制作三级指标html
//每个三级指标下的试题生成一个三级指标html
//生成的html以三级指标id(levelid)命名，例如(001001001.txt)
//生成的html文件存放在沙盒的/document/levelhtml/，文件夹中
-(void)makeLevelHTMLByPaper
{
    EnPaper* paper = [self getPaperFromXMLPaper];
    [self deleteExistHTMLFile];//清理已存在的html文件
    
    //NSLog(@"%@",[levelQues description]);
    if (paper!=nil && paper.levelquestionArray.count>0) {
        EnLevelQuestion* levelQues;
        NSString* levelHtmlPath;
        NSString* htmlContent;
        for (int i=0; i<paper.levelquestionArray.count; i++) {
            levelQues = (EnLevelQuestion*)paper.levelquestionArray[i];
            htmlContent=[levelQues description];
            levelHtmlPath = [self.levelHTMLPath stringByAppendingPathComponent:[levelQues.levelID stringByAppendingString:@".txt"]];
            [[NSFileManager defaultManager] createFileAtPath:levelHtmlPath contents:[htmlContent dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
        }
    }
}



//删除存在的html文件
-(void)deleteExistHTMLFile
{
    if([[NSFileManager defaultManager] fileExistsAtPath:self.levelHTMLPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:self.levelHTMLPath error:nil];//删除原来
    }
    
    //重新创建目录
    [[NSFileManager defaultManager] createDirectoryAtPath:self.levelHTMLPath withIntermediateDirectories:YES attributes:nil error:nil];
}

-(EnPaper*)getPaperFromXMLPaper
{
    EnPaper* tmpPaper=nil;
    
    NSDictionary* dicPaper = [self getDictionaryFromPaperXML];
    //NSLog(@"%@",dicPaper);
    if (dicPaper!=nil && dicPaper.count>0)
    {
        tmpPaper = [[EnPaper alloc] init];
        NSArray* questions = dicPaper[@"question"];
        if (questions!=nil && questions.count>0) {
            EnQuestion* question;
            for (int i=0; i<questions.count; i++) {
                question = [EnQuestion questionWithPKID:questions[i][@"pkId"] andLevel:questions[i][@"fkLevel"] andSeqLevel:questions[i][@"seqLevel"] andFormula:questions[i][@"fkFormula"] andContentTip:questions[i][@"contenttip"] andContent:questions[i][@"content"] andDescription:questions[i][@"description"] andSeq:[questions[i][@"seq"] intValue] andType:[questions[i][@"type"] intValue] andWeight:[questions[i][@"weight"] floatValue] andVeto:[questions[i][@"veto"] intValue] andAppendProve:[questions[i][@"appendprove"] intValue] andCalculated:[questions[i][@"calculated"] intValue] andDeleted:[questions[i][@"deleted"] intValue]];
                NSArray* options = questions[i][@"options"][@"option"];
                EnOption* option;
                for (int j=0; j<options.count; j++) {
                    option = [EnOption OptionWithContent:options[j][@"_content"] andOptionValue:options[j][@"_optionvalue"] andWeight:[options[j][@"_weight"] floatValue] andpkId:options[j][@"_pkId"] andfkQuestion:options[j][@"_fkQuestion"]];
                    [question.optionArray addObject:option];
                }
                
                if (![tmpPaper isExistLevelQuestionByLevelID:questions[i][@"fkLevel"]])
                {
                    EnLevelQuestion* levelQuestion = [EnLevelQuestion LevelQuestionWithLevelID:questions[i][@"fkLevel"]];
                    [tmpPaper.levelquestionArray addObject:levelQuestion];
                }
                EnLevelQuestion* tmpLevelQ = [tmpPaper getLevelQuestionByLevelID:questions[i][@"fkLevel"]];
                [tmpLevelQ.questionArray addObject:question];
            }
        }
    }
    else
    {
        //解析试卷错误，需要考虑重新下载数据问题
    }
    
    return tmpPaper;
}

//从paperXML读取数据
-(NSDictionary*)getDictionaryFromPaperXML
{
    NSString* filepath = [[NSBundle mainBundle] pathForResource:@"paper" ofType:@"xml"];
    XMLDictionaryParser* parser = [[XMLDictionaryParser alloc] init];
    NSDictionary* dicPaper = [parser dictionaryWithFile:filepath];
    return dicPaper;
}

-(NSString *)levelHTMLPath {
    if (_levelHTMLPath == nil) {
        //Document路径
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        _levelHTMLPath = [documentPath stringByAppendingPathComponent:@"levelhtml"];
    }
    
    return _levelHTMLPath;
}
@end
