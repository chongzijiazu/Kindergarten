//
//  EnAprove.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/15.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnAprove.h"
#import "EnAproveItem.h"

@implementation EnAprove

@synthesize pkId=_pkId;
@synthesize thirdLevelId=_thirdLevelId;
@synthesize questionnum;
@synthesize aproveItemNum;
@synthesize aproveItemArray=_aproveItemArray;

-(id)initWithPkId:(NSString*)mpkId andThirdLevelId:(NSString*)mThirdLevelId andQuestionNum:(int)mQuestionNum andAproveItemNum:(int)mAproveItemNum
{
    if (self=[super init]) {
        self.aproveItemNum=mAproveItemNum;
        self.pkId = mpkId;
        self.thirdLevelId=mThirdLevelId;
        self.questionnum=mQuestionNum;
        self.aproveItemArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+(id)aproveWithPkId:(NSString*)mpkId andThirdLevelId:(NSString*)mThirdLevelId andQuestionNum:(int)mQuestionNum andAproveItemNum:(int)mAproveItemNum
{
    EnAprove* ap = [[EnAprove alloc] initWithPkId:mpkId andThirdLevelId:mThirdLevelId andQuestionNum:mQuestionNum andAproveItemNum:mAproveItemNum];
    return ap;
}

/*
 证据文件模板示例：
 <table class="table table-condensed" style="border-top: 0px solid white;">
 <thead>
 <tr>
 <td>
 <img src="images/image.png"/>
 </td>
 <td>
 <img src="images/image.png"/>
 </td>
 <td>
 <img src="images/image.png"/>
 </td>
 <td>
 <img src="images/image.png"/>
 </td>
 <td>
 <img src="images/image.png"/>
 </td>
 <td>
 <img src="images/image.png"/>
 </td>
 </tr>
 <tr>
 <td>
 <img src="images/add.png"/>
 </td>
 <td>
 <img src="images/add.png"/>
 </td>
 <td>
 <img src="images/add.png"/>
 </td>
 <td>
 <img src="images/add.png"/>
 </td>
 <td>
 <img src="images/add.png"/>
 </td>
 <td>
 <img src="images/add.png"/>
 </td>
 </tr>
 <tr>
 </tr>
 </thead>
 </table>
 <div>
 <textarea class="form-control" rows="3" placeholder="请输入文字内容"></textarea>
 </div>
 */
//按html格式描述证据文件
-(NSString*)description
{
    NSString* aproveHtml = @"<table class=\"table table-condensed\" style=\"border-top: 0px solid white;\"><thead><tr><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td></tr><tr><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td><td onclick=\"addaprove();\"><img src=\"images/add.png\"/></td></tr><tr></tr></thead></table><div><textarea class=\"form-control\" rows=\"3\" placeholder=\"请输入文字内容\"></textarea></div>";
    
    return aproveHtml;
}

//创建证据项html串
-(NSString*)createAproveItem
{
    NSString* aproveItemsHtml= [[NSString alloc]init];
    
    EnAproveItem* item;
    for (int j=0; j<self.aproveItemArray.count; j++)
    {
        item = (EnAproveItem*)self.aproveItemArray[j];
        aproveItemsHtml = [aproveItemsHtml stringByAppendingString:[item description]];
    }
    //补足可添加证据项
    for (int i=0; i<self.aproveItemNum-self.aproveItemArray.count; i++) {
        
    }
    
    return aproveItemsHtml;
}


@end
