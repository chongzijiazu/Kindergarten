//
//  DeviceDirectionManager.h
//  Kindergarten
//
//  Created by junfeng on 2018/2/11.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceDirectionManager : NSObject
@property (nonatomic,assign) int isRight;
//类方法生成单例对象
+(instancetype)shareInstance;

@end
