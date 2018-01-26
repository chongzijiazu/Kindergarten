//
//  JFKGAproveController.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/16.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface JFKGAproveController : NSObject<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, weak) UIViewController *currentVC;

- (void)getAproveByAproveItemId:(NSString*)aproveitemid andQuestionId:(NSString*)mquestionid andFKLevel:(NSString*)fklevel;
-(BOOL)isMayAppend:(NSString*)questionid;

@end
