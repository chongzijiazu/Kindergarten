//
//  JFKGLevelController.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/13.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface JFKGLevelController : NSObject

@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, weak) UIViewController *currentVC;

-(NSString*)readLevelData;
-(void)sendLevelTableToView;
-(void)uploadData;

@end
