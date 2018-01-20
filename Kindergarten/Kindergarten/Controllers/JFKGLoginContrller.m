//
//  JFKGLoginContrller.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/13.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "JFKGLoginContrller.h"
#import "Encryption.h"
#import "JFKGRootViewController.h"
#import "SQLiteManager.h"

@implementation JFKGLoginContrller

-(void)loginByUsername:(NSString*)username andPassword:(NSString*)password
{
    /*//添加用户名、密码验证（待完善）
    if (username==nil || password==nil || username.length==0 || password.length==0) {
        //提示用户名密码不能为空
        [self.webView evaluateJavaScript:@"alertLoginResult('用户名密码不能为空');" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
        }];
        return;
    }
     NSLog(@"login");
     NSData* usernameData = [username dataUsingEncoding:NSUTF8StringEncoding];
     username = [usernameData base64EncodedStringWithOptions:1];
     password = [Encryption md5:password];
     NSDictionary *dict = @{@"account": username, @"password": password};
     
     __weak typeof (self) weakSelf = self;
     
     [HttpRequestModel httpRequest:[HTTPInterface login] withParamters:dict isPost:NO success:^(id  _Nullable responseObject)
     {
         NSDictionary* dicResponse = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:nil];
         if (dicResponse[@"success"]!=nil && [dicResponse[@"success"] isEqualToString:@"1"]) {//登录成功
             //NSLog(@"%@",dicResponse);
             [userDefault setObject:dicResponse[@"ticketid"] forKey:@"ticketid"];
              //登录成功，则保存登录信息（将院所，系统参数先保存到本地文件中，加载数据的时候再做处理）
     
              DownloadManagerViewController* downloadManagerVC = [[DownloadManagerViewController alloc] init];
              downloadManagerVC.delegate = self;
              [self.currentVC presentViewController:downloadManagerVC animated:YES completion:nil];
         }
         else if([dicResponse[@"success"] isEqualToString:@"0"])//登录失败
         {
             NSString* funMessage = [NSString stringWithFormat:@"alertLoginResult('%@');",dicResponse[@"message"]];
             [self.webView evaluateJavaScript:funMessage completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                 NSLog(@"response: %@ error: %@", response, error);
             }];
         }
     }failure:^(NSError * _Nonnull error) {
         
     }];*/
    
    //模拟登录，测试用
    [userDefault setObject:@"111111" forKey:@"ticketid"];
    NSString* loginfoPath = [[NSBundle mainBundle] pathForResource:@"schoolinfo" ofType:@".txt"];
    NSString* strLoginfo = [NSString stringWithContentsOfFile:loginfoPath encoding:NSUTF8StringEncoding error:nil];
    [self saveLoginInfoToDocument:strLoginfo];
    DownloadManagerViewController* downloadManagerVC = [[DownloadManagerViewController alloc] init];
    downloadManagerVC.delegate = self;
    downloadManagerVC.webView = self.webView;
    [self.currentVC presentViewController:downloadManagerVC animated:YES completion:nil];
}

//判断下载是否成功
-(void)sendIsSuccess:(BOOL)isSuccess
{
    //NSLog(@"%d",isSuccess);
    [userDefault setObject:@"1" forKey:@"isDownloadSuccess"]; //将下载状态改为成功
    if (isSuccess) {
        JFKGRootViewController* rooVC = (JFKGRootViewController*)self.currentVC;
        [rooVC loadLocalHtmlByFilename:@"asslevel.html"];
    }
}

//将登录信息保存到文件中
-(BOOL)saveLoginInfoToDocument:(NSString*)strLogInfo
{
    NSString* filePath = [GlobalUtil getLoginInfoPath];
    return [strLogInfo writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
