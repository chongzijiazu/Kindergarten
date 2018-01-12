//
//  LoginViewController.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UIWebViewDelegate>
{
    UITextField* _textField_Username;
    UITextField* _textField_Password;
    UIWebView* _webView;
}

@property(strong,nonatomic)UIWebView* webView;

-(void)loginByUsername:(NSString*)username andPassword:(NSString*)password;
@end
