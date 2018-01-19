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
    //NSLog(@"%@",formulaArr);
    //EnSchool* school = [[EnSchool alloc] init];
    //[EnFormula translateExpression:formulaArr bySchoolInfo:school];
    NSArray* schoolArra = [EnSchool allSchoolFromDB];
    if (schoolArra!=nil&&schoolArra.count>0) {
        NSDictionary* dicSchool = (NSDictionary*)schoolArra[0];
        NSMutableDictionary* dicNewSchool = [[NSMutableDictionary alloc] init];
        NSString* newKey = [[NSString alloc]init];
        for (NSString* key in dicSchool) {
            newKey = [NSString stringWithFormat:@"{%@}",key];
            [dicNewSchool setObject:dicSchool[key] forKey:newKey];
        }
        
        NSDictionary* newFormulaDic = [EnFormula translateExpression:formulaArr bySchoolInfo:dicNewSchool];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:newFormulaDic options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        if (data == nil) {
            return false;
        }
        
        NSString* scriptStr= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",tmp);
        
    }
    
    
    return true;
}

@end
