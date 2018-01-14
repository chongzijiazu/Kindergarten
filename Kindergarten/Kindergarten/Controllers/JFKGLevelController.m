//
//  JFKGLevelController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/13.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "JFKGLevelController.h"
#import "JFKGRootViewController.h"
#import "LevelTableCreator.h"
#import "UploadViewController.h"

@implementation JFKGLevelController

//读取页面所需数据
-(NSString*)readLevelData
{
    //读取院所信息数据
    //读取评估时间
    //读取个人信息
    
    //读取评估指标数据
    NSString* levelXMLPath = [[NSBundle mainBundle] pathForResource:@"level" ofType:@"xml"];
    NSString* levelTable = [LevelTableCreator CreateTreeFromLevelXML:levelXMLPath];
    return levelTable;
}

-(void)sendLevelTableToView
{
    //向页面发送评估指标数据
    NSString* levelTable = [self readLevelData];
    if(levelTable!=nil && levelTable.length>0) {
        NSString* scriptStr = [NSString stringWithFormat:@"showLevelTable('%@');",levelTable];
        
        [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
        }];
    }
}

-(void)uploadData
{
    //上传评估数据
    UploadViewController *uploadVC = [[UploadViewController alloc]init];
    uploadVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键
    //UIModalPresentationOverFullScreen全屏效果
    
    [self.currentVC presentViewController:uploadVC animated:YES completion:nil];
}
@end
