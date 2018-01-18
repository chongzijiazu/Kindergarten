//
//  JFKGAproveViewController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/18.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "JFKGAproveViewController.h"
#import "EnProcessInfo.h"
#import "JFKGEvaluateController.h"

@interface JFKGAproveViewController ()

@end

@implementation JFKGAproveViewController

@synthesize aproveItemId=_aproveItemId;
@synthesize questionid=_questionid;
@synthesize aproveImageView = _aproveImageView;

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"证据浏览";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backMain:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleteProve)];
    
    self.navigationController.navigationBar.hidden=NO;
    // Do any additional setup after loading the view.
    self.aproveImageView =[[UIImageView alloc]init];
    self.aproveImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.aproveImageView.frame = self.view.frame;
    [self.view addSubview:self.aproveImageView];
    
    [self showAprove];
}

-(void)showAprove
{
    if (self.aproveItemId!=nil && self.aproveItemId.length>0) {
        NSString *filePath = [GlobalUtil getAprovePath];
        filePath= [filePath stringByAppendingPathComponent:[self.aproveItemId stringByAppendingString:@".jpg"]];
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            NSData *imageData = [NSData dataWithContentsOfFile:filePath];
            UIImage *image = [UIImage imageWithData:imageData];
            self.aproveImageView.image = image;
        }
        else
        {
            //[self.navigationController popViewControllerAnimated:NO];
        }
    }
}

-(void)deleteProve
{
    EnProcessInfo* process = [[EnProcessInfo alloc] init];
    BOOL isgood = [process deleteAttachmentPathByQuestionId:self.questionid andNeedDeletedAttachmentPath:self.aproveItemId];
    if (isgood) {
        NSString *filePath = [GlobalUtil getAprovePath];
        filePath= [filePath stringByAppendingPathComponent:[self.aproveItemId stringByAppendingString:@".jpg"]];
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            BOOL isDeleted = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            if (isDeleted) {
                //处理页面证据
                NSString* thirdLevel = [self getThirdLevelFromSeqLevel:self.aproveItemId];
                JFKGEvaluateController* evaluateC = [[JFKGEvaluateController alloc]init];
                NSString* strQuesAprove=[evaluateC getQuestionAproveByThirdLevelId:thirdLevel];
                NSString* scriptStr = [NSString stringWithFormat:@"showLevelAprove(%@);",strQuesAprove];
                //NSLog(@"%@",strQuesAprove);
                [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                    NSLog(@"response: %@ error: %@", response, error);
                }];
                [self.navigationController popViewControllerAnimated:NO];
            }
        }
    }
}

-(NSString*)getThirdLevelFromSeqLevel:(NSString*)seqlevel
{
    if (seqlevel!=nil && seqlevel.length>0) {
        NSArray* levelArr = [seqlevel componentsSeparatedByString:@"-"];
        if (levelArr[2]!=nil) {
            return levelArr[2];
        }
    }
    return nil;
}

-(void)backMain:(id)sender{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
