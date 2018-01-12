//
//  WebViewModel.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/11.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol WebViewJSExport <JSExport>

/** 遵守了 协议后 这些方法就暴露给 js 调用 **/


/** jsCallOC **/
- (void)jsCallOC;
- (void)jsCallOCWithString:(NSString *)string;

//js调用时候取函数名就好了,不要冒号 jsCallOCWithTitleMessage
- (void)jsCallOCWithTitle:(NSString *)title message:(NSString *)msg;

- (void)jsCallOCWithDictionary:(NSDictionary *)dictionary;
- (void)jsCallOCWithArray:(NSArray *)array;

/** ocCallJS **/
- (void)ocCallJS;
- (void)ocCallJS:(NSString*)functionname withString:(NSString *)string;
- (void)ocCallJSWithTitle:(NSString *)title message:(NSString *)message;

- (void)ocCallJSWithDictionary:(NSDictionary *)dictionary;
- (void)ocCallJSWithArray:(NSArray *)array;

@end

@interface WebViewModel : NSObject <WebViewJSExport>

@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) UIViewController *currentVC;

@end
