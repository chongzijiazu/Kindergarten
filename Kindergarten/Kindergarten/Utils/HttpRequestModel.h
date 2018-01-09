//
//  HttpRequestModel.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/9.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HttpRequestModel : NSObject

+ (HttpRequestModel *) sharedHttpRequestModel;

//主线程请求数据
+ (void)httpRequest:(NSString *)urlString withParamters:(NSDictionary *)dic isPost:(BOOL)isPost withDeletegte:(__weak UIViewController *)tager success:(SEL)success failure:(SEL)failure;

//子线程请求数据
+ (void)httpRequest:(NSString *)urlString withParamters:(NSDictionary *)dic isPost:(BOOL)isPost success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

@end
