//
//  JFKGCommonController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/14.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "JFKGCommonController.h"
#import "JFKGRootViewController.h"
#import "EnFormula.h"
#import "EnOption.h"
#import "XMLDictionary.h"

@implementation JFKGCommonController

//登出操作
-(void)logout
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"登出后将清空评估数据，请确保评估数据已上传" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //清空ticketid
        [userDefault setObject:@"" forKey:@"ticketid"];
        //清空下载状态
        [userDefault setObject:@"" forKey:@"isDownloadSuccess"];
        //清空公式计算标志位
        [userDefault setObject:@"" forKey:@"isFormulaCalculated"];
        
        //清理本地数据（文件及数据库）
        //[GlobalUtil deleteExistDownloadFile]; //删除下载的文件
        //[GlobalUtil deleteAssLevelFile]; //删除评估指标文件
        //[GlobalUtil deleteLevelHtmlFile]; //删除试题html文件
        [GlobalUtil deleteAllDocumentsFile];//
        
        
        //回到登录页面
        JFKGRootViewController* rooVC = (JFKGRootViewController*)self.currentVC;
        [rooVC loadLocalHtmlByFilename:@"login.html"];
        
    }]];
    [self.currentVC presentViewController:alertController animated:YES completion:nil];
    /*NSDictionary *dict = @{@"ticketid": TICKETID};
     [HttpRequestModel httpRequest:[HTTPInterface logout] withParamters:dict isPost:NO success:^(id  _Nullable responseObject)
     {
     NSDictionary* dicResponse = [NSJSONSerialization JSONObjectWithData:responseObject
     options:NSJSONReadingMutableContainers
     error:nil];
     if (dicResponse[@"success"]!=nil && [dicResponse[@"success"] isEqualToString:@"1"]) {//登出成功
     //NSLog(@"%@",dicResponse);
     
     }
     else if([dicResponse[@"success"] isEqualToString:@"0"])//登出失败
     {
     
     }
     }failure:^(NSError * _Nonnull error) {
     
     }];*/
}

//处理答题过程中用到的公式信息
-(BOOL)processFormulaInfo
{
    NSArray* formulaArr = [EnFormula allFormulaFromDB];
    NSDictionary* dicSchool = [EnSchool loadSchoolInfoToDBFromFile];
    if (dicSchool!=nil && dicSchool.count>0) {
        NSMutableDictionary* dicNewSchool = [[NSMutableDictionary alloc] init];
        NSString* newKey = [[NSString alloc]init];
        for (NSString* key in dicSchool) {
            newKey = [NSString stringWithFormat:@"{%@}",key];
            [dicNewSchool setObject:dicSchool[key] forKey:newKey];
        }
        NSDictionary* newFormulaDic = [EnFormula translateExpression:formulaArr bySchoolInfo:dicNewSchool];
        if (newFormulaDic!=nil && newFormulaDic.count>0) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:newFormulaDic options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
            if (data == nil) {
                return false;
            }
            NSString* scriptStr= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"%@",tmp);
            scriptStr = [NSString stringWithFormat:@"calculateFormula(%@);",scriptStr];
            
            [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                NSLog(@"response: %@ error: %@", response, error);
            }];
        }
    }
    else
    {
        return false;
    }
    
    return true;
}

+(BOOL)saveFormulaValue:(NSDictionary*)dicFormula
{
    NSArray* formulas = [EnFormula allFormulaFromDB];
    
    if(formulas!=nil&&formulas.count>0)
    {
        EnFormula* formua;
        for (int i=0; i<formulas.count; i++) {
            formua = (EnFormula*)formulas[i];
            if ([[dicFormula allKeys]containsObject:formua.pkId]) {
                formua.value=[dicFormula objectForKey:formua.pkId];
                if(![formua updateValueToDB])
                {
                    return false;
                }
            }
        }
    }
    return true;
}

//从文件读取基本信息
+(NSString*)getBaseInfo
{
    //NSString* baseFilePath = [[NSBundle mainBundle] pathForResource:@"loginfo" ofType:@"txt"];
    NSString* baseFilePath =[GlobalUtil getLoginInfoPath];
   
    NSString* strBaseInfo = [NSString stringWithContentsOfFile:baseFilePath encoding:NSUTF8StringEncoding error:nil];
    
    return strBaseInfo;
}

