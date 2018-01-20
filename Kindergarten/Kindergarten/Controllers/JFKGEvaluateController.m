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
#import "SQLiteManager.h"
#import "EnAproveItem.h"

@interface JFKGEvaluateController()
{
    
}
@property(nonatomic,assign)int maxAproveNum;

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
            //页面试题处理
            NSString* scriptStr = [NSString stringWithFormat:@"showLevelQuestion('%@');",levelQuestion];
        
            [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
            }];
            
            //页面答案处理
            NSString* strQA = [self getQuestionAnswerByThirdLevelId:self.currentLevelQuestionID];
            scriptStr = [NSString stringWithFormat:@"showLevelAnswer('%@');",strQA];
            
            [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                NSLog(@"response: %@ error: %@", response, error);
            }];
            
            //处理页面证据
            NSString* strQuesAprove=[self getQuestionAproveByThirdLevelId:self.currentLevelQuestionID];
            scriptStr = [NSString stringWithFormat:@"showLevelAprove(%@);",strQuesAprove];
            //NSLog(@"%@",strQuesAprove);
            [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                NSLog(@"response: %@ error: %@", response, error);
            }];
            
            //处理文本框信息
            NSString* strMemo = [self getQuestionMemoByThirdLevelId:self.currentLevelQuestionID];
            //NSLog(@"%@",strMemo);
            scriptStr = [NSString stringWithFormat:@"showLevelMemo(%@);",strMemo];
            [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                NSLog(@"response: %@ error: %@", response, error);
            }];
            
            //处理计算题表达式信息
            
        }
    }
}

-(NSString*)getQuestionMemoByThirdLevelId:(NSString*)thirdLevelId
{
    if (thirdLevelId!=nil && thirdLevelId.length==9)
    {
        NSString* strSql=[NSString stringWithFormat:@"SELECT question.seqLevel seqlevel FROM tbl_ass_quesstion question WHERE question.fkLevel='%@';",thirdLevelId];
        NSArray* QAArray = [[SQLiteManager shareInstance] querySQL:strSql];
        //NSLog(@"%@",QAArray);
        NSFileManager* fileM = [NSFileManager defaultManager];
        NSMutableArray* memoArray = [[NSMutableArray alloc]init];
        NSString* aprovePath = [GlobalUtil getAprovePath];
        NSString* txtMemoPath = [[NSString alloc] init];
        for (int i=0; i<QAArray.count; i++) {
            NSMutableDictionary* memoDic = [[NSMutableDictionary alloc]init];
            txtMemoPath = [aprovePath stringByAppendingPathComponent:QAArray[i][@"seqlevel"]];
            txtMemoPath = [txtMemoPath stringByAppendingString:@".txt"];
            if ([fileM fileExistsAtPath:txtMemoPath]) {
                NSString* memoContent = [NSString stringWithContentsOfFile:txtMemoPath encoding:NSUTF8StringEncoding error:nil];
                [memoDic setObject:QAArray[i][@"seqlevel"] forKey:@"memoid"];
                [memoDic setObject:memoContent forKey:@"memocontent"];
                [memoArray addObject:memoDic];
                txtMemoPath=@"";
            }
        }
        
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:memoArray options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        if (data == nil) {
            return nil;
        }
        
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //return dicQuesAprove;
    }
    return nil;
}

