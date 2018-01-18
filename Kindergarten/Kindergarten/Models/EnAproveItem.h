//
//  EnAproveItem.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/16.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnAproveItem : NSObject
{
    NSString* _aproveItemId;//以指标编码和题号、序号命名（例如：001-001001-001001001-1_1）
    NSString* _fkQuestionid;
    int _type;//1:表示已有证据，0:表示可添加证据
}
@property(nonatomic,copy)NSString* aproveItemId;
@property(nonatomic,copy)NSString* fkQuestionid;
@property(nonatomic,assign)int type;

-(id)initWithAproveItemId:(NSString*)mAproveItemId andType:(int)mType andFKQuestionid:(NSString*)mFkQuestionid;
+(id)aproveItemWithApproveItemId:(NSString*)mAproveItemId andType:(int)mType andFKQuestionid:(NSString*)mFkQuestionid;

@end
