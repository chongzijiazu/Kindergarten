//
//  LevelNode.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/12.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelNode : NSObject
{
    NSString* _levelId;
    NSString* _name;
    NSMutableArray* _childNodes;
}

@property(nonnull,copy)NSString* levelId;
@property(nonnull,copy)NSString* name;

@end