//页面证据处理
//从数据库中按三级指标id查询试题的证据信息
//如果试题下有证据信息，则按证据个数生成已有证据项，当数据没有达到配置上线时，生成一个可添加证据项
//如果试题下无证据信息，则判断该题是否可添加证据，如果可添加证据，则生成一个可添加证据项
-(NSString*)getQuestionAproveByThirdLevelId:(NSString*)thirdLevelId
{
    if (thirdLevelId!=nil && thirdLevelId.length==9)
    {
        NSString* strSql=[NSString stringWithFormat:@"SELECT question.pkId questionid,question.seqLevel seqlevel,process.attachmentpath attachments,question.appendprove appendprove FROM tbl_ass_quesstion question LEFT JOIN tbl_ass_process process ON question.pkId=process.fkQuestionid WHERE question.fkLevel='%@';",thirdLevelId];
        NSArray* QAArray = [[SQLiteManager shareInstance] querySQL:strSql];
        //NSLog(@"%@",QAArray);
        NSString* strAttachments;
        EnAproveItem* tmpAproveItem;
        NSMutableArray* dicQuesAproveArray = [[NSMutableArray alloc]init];
        NSString* strAproveItems=[[NSString alloc]init];
        for (int i=0; i<QAArray.count; i++)
        {
            NSMutableDictionary* dicQuesAprove = [[NSMutableDictionary alloc]init];
            strAproveItems=@"<tr>";
            strAttachments = QAArray[i][@"attachments"];
            if (strAttachments.length>0)//该题已有证据
            {
                NSArray *array = [strAttachments componentsSeparatedByString:@","];
                for (int j=0; j<array.count; j++)
                {
                    tmpAproveItem = [EnAproveItem aproveItemWithApproveItemId:array[j] andType:1 andFKQuestionid:QAArray[i][@"questionid"]];
                    strAproveItems= [strAproveItems stringByAppendingString:[tmpAproveItem description]];
                    if ((j+1)%4==0) {
                        strAproveItems = [strAproveItems stringByAppendingString:@"</tr><tr>"];
                    }
                    if ((j+1)==array.count && array.count>=self.maxAproveNum) {//最后一个元素
                        strAproveItems = [strAproveItems substringToIndex:strAproveItems.length-4];
                    }
                }
                if (array.count<self.maxAproveNum)
                {
                    NSString* aproveItemId = [self getAproveItemIdByAttachments:strAttachments andSeqLevel:QAArray[i][@"seqlevel"]];
                    tmpAproveItem = [EnAproveItem aproveItemWithApproveItemId:aproveItemId andType:0 andFKQuestionid:QAArray[i][@"questionid"]];
                    strAproveItems= [strAproveItems stringByAppendingString:[tmpAproveItem description]];
                    strAproveItems = [strAproveItems stringByAppendingString:@"</tr>"];
                }
                [dicQuesAprove setObject:strAproveItems forKey:@"aproveitem"];
                [dicQuesAprove setObject:[QAArray[i][@"questionid"] stringByAppendingString:@"_aprove"] forKey:@"aproveid"];
            }
            else//该题尚无证据
            {
                NSString* aproveItemId = [self getAproveItemIdByAttachments:strAttachments andSeqLevel:QAArray[i][@"seqlevel"]];
                tmpAproveItem = [EnAproveItem aproveItemWithApproveItemId:aproveItemId andType:0 andFKQuestionid:QAArray[i][@"questionid"]];
                strAproveItems= [strAproveItems stringByAppendingString:[tmpAproveItem description]];
                [dicQuesAprove setObject:strAproveItems forKey:@"aproveitem"];
                [dicQuesAprove setObject:[QAArray[i][@"questionid"] stringByAppendingString:@"_aprove"] forKey:@"aproveid"];
            }
            if (![QAArray[i][@"appendprove"] isEqualToString:@"0"])//不可追加证据
            {
                [dicQuesAproveArray addObject:dicQuesAprove];
            }
        }
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dicQuesAproveArray options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        if (data == nil) {
            return nil;
        }
        
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //return dicQuesAprove;
    }
    return nil;
}

//有附件时，从1-12编号中排出已有的编号，取剩余编号的最小值
//无附件时（即参数为空），取序号1
-(NSString*)getAproveItemIdByAttachments:(NSString*)attachments andSeqLevel:(NSString*)seqlevel
{
    if(attachments!=nil && attachments.length>0)//有附件证据
    {
        NSMutableArray* tmpArray = [[NSMutableArray alloc]init];
        for (int i=0; i<self.maxAproveNum; i++)
        {
            [tmpArray addObject:[NSString stringWithFormat:@"%d",(i+1)]];
        }
        NSArray* attachArray = [attachments componentsSeparatedByString:@","];
        for (int j=0; j<attachArray.count; j++)
        {
            NSArray* tmpA = [attachArray[j] componentsSeparatedByString:@"_"];
            if ([tmpArray containsObject:tmpA[1]]) {
                [tmpArray removeObject:tmpA[1]];
            }
        }
        return [NSString stringWithFormat:@"%@%@%@",seqlevel,@"_",tmpArray[0]];
    }
    else//无附件证据
    {
        return [seqlevel stringByAppendingString:@"_1"];
    }
}

