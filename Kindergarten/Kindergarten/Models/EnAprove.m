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
@synthesize seqLevel=_seqLevel;
@synthesize aproveItemNum;
@synthesize aproveItemArray=_aproveItemArray;

-(id)initWithPkId:(NSString*)mpkId andSeqLevel:(NSString*)mseqlevel andAproveItemNum:(int)mAproveItemNum
{
    if (self=[super init]) {
        self.aproveItemNum=mAproveItemNum;
        self.pkId = mpkId;
        self.seqLevel=mseqlevel;
        self.aproveItemArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+(id)aproveWithPkId:(NSString*)mpkId andSeqLevel:(NSString*)mseqlevel andAproveItemNum:(int)mAproveItemNum
{
    EnAprove* ap = [[EnAprove alloc] initWithPkId:mpkId andSeqLevel:mseqlevel andAproveItemNum:mAproveItemNum];
    return ap;
}

/*
 证据文件模板示例：
 <table class="table table-condensed" style="border-top: 0px solid white;">
 <thead>
 <tr>
 
 </tr>
 <tr>
 
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
    //NSString* aproveHtml = @"<table class=\"table table-condensed\" style=\"border-top: 0px solid white;\"><thead><tr><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td></tr><tr><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td><td onclick=\"addaprove();\"><img src=\"images/add.png\"/></td></tr><tr></tr></thead></table><div><textarea class=\"form-control\" rows=\"3\" placeholder=\"请输入文字内容\"></textarea></div>";
    NSString* aproveHtml=@"<table id=\"%@_aprove\" class=\"table table-condensed\" style=\"border-top: 0px solid white;\"><thead><tr></tr><tr></tr><tr></tr></thead></table><div><textarea id=\"%@_memo\" class=\"form-control quescontent\" rows=\"3\" placeholder=\"请输入文字内容\"></textarea></div>";
    aproveHtml = [NSString stringWithFormat:aproveHtml,self.pkId,self.seqLevel];
    
    return aproveHtml;
}


@end
