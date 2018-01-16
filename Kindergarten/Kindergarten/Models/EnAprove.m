//
//  EnAprove.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/15.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "EnAprove.h"

@implementation EnAprove

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
    NSString* aproveHtml = @"<table class=\"table table-condensed\" style=\"border-top: 0px solid white;\"><thead><tr><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td><td><img src=\"images/image.png\"/></td></tr><tr><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td><td><img src=\"images/add.png\"/></td></tr><tr></tr></thead></table><div><textarea class=\"form-control\" rows=\"3\" placeholder=\"请输入文字内容\"></textarea></div>";
    
    return aproveHtml;
}

@end
