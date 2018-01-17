//
//  EnAprove.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/15.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnAprove : NSObject
{
    NSString* _pkId;//试题的主键
    NSString* _seqLevel;//1-1-1-1
    int aproveItemNum;//可添加证据的数量（从系统配置项中获取）
    NSMutableArray* _aproveItemArray;//证据包含的证据项
}

@property(nonatomic,copy)NSString* pkId;
@property(nonatomic,copy)NSString* seqLevel;
@property(nonatomic,assign)int aproveItemNum;
@property(nonatomic,strong)NSMutableArray* aproveItemArray;

-(id)initWithPkId:(NSString*)mpkId andSeqLevel:(NSString*)mseqlevel andAproveItemNum:(int)mAproveItemNum;
+(id)aproveWithPkId:(NSString*)mpkId andSeqLevel:(NSString*)mseqlevel andAproveItemNum:(int)mAproveItemNum;

@end
