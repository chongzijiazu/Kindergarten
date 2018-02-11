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
@synthesize fklevel=_fklevel;
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
    self.aproveImageView.frame = CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height-64);
    [self.view addSubview:self.aproveImageView];
    
    [self showAprove];
}

-(void)showAprove
{
    if (self.aproveItemId!=nil && self.aproveItemId.length>0) {
        NSString *filePath = [GlobalUtil getAproveItemPath];
        filePath= [filePath stringByAppendingPathComponent:self.aproveItemId];
        NSArray* extenssionArray = [NSArray arrayWithObjects:@".jpg",@".jpeg",@".png",@".bmp", nil];
        NSFileManager* fileM = [NSFileManager defaultManager];
        for (int i=0; i<extenssionArray.count; i++) {
            NSString* tmpFilepath = [filePath stringByAppendingString:extenssionArray[i]];
            if([fileM fileExistsAtPath:tmpFilepath])
            {
                NSData *imageData = [NSData dataWithContentsOfFile:tmpFilepath];
                UIImage *image = [UIImage imageWithData:imageData];
                self.aproveImageView.image = image;
                break;
            }
            else
            {
                //[self.navigationController popViewControllerAnimated:NO];
            }
        }
        
    }
}

-(void)deleteProve
{
    EnProcessInfo* process = [[EnProcessInfo alloc] init];
    BOOL isgood = [process deleteAttachmentPathByQuestionId:self.questionid andNeedDeletedAttachmentPath:self.aproveItemId];
    if (isgood) {
        NSString *filePath = [GlobalUtil getAproveItemPath];
        filePath= [filePath stringByAppendingPathComponent:self.aproveItemId];
        NSArray* extenssionArray = [NSArray arrayWithObjects:@".jpg",@".jpeg",@".png",@".bmp", nil];
        NSFileManager* fileM = [NSFileManager defaultManager];
        for (int i=0; i<extenssionArray.count; i++) {
            NSString* tmpFilepath = [filePath stringByAppendingString:extenssionArray[i]];
            if([fileM fileExistsAtPath:tmpFilepath])
            {
                BOOL isDeleted = [[NSFileManager defaultManager] removeItemAtPath:tmpFilepath error:nil];
                if (isDeleted) {
                    //处理页面证据
                    JFKGEvaluateController* evaluateC = [[JFKGEvaluateController alloc]init];
                    NSString* strQuesAprove=[evaluateC getQuestionAproveByThirdLevelId:self.fklevel];
                    NSString* scriptStr = [NSString stringWithFormat:@"showLevelAprove(%@);",strQuesAprove];
                    //NSLog(@"%@",strQuesAprove);
                    [self.webView evaluateJavaScript:scriptStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                        NSLog(@"response: %@ error: %@", response, error);
                    }];
                    [self.navigationController popViewControllerAnimated:NO];
                }
                break;
            }
        }
    }
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
