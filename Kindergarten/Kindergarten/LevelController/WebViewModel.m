//
//  WebViewModel.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/11.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "WebViewModel.h"
#import "UploadViewController.h"

@implementation WebViewModel


#pragma mark - jsCallOC

-(void)jsCallOCForUpload
{
    //NSLog(@"uploadData");
    UploadViewController *uploadVC = [[UploadViewController alloc]init];
    uploadVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键
    //UIModalPresentationOverFullScreen全屏效果
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.currentVC presentViewController:uploadVC animated:YES completion:nil];
    });
    
}

- (void)jsCallOC {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"登出后将清空评估数据，请确保评估数据已上传" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //清空ticketid
             [userDefault setObject:@"" forKey:@"ticketid"];
             
             //清理本地数据（文件及数据库）
             
             //回到根视图控制器
             [self.currentVC.navigationController popToRootViewControllerAnimated:NO];
            
        }]];
        
        [self.currentVC presentViewController:alertController animated:YES completion:nil];
        
    });
}


- (void)jsCallOCWithString:(NSString *)string {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:string
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"I konw"
                                              otherButtonTitles:nil, nil];
        [alert show];
    });
}
- (void)jsCallOCWithTitle:(NSString *)title message:(NSString *)msg {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"I konw"
                                              otherButtonTitles:nil, nil];
        [alert show];
    });
}



- (void)jsCallOCWithDictionary:(NSDictionary *)dictionary {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:dictionary[@"title"]
                                                        message:dictionary[@"message"]
                                                       delegate:nil
                                              cancelButtonTitle:@"I konw"
                                              otherButtonTitles:nil, nil];
        [alert show];
    });
    
    NSLog(@"===== %@",dictionary);
}

- (void)jsCallOCWithArray:(NSArray *)array {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:array[0]
                                                        message:array[1]
                                                       delegate:nil
                                              cancelButtonTitle:@"I konw"
                                              otherButtonTitles:nil, nil];
        [alert show];
    });
    
    NSLog(@"===== %@",array);
}




#pragma mark - OCCallJS
- (void)ocCallJS {
    JSValue *jsFunc = self.jsContext[@"func1"];
    [jsFunc callWithArguments:nil];
}

- (void)ocCallJS:(NSString*)functionname withString:(NSString *)string {
    JSValue *jsFunc = self.jsContext[functionname];
    [jsFunc callWithArguments:@[string]];
}

- (void)ocCallJSWithTitle:(NSString *)title message:(NSString *)message {
    
}

- (void)ocCallJSWithDictionary:(NSDictionary *)dictionary {
    
}
- (void)ocCallJSWithArray:(NSArray *)array {
    
}

@end