-(NSString*)getQuestionAnswerByThirdLevelId:(NSString*)thirdLevelId
{
    if (thirdLevelId!=nil && thirdLevelId.length==9)
    {
        NSString* strSql = [NSString stringWithFormat:@"SELECT question.pkId questionid,option.pkId optionid FROM tbl_ass_quesstion question LEFT JOIN tbl_ass_process process ON question.pkId=process.fkQuestionid LEFT JOIN tbl_ass_question_option option ON (process.fkQuestionid=option.fkQuestion and process.answer=option.optionValue)WHERE question.fkLevel='%@';",thirdLevelId];
        NSArray* QAArray = [[SQLiteManager shareInstance] querySQL:strSql];
        //NSLog(@"%@",QAArray);
        NSData *data = [NSJSONSerialization dataWithJSONObject:QAArray options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        if (data == nil) {
            return nil;
        }
        
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
    }
    return nil;
}

//根据三级指标读取试题
-(NSString*)readLevelQuestionByLevelId:(NSString*)levelid
{
    NSString* levelQPath = [self.levelHTMLPath stringByAppendingPathComponent:[levelid stringByAppendingString:@".txt"]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:levelQPath])
    {
        [self makeLevelHTMLByPaper];
    }
    NSData* qData = [[NSFileManager defaultManager] contentsAtPath:levelQPath];
    return [[NSString alloc] initWithData:qData encoding:NSUTF8StringEncoding];
}

//根据试卷制作三级指标html
//每个三级指标下的试题生成一个三级指标html
//生成的html以三级指标id(levelid)命名，例如(001001001.txt)
//生成的html文件存放在沙盒的/document/levelhtml/，文件夹中
//将试题及选项存放到数据库中
-(BOOL)makeLevelHTMLByPaper
{
    EnPaper* paper = [self getPaperFromXMLPaper];
    [self deleteExistHTMLFile];//清理已存在的html文件
    
    if(![self SavePaperToDB:paper])//将试卷保存到数据库
    {
        return false;
    }
    
    //NSLog(@"%@",[levelQues description]);
    if (paper!=nil && paper.levelquestionArray.count>0)
    {
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
    else
    {
        return false;
    }
    
    return true;
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
                question = [EnQuestion questionWithPKID:questions[i][@"pkId"] andLevel:questions[i][@"fkLevel"] andSeqLevel:questions[i][@"seqLevel"] andFormula:questions[i][@"fkFormula"] andContentTip:questions[i][@"contenttip"] andContent:questions[i][@"content"] andDescription:questions[i][@"description"] andSeq:[questions[i][@"seq"] intValue] andType:[questions[i][@"type"] intValue] andWeight:[questions[i][@"weight"] floatValue] andVeto:[questions[i][@"veto"] intValue] andAppendProve:[questions[i][@"appendprove"] intValue] andCalculated:[questions[i][@"calculated"] intValue] andDeleted:[questions[i][@"deleted"] intValue] andQuestionNum:[questions[i][@"questionnum"] intValue]];
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

//将试卷保存到数据库中（包括题和选项）
-(BOOL)SavePaperToDB:(EnPaper*)paper
{
    if (paper!=nil && paper.levelquestionArray.count>0)
    {
        EnLevelQuestion* levelQues;
        EnQuestion* tmpQues;
        EnOption* tmpOpt;
        for (int i=0; i<paper.levelquestionArray.count; i++) {
            levelQues = (EnLevelQuestion*)paper.levelquestionArray[i];
            for (int j=0; j<levelQues.questionArray.count; j++) {
                tmpQues = (EnQuestion*)levelQues.questionArray[j];
                if(![tmpQues insertSelfToDB])
                {
                    return false;
                }
                for (int k=0; k<tmpQues.optionArray.count; k++) {
                    tmpOpt = (EnOption*)tmpQues.optionArray[k];
                    if(![tmpOpt insertSelfToDB])
                    {
                        return false;
                    }
                }
            }
        }
    }
    else
    {
        return false;
    }
    
    return true;
}

-(NSString *)levelHTMLPath {
    if (_levelHTMLPath == nil) {
        //Document路径
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        _levelHTMLPath = [documentPath stringByAppendingPathComponent:@"levelhtml"];
    }
    
    return _levelHTMLPath;
}

//从配置文件取值，暂时定义为12
-(int)maxAproveNum {
    if (_maxAproveNum == 0) {
        _maxAproveNum=12;
    }
    
    return _maxAproveNum;
}

@end
