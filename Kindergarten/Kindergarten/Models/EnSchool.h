//
//  EnSchool.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/19.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnSchool : NSObject

@property(nonatomic,copy)NSString* pkId;
@property(nonatomic,copy)NSString* fkarea;
@property(nonatomic,copy)NSString* idcode;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* adress;
@property(nonatomic,copy)NSString* adresscode;
@property(nonatomic,copy)NSString* seatkind;
@property(nonatomic,copy)NSString* seatcode;
@property(nonatomic,copy)NSString* holdkind;
@property(nonatomic,copy)NSString* holdcode;
@property(nonatomic,copy)NSString* creatorname;
@property(nonatomic,copy)NSString* creatorcode;
@property(nonatomic,assign)int isprivate;
@property(nonatomic,assign)int iscenter;
@property(nonatomic,assign)int info_type;
@property(nonatomic,assign)int registed;
@property(nonatomic,assign)int deleted;
@property(nonatomic,assign)int info13;
@property(nonatomic,assign)int info15;
@property(nonatomic,assign)int info16;
@property(nonatomic,assign)int info17;
@property(nonatomic,assign)int info18;
@property(nonatomic,assign)int info20;
@property(nonatomic,assign)int info21;
@property(nonatomic,assign)int info22;
@property(nonatomic,assign)int info23;
@property(nonatomic,assign)int info25;
@property(nonatomic,assign)int info26;
@property(nonatomic,assign)int info27;
@property(nonatomic,assign)int info28;
@property(nonatomic,assign)int info29;
@property(nonatomic,assign)int info30;
@property(nonatomic,assign)int info31;
@property(nonatomic,assign)int info32;
@property(nonatomic,assign)int info33;
@property(nonatomic,assign)int info34;
@property(nonatomic,assign)int info35;
@property(nonatomic,assign)int info36;
@property(nonatomic,assign)float info37;
@property(nonatomic,assign)float info38;
@property(nonatomic,assign)float info39;
@property(nonatomic,assign)float info40;
@property(nonatomic,assign)float info41;
@property(nonatomic,assign)float info42;
@property(nonatomic,assign)float info43;
@property(nonatomic,assign)float info44;
@property(nonatomic,assign)float info45;
@property(nonatomic,assign)float info46;
@property(nonatomic,assign)float info47;
@property(nonatomic,assign)float info48;
@property(nonatomic,assign)float info49;
@property(nonatomic,assign)float info50;
@property(nonatomic,assign)float info51;
@property(nonatomic,assign)float info52;
@property(nonatomic,assign)float info53;
@property(nonatomic,assign)float info54;
@property(nonatomic,assign)float info55;
@property(nonatomic,assign)float info56;
@property(nonatomic,assign)float info57;
@property(nonatomic,assign)float info58;
@property(nonatomic,assign)float info59;
@property(nonatomic,assign)float info60;
@property(nonatomic,assign)float info61;
@property(nonatomic,assign)float info62;
@property(nonatomic,assign)float info63;
@property(nonatomic,assign)float info64;
@property(nonatomic,assign)float info65;
@property(nonatomic,assign)float info66;
@property(nonatomic,assign)float info67;
@property(nonatomic,assign)float info68;
@property(nonatomic,assign)float info69;
@property(nonatomic,assign)float info70;

-(NSString*)replaceFormulaElement:(NSString*)fromulaElement;
+(NSArray *)allSchoolFromDB;

@end
