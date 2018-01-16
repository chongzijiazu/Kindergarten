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

@interface JFKGLevelController()
{
    NSString* _assLevelPath;//处理过的评估指标保存路径，html需要的内容
}
@property(nonatomic,copy)NSString* assLevelPath;

@end

@implementation JFKGLevelController

//读取页面所需数据
-(NSString*)readLevelData
{
    //读取院所信息数据
    //读取评估时间
    //读取个人信息
    
    //读取评估指标数据
    //生成评估指标内容后,保存到沙盒／document/assLevel/,文件夹下，名称为asslevel.txt,以备加载页面使用
    NSString* levelTable=@"";
    NSString* assLevelSavePath = [self.assLevelPath stringByAppendingPathComponent:@"assLevel.txt"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:assLevelSavePath])
    {
        NSData* asslevelData = [[NSFileManager defaultManager] contentsAtPath:assLevelSavePath];
        levelTable = [[NSString alloc] initWithData:asslevelData encoding:NSUTF8StringEncoding];
        
    }
    else
    {
        NSString* levelXMLPath = [[NSBundle mainBundle] pathForResource:@"level" ofType:@"xml"];
        levelTable = [LevelTableCreator CreateTreeFromLevelXML:levelXMLPath];
        [[NSFileManager defaultManager] createDirectoryAtPath:self.assLevelPath withIntermediateDirectories:YES attributes:nil error:nil];
        [[NSFileManager defaultManager] createFileAtPath:assLevelSavePath contents:[levelTable dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    }
    
    
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

-(NSString *)assLevelPath {
    if (_assLevelPath == nil) {
        //Document路径
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        _assLevelPath = [documentPath stringByAppendingPathComponent:@"assLevel"];
    }
    
    return _assLevelPath;
}
@end
