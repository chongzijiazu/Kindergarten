//
//  JFKGLoginContrller.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/13.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "DownloadManagerViewController.h"

@interface JFKGLoginContrller : NSObject<DownloadManagerDelegate>

@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, weak) UIViewController *currentVC;

-(void)loginByUsername:(NSString*)username andPassword:(NSString*)password;

@end
