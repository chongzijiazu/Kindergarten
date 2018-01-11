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

//下载评估指标
+(NSString*)downloadlevelcontent;

//下载评估试卷
+(NSString*)downloadpapercontent;

//下载公式
+(NSString*)downloadformulacontent;

//下载证据数据
+(NSString*)downloadattachmentcontent;

@end
