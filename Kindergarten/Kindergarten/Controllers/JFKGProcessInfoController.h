//
//  ProcessInfoController.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/17.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface JFKGProcessInfoController : NSObject
@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, weak) UIViewController *currentVC;

-(BOOL)getProcessInfo;
+(BOOL)saveQuestionAnswerToDB:(NSDictionary*)dicQuesAns;
+(BOOL)saveMemoToDocument:(NSDictionary*)dicMemo;

@end
