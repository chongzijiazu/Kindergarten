//
//  LevelViewController.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView* _webView;
}

@property(strong,nonatomic)UIWebView* webView;

@end
