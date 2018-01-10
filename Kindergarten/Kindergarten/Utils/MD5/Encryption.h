//
//  Encrption.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface Encryption : NSObject
//md5加密方法
+ (NSString *)md5:(NSString *)string;
@end
