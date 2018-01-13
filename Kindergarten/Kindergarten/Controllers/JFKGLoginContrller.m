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

@implementation JFKGLoginContrller

-(void)loginByUsername:(NSString*)username andPassword:(NSString*)password
{
    //添加用户名、密码验证（待完善）
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
         if (dicResponse[@"success"]!=nil && [dicResponse[@"success"] isEqualToString:@"1"]) {
             //NSLog(@"%@",dicResponse);
             [userDefault setObject:dicResponse[@"ticketid"] forKey:@"ticketid"];
              
              DownloadManagerViewController* downloadManagerVC = [[DownloadManagerViewController alloc] init];
              downloadManagerVC.delegate = self;
              [self.currentVC presentViewController:downloadManagerVC animated:YES completion:nil];
         }
         else if([dicResponse[@"success"] isEqualToString:@"0"])
         {
             NSString* funMessage = [NSString stringWithFormat:@"alertLoginResult('%@');",dicResponse[@"message"]];
             [self.webView evaluateJavaScript:funMessage completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                 NSLog(@"response: %@ error: %@", response, error);
             }];
         }
     }failure:^(NSError * _Nonnull error) {
     
     }];
}

-(void)sendIsSuccess:(BOOL)isSuccess
{
    NSLog(@"%d",isSuccess);
    if (isSuccess) {
        JFKGRootViewController* rooVC = (JFKGRootViewController*)self.currentVC;
        [rooVC loadLocalHtmlByFilename:@"asslevel.html"];
    }
}

@end
