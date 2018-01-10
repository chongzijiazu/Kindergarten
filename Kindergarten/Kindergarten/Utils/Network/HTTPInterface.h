//
//  HTTPInterface.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPInterface : NSObject

//登录
+(NSString*)login;

//下载指标数据
+(NSString*)downloadlevelcontent;

@end
