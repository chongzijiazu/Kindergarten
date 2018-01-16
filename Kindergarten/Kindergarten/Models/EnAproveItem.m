//
//  EnAproveItem.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/16.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnAproveItem.h"

@implementation EnAproveItem

@synthesize aproveItemId=_aproveItemId;
@synthesize type;

-(id)initWithAproveItemId:(NSString*)mAproveItemId andType:(int)mType
{
    if (self=[super init]) {
        self.aproveItemId = mAproveItemId;
        self.type = mType;
    }
    return self;
}

+(id)aproveItemWithApproveItemId:(NSString*)mAproveItemId andType:(int)mType
{
    EnAproveItem* item = [[EnAproveItem alloc] initWithAproveItemId:mAproveItemId andType:mType];
    return item;
}

//按html格式描述证据项
/*
 已有证据项模板示例：
 <td id="001-001001-001001001-1_1" type="1" onclick="proveItemClick(this.id,this.type);">
 <img src="images/image.png"/>
 </td>
 
 可添加证据项模板示例：
 <td id="001-001001-001001001-1_2" type="0" onclick="proveItemClick(this.id,this.type);">
 <img src="images/add.png"/>
 </td>
 */
-(NSString*)description
{
    if (self.type==1)//已有证据项
    {
        return [NSString stringWithFormat:@"<td id=\"%@\" type=\"1\" onclick=\"proveItemClick(this.id,this.type);\"><img src=\"images/image.png\"/></td>",self.aproveItemId];
    }
    else if(self.type==0)
    {
        return [NSString stringWithFormat:@"<td id=\"%@\" type=\"0\" onclick=\"proveItemClick(this.id,this.type);\"><img src=\"images/add.png\"/></td>",self.aproveItemId];
    }
    else
    {
        return @"";
    }
}

@end
