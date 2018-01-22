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
    NSString* _aproveItemId;//以指标编码和题号、序号命名（例如：1-1-1-1_1）
    NSString* _fkQuestionid;
    int _type;//1:表示已有证据，0:表示可添加证据
    NSString* _fklevel;//所在三级指标id
}
@property(nonatomic,copy)NSString* aproveItemId;
@property(nonatomic,copy)NSString* fkQuestionid;
@property(nonatomic,assign)int type;
@property(nonatomic,copy)NSString* fklevel;

-(id)initWithAproveItemId:(NSString*)mAproveItemId andType:(int)mType andFKQuestionid:(NSString*)mFkQuestionid andFKLevel:(NSString*)mfklevel;
+(id)aproveItemWithApproveItemId:(NSString*)mAproveItemId andType:(int)mType andFKQuestionid:(NSString*)mFkQuestionid andFKLevel:(NSString*)mfklevel;

@end
