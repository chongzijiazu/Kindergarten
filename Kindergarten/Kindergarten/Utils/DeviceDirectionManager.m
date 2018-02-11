//
//  DeviceDirectionManager.m
//  Kindergarten
//
//  Created by junfeng on 2018/2/11.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "DeviceDirectionManager.h"

@interface DeviceDirectionManager ()

@end

@implementation DeviceDirectionManager

static DeviceDirectionManager *instance;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });

    return instance;
}

-(id)init
{
    if (self = [super init]) {
        self.isRight=1;
    }
    return self;
}

@end