+(EnPaper*)getPaperFromXMLPaper
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
                question = [EnQuestion questionWithPKID:questions[i][@"pkId"] andLevel:questions[i][@"_fkLevel"] andSeqLevel:questions[i][@"seqLevel"] andFormula:questions[i][@"fkFormula"] andContentTip:questions[i][@"contenttip"] andContent:questions[i][@"content"] andDescription:questions[i][@"description"] andSeq:[questions[i][@"seq"] intValue] andType:[questions[i][@"type"] intValue] andWeight:[questions[i][@"weight"] floatValue] andVeto:[questions[i][@"veto"] intValue] andAppendProve:[questions[i][@"appendprove"] intValue] andCalculated:[questions[i][@"calculated"] intValue] andDeleted:[questions[i][@"deleted"] intValue] andQuestionNum:[questions[i][@"questionnum"] intValue]];
                NSArray* options = questions[i][@"options"][@"option"];
                EnOption* option;
                for (int j=0; j<options.count; j++) {
                    option = [EnOption OptionWithContent:options[j][@"_content"] andOptionValue:options[j][@"_optionvalue"] andWeight:[options[j][@"_weight"] floatValue] andpkId:options[j][@"_pkId"] andfkQuestion:options[j][@"_fkQuestion"]];
                    [question.optionArray addObject:option];
                }
                
                if (![tmpPaper isExistLevelQuestionByLevelID:questions[i][@"_fkLevel"]])
                {
                    EnLevelQuestion* levelQuestion = [EnLevelQuestion LevelQuestionWithLevelID:questions[i][@"_fkLevel"]];
                    [tmpPaper.levelquestionArray addObject:levelQuestion];
                }
                EnLevelQuestion* tmpLevelQ = [tmpPaper getLevelQuestionByLevelID:questions[i][@"_fkLevel"]];
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
+(NSDictionary*)getDictionaryFromPaperXML
{
    //NSString* filepath = [[NSBundle mainBundle] pathForResource:@"paper" ofType:@"xml"];
    NSString* filepath = [GlobalUtil getPaperXMLPath];
    XMLDictionaryParser* parser = [[XMLDictionaryParser alloc] init];
    NSDictionary* dicPaper = [parser dictionaryWithFile:filepath];
    return dicPaper;
}

//将试卷保存到数据库中（包括题和选项）
+(BOOL)SavePaperToDB:(EnPaper*)paper
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

+(BOOL)SavePaperToDB
{
    EnPaper* paper = [self getPaperFromXMLPaper];
    return [self SavePaperToDB:paper];
}

-(void)showHelpFile:(NSString*)helpfilepath
{
    if (helpfilepath!=nil&&helpfilepath.length>0) {
        _docController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:helpfilepath]];
        _docController.delegate = self;
        CGRect rect = CGRectMake(self.currentVC.view.frame.size.width/2-100, 0, 200, 200);
        
        if ([[[helpfilepath pathExtension] lowercaseString] isEqualToString:@"pdf"]) {
            [_docController presentPreviewAnimated:NO];
        }
        else
        {
            [_docController presentOpenInMenuFromRect:rect inView:self.currentVC.view animated:YES];
        }
    }
    {
        [self showAlertView:@"无帮助文档"];
    }
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    
    return self.currentVC;
    
}
- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    
    return self.currentVC.view;
    
}
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return  self.currentVC.view.frame;
}

- (void)showAlertView:(NSString *)message
{
    NSString *title = @"提示";
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }];
    [alertController addAction:OKAction];
    
    [self.currentVC presentViewController:alertController animated:YES completion:nil];
}

//将试卷中的描述信息图片拷贝至html根目录
+(void)copyFileToAppDesc
{
    NSString* basePath = [[NSBundle mainBundle] bundlePath];
    basePath = [basePath stringByAppendingString:@"/app/desc"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:basePath]) {
        NSString* downloadpath = [GlobalUtil getDownloadFilesPath];
        NSString* descPath =[downloadpath stringByAppendingPathComponent:@"paper"];
        BOOL isgood = [[NSFileManager defaultManager] copyItemAtPath:descPath toPath:basePath error:NULL];
    }
}

@end
