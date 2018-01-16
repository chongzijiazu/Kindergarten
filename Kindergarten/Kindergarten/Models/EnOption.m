//
//  EnOption.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/14.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnOption.h"

@implementation EnOption

@synthesize content=_content;
@synthesize optionValue=_optionValue;
@synthesize pkId=_pkId;
@synthesize fkQuestion=_fkQuestion;
@synthesize weight;

-(id)initWithContent:(NSString*)mContent andOptionValue:(NSString*)mOptionValue andWeight:(int)mweight andpkId:(NSString*)mpkId andfkQuestion:(NSString*)mfkQuestion
{
    if (self=[super init]) {
        self.content = mContent;
        self.optionValue = mOptionValue;
        self.weight = mweight;
        self.pkId=mpkId;
        self.fkQuestion=mfkQuestion;
    }
    return self;
}

+(id)OptionWithContent:(NSString*)mContent andOptionValue:(NSString*)mOptionValue andWeight:(int)mweight andpkId:(NSString*)mpkId andfkQuestion:(NSString*)mfkQuestion
{
    EnOption* option = [[EnOption alloc] initWithContent:mContent andOptionValue:mOptionValue andWeight:mweight andpkId:mpkId andfkQuestion:mfkQuestion];
    return option;
}

/*
 选项html示例：
<label class="radio-inline">
<input type="radio" name="optionsRadiosinline" id="optionsRadios4" value="option2"/>
A.园舍独立，产权清晰，规划科学，布局合理，民办园自有房产需要有效的房产证，租用园舍的，需要有效期3年及以上的租赁合同及月舞房产证或土地证。
</label>
 */
//按html格式描述选项
-(NSString*)description
{
    NSString* optionHtml = [NSString stringWithFormat:@"<label class=\"radio-inline\"><input type=\"radio\" name=\"optionsRadiosinline\" id=\"optionsRadios4\" value=\"option2\"/>%@.%@</label><br></br>",self.optionValue,self.content];
    return optionHtml;
}

@end
