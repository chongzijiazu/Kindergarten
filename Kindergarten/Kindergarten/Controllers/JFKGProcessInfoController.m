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
    NSString * strUrl =[HTTPInterface processinfo];
    NSURL * url = [NSURL URLWithString:strUrl];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url];
    /** 接收数据 */
    NSError* err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:requst returningResponse:nil error:&err];
    if (err!=nil) {
        return false;
    }
    /** 解析数据 */
    NSDictionary * rootDict;
    //    int newVerson;
    if (responseData)
    {
        rootDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
    }
    if([rootDict objectForKey:@"processinfo"])
    {
        NSArray* arrProc = [rootDict objectForKey:@"processinfo"];
        return [self SaveProcessInfo:arrProc];
    }
    
    return true;
}

//根据json串返回评估信息实体数组
-(BOOL)SaveProcessInfo:(NSArray*)arrProc
{
    //从本地文件获取模拟数据，测试用，实际从网络接口获取
     //NSString* processPath = [[NSBundle mainBundle] pathForResource:@"processinfo" ofType:@"txt"];
    //NSData* processData = [NSData dataWithContentsOfFile:processPath];
    //NSArray* arrProc = [NSJSONSerialization JSONObjectWithData:processData options:NSJSONReadingMutableContainers error:nil];
    
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

//保存答案
+(BOOL)saveQuestionAnswerToDB:(NSDictionary*)dicQuesAns
{
    return [EnProcessInfo saveQuestionAnswer:dicQuesAns];
}

//保存提示信息
+(BOOL)saveMemoToDocument:(NSDictionary*)dicMemo
{
    NSString* aprovePath = [GlobalUtil getAprovePath];
    if (dicMemo!=nil && dicMemo.count>0) {
        for (NSString* key in dicMemo)
        {
            NSString* memoContent = dicMemo[key];
            NSArray *array = [key componentsSeparatedByString:@"_"];
            NSString* memoPath = [aprovePath stringByAppendingPathComponent:array[0]];
            memoPath = [memoPath stringByAppendingString:@".txt"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:memoPath]) {
                if (memoContent.length>0) {
                    [memoContent writeToFile:memoPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                }
                else
                {
                    [[NSFileManager defaultManager] removeItemAtPath:memoPath error:nil];
                }
            }
            else
            {
                if (memoContent.length>0) {
                    [memoContent writeToFile:memoPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                }
            }
            
        }
    }
    return true;
}

@end
