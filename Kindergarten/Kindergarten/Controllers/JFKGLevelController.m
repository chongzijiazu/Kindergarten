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

@synthesize sortedThirdLevelArray=_sortedThirdLevelArray;

//生成指标体系table格式文件，并保存
-(void)makeAssLevelFile
{
    NSString* levelTable=@"";
    NSString* assLevelSavePath = [self.assLevelPath stringByAppendingPathComponent:@"assLevel.txt"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:assLevelSavePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:self.assLevelPath error:nil];
    }
 
    NSString* levelXMLPath = [[NSBundle mainBundle] pathForResource:@"level" ofType:@"xml"];
    LevelTableCreator* levelTabelC =[[LevelTableCreator alloc]init];
    levelTable = [levelTabelC CreateTreeFromLevelXML:levelXMLPath];
    [[NSFileManager defaultManager] createDirectoryAtPath:self.assLevelPath withIntermediateDirectories:YES attributes:nil error:nil];
    [[NSFileManager defaultManager] createFileAtPath:assLevelSavePath contents:[levelTable dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
}

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
        LevelTableCreator* levelTabelC = [[LevelTableCreator alloc] init];
        levelTable = [levelTabelC CreateTreeFromLevelXML:levelXMLPath];
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
    uploadVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.625f];
    
    [self.currentVC presentViewController:uploadVC animated:YES completion:nil];
}

//获得排序后的三级指标id数组
-(NSArray*)getSortedThirdlevelArray
{
    NSArray* stArray=nil;
    NSString* levelXMLPath = [[NSBundle mainBundle] pathForResource:@"level" ofType:@"xml"];
    LevelTableCreator* levelTabelC = [[LevelTableCreator alloc] init];
    NSArray* levelArray = [levelTabelC getSortedLevelArrayFromLevelXmlFile:levelXMLPath];
    
    NSMutableArray* tmpArray;
    if (levelArray!=nil && levelArray.count>0) {
        tmpArray = [[NSMutableArray alloc] init];
        NSString* strpkId=nil;
        for (int i=0; i<levelArray.count; i++) {
            strpkId = (NSString*)levelArray[i][@"pkId"];
            if (strpkId.length==9) {
                [tmpArray addObject:strpkId];
            }
        }
        stArray = (NSArray*)tmpArray;
        [stArray sortedArrayUsingSelector:@selector(compare:)];
        
    }
    
    return stArray;
}

-(NSString*)getNextThirdLevelIdByCurrentThirdLevelId:(NSString*)currentThirdLevelId
{
    NSString* nextid=nil;
    
    if (self.sortedThirdLevelArray!=nil && self.sortedThirdLevelArray.count>0) {
        NSString* tmpid;
        for (int i=0; i<self.sortedThirdLevelArray.count; i++) {
            tmpid = (NSString*)self.sortedThirdLevelArray[i];
            if ([tmpid isEqualToString:currentThirdLevelId]) {
                if ((i+1)<self.sortedThirdLevelArray.count) {
                    nextid=(NSString*)self.sortedThirdLevelArray[i+1];
                }
                break;
            }
        }
    }
    
    return nextid;
}

-(NSString*)getPreThirdLevelIdByCurrentThirdLevelId:(NSString*)currentThirdLevelId
{
    NSString* preid=nil;
    
    if (self.sortedThirdLevelArray!=nil && self.sortedThirdLevelArray.count>0) {
        NSString* tmpid;
        for (int i=0; i<self.sortedThirdLevelArray.count; i++) {
            tmpid = (NSString*)self.sortedThirdLevelArray[i];
            if ([tmpid isEqualToString:currentThirdLevelId]) {
                if ((i-1)>=0) {
                    preid=(NSString*)self.sortedThirdLevelArray[i-1];
                }
                break;
            }
        }
    }
    
    return preid;
}

-(NSString *)assLevelPath {
    if (_assLevelPath == nil) {
        //Document路径
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        _assLevelPath = [documentPath stringByAppendingPathComponent:@"assLevel"];
    }
    
    return _assLevelPath;
}

-(NSArray*)sortedThirdLevelArray {
    if (_sortedThirdLevelArray == nil) {
        _sortedThirdLevelArray = [self getSortedThirdlevelArray];
    }
    
    return _sortedThirdLevelArray;
}
@end
