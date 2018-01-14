//
//  EnQuestion.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/14.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnQuestion : NSObject
{
    NSString* _pk_id;
    NSString* _fk_level;
    int seq;
    NSString* _seq_level;
    int questionnum;
    int type;
    float weight;
    int veto;
    int appendprove;
    int calculated;
    NSString* _fk_formula;
    int deleted;
    NSString* _contenttipmediumtext;
    NSString* _content;
    NSString* _description;
    
    
}

@end
