//
//  Base64Util.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/19.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64Util : NSObject
+(NSString*)Encode:(NSString*)str;
+(NSString*)Decode:(NSString*)str;
@end
