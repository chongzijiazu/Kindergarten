//
//  HttpRequestModel.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/9.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "HttpRequestModel.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@implementation HttpRequestModel

static HttpRequestModel *requestModel = nil;
+(HttpRequestModel *) sharedHttpRequestModel
{
    if (!requestModel)
    {
        requestModel = [[self alloc] init];
    }
    return requestModel;
}

//主线程请求数据
+ (void)httpRequest:(NSString *)urlString withParamters:(NSDictionary *)dic isPost:(BOOL)isPost withDeletegte:(__weak UIViewController *)tager success:(SEL)success failure:(SEL)failure
{
    //BLLog(@"请求开始...");
    [self printRequestUrlString:urlString withParamter:dic];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/plain", nil];
    
    __block MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    
    HUD.labelText = @"正在加载";
    HUD.animationType = MBProgressHUDAnimationFade;
    [HUD show:YES];
    
    //判断网络状况
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];  //开始监听
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        if (status == AFNetworkReachabilityStatusNotReachable)
        {
            HUD.animationType = MBProgressHUDModeText;
            HUD.labelText = @"无可用网络 !";
            return;
        }
        else if (status == AFNetworkReachabilityStatusUnknown)
        {
            //BLLog(@"未知网络");
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWWAN)
        {
            //BLLog(@"手机网络");
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            //BLLog(@"WiFi");
        }
    }];
    if (isPost)
    {
        [manager POST:urlString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if([tager respondsToSelector:success])
            {
                
                dispatch_async(dispatch_get_main_queue()
                               , ^{
                                   [tager performSelector:success withObject:responseObject afterDelay:1.0];
                                   //                                   HUD.labelText = @"正在加载";
                                   
                               });
                
            }
            
            [HUD performSelector:@selector(removeFromSuperview)  withObject:nil afterDelay:2.0];
            
            //             BLLog(@"请求成功");
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if([tager respondsToSelector:success])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tager performSelector:failure withObject:error afterDelay:1.0];
                });
                
                HUD.animationType = MBProgressHUDModeText;
                HUD.labelText=@"请求失败,重新发送请求";
            }
            [HUD performSelector:@selector(removeFromSuperview)  withObject:nil afterDelay:2.0];
            //BLLog(@"请求失败");
            
        }];
        
        
    }
    else
    {
        [manager GET:urlString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if([tager respondsToSelector:success])
            {
                
                dispatch_async(dispatch_get_main_queue()
                               , ^{
                                   [tager performSelector:success withObject:responseObject afterDelay:1.0];
                                   //                                   HUD.labelText=@"正在加载";
                               });
            }
            
            [HUD performSelector:@selector(removeFromSuperview)  withObject:nil afterDelay:2.0];
            //             HUD.mode=MBProgressHUDModeText;
            //             BLLog(@"请求成功");
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if([tager respondsToSelector:success])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tager performSelector:failure withObject:error afterDelay:1.0];
                    HUD.animationType = MBProgressHUDModeText;
                    HUD.labelText=@"请求失败,重新发送请求";
                    
                });
            }
            //             HUD.mode=MBProgressHUDModeText;
            [HUD performSelector:@selector(removeFromSuperview)  withObject:nil afterDelay:2.0];
            //             BLLog(@"请求失败");
            
        }];
    }
}

/* 2 * 子线程请求 */
+ (void)httpRequest:(NSString *)urlString withParamters:(NSDictionary *)dic isPost:(BOOL)isPost success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure
{
    [self printRequestUrlString:urlString withParamter:dic];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/plain", nil];
    
    //3.判断网络状况
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];  //开始监听
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         
         if (status == AFNetworkReachabilityStatusNotReachable)
         {
             [MBProgressHUD showError:@"无可用网络"];
             return;
             
         }else if (status == AFNetworkReachabilityStatusUnknown){
             
             //BLLog(@"未知网络");
             
             
         }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
             
             //BLLog(@"WiFi");
             
         }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
             
             //BLLog(@"手机网络");
         }
     }];
    
    
    
    if (isPost)
    {
        [manager POST:urlString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             if (success != nil)
             {
                 success(responseObject);
             }
         }
              failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error)
         {
             if (failure != nil)
             {
                 //NSLog(@"%@",error);
                 failure(error);
             }
             
             
         }];
    }
    else
    {
        
        __block MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
        
        
        HUD.animationType=MBProgressHUDAnimationFade;
        
        [HUD show:YES];
        
        [manager GET:urlString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             if (success != nil)
             {
                 success(responseObject);
             }
             
             [HUD performSelector:@selector(removeFromSuperview)  withObject:nil afterDelay:0.8];
             
         }
             failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error)
         {
             //NSLog(@"%@",error);
             if (failure != nil)
             {
                 failure(error);
             }
             HUD.animationType = MBProgressHUDModeText;
             
             HUD.labelText=@"请求失败,重新发送请求";
             
             [HUD performSelector:@selector(removeFromSuperview)  withObject:nil afterDelay:0.8];
         }];
    }
}

/*
 *打印请求地址
 */
+ (void)printRequestUrlString:(NSString *)urlString withParamter:(NSDictionary *)dic
{
    NSArray *dicKeysArray = [dic allKeys];
    NSString *urlWithParamterString = urlString;
    if (dicKeysArray.count != 0)
    {
        urlWithParamterString = [urlWithParamterString stringByAppendingString:@"?"];
    }
    for (NSInteger i = 0; i < dicKeysArray.count; i++)
    {
        urlWithParamterString = [urlWithParamterString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", dicKeysArray[i], [dic objectForKey:dicKeysArray[i]]]];
        if (i == dicKeysArray.count - 1)
        {
            urlWithParamterString = [urlWithParamterString substringToIndex:urlWithParamterString.length - 1];
        }
    }
    NSLog(@"\n\n路径--%@", urlWithParamterString);
}

@end
