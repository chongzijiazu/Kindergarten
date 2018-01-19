//
//  EnFormula.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/19.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnSchool.h"

@interface EnFormula : NSObject

@property(nonatomic,copy)NSString* pkId;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* expression;
@property(nonatomic,copy)NSString* value;
+(BOOL)loadFormulaXMLToDB;
+(NSArray *)allFormulaFromDB;
+(NSDictionary*)translateExpression:(NSArray*)formulaArra bySchoolInfo:(NSDictionary*)dicSchool;

@end
