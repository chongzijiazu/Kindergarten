//
//  EnOption.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/14.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnOption : NSObject
{
    NSString* _optionvalue;
    NSString* _normal;
    float weight;
}

@property(nonatomic,copy)NSString* optionvalue;
@property(nonatomic,copy)NSString* normal;
@property(nonatomic,assign)float weight;

@end
