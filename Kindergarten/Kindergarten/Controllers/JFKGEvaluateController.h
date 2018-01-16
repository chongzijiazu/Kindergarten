//
//  JFKGEvaluateController.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/14.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface JFKGEvaluateController : NSObject
{
    NSString* _levelHTMLPath;//html保存路径
    NSString* _currentLevelQuestionID;//当前要作答试题的三级指标id
}
@property(nonatomic,copy)NSString* levelHTMLPath;
@property(nonatomic,copy)NSString* currentLevelQuestionID;
@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, weak) UIViewController *currentVC;

-(void)makeLevelHTMLByPaper;
-(void)sendLevelQuestionToView;
@end
