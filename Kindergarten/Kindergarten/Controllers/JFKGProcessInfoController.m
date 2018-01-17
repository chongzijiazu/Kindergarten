//
//  ProcessInfoController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/17.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "JFKGProcessInfoController.h"
#import "EnProcessInfo.h"

@implementation JFKGProcessInfoController

//获取评估信息
-(BOOL)getProcessInfo
{
    /*__block BOOL isgood = true;
    
    [HttpRequestModel httpRequest:[HTTPInterface processinfo] withParamters:nil isPost:NO success:^(id  _Nullable responseObject)
     {
         NSDictionary* dicResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"%@",dicResponse);
         //将数据写入数据库
     }failure:^(NSError *error) {
         isgood=false;
     }];
    
    return isgood;*/
    
    return [self SaveProcessInfo:@""];
}

//根据json串返回评估信息实体数组
-(BOOL)SaveProcessInfo:(NSString*)jsonProcess
{
    //从本地文件获取模拟数据，测试用，实际从网络接口获取
     NSString* processPath = [[NSBundle mainBundle] pathForResource:@"processinfo" ofType:@"txt"];
    NSData* processData = [NSData dataWithContentsOfFile:processPath];
    NSArray* arrProc = [NSJSONSerialization JSONObjectWithData:processData options:NSJSONReadingMutableContainers error:nil];
    
    //NSLog(@"%@",arrProc);
    if (arrProc!=nil && arrProc.count>0) {
        EnProcessInfo* proc;
        for (int i=0; i<arrProc.count; i++) {
            proc = [[EnProcessInfo alloc] initWithDict:arrProc[i]];
            if (![proc insertSelfToDB]) {
                return false;
            }
        }
    }
    return true;
}

@end
