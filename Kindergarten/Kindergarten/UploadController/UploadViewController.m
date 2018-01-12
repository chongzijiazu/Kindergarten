//
//  UploadViewController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/12.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "UploadViewController.h"
#import "AFNetworking.h"

@interface UploadViewController ()

@end

@implementation UploadViewController

@synthesize uploadProgress=_uploadProgress;
@synthesize lbl_uploadState=_lbl_uploadState;

//测试用
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.uploadProgress.progress=0.5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView]; //初始化界面
}

//初始化界面
-(void)initView
{
    self.uploadProgress = [[UIProgressView alloc] init];
    self.uploadProgress.frame = CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2, 200, 40);
    [self.uploadProgress setProgressViewStyle:UIProgressViewStyleDefault];
    self.uploadProgress.progressTintColor=[UIColor blackColor];//设置进度条上进度的颜色
    //self.uploadProgress.trackTintColor = [UIColor yellowColor];//设置进度条颜色
    
    //手动设置圆角
    self.uploadProgress.layer.masksToBounds = YES;
    self.uploadProgress.layer.cornerRadius = 2.5;
    //设置进度条宽高
    CGAffineTransform transform1 = CGAffineTransformMakeScale(1.0f, 5.0f);
    self.uploadProgress.transform = transform1;
    
    //self.uploadProgress.trackImage = [UIImage imageNamed:@""];//设置进度条的背景图片
    //self.uploadProgress.progressImage = [UIImage imageNamed:@""];//设置进度条上进度的背景图片
    [self.uploadProgress setProgress:0.0 animated:YES];//设置进度值并显示动画
    [self.view addSubview:self.uploadProgress];
    
    self.lbl_uploadState = [[UILabel alloc] init];
    self.lbl_uploadState.frame = CGRectMake(self.view.frame.size.width/2-65, self.view.frame.size.height/2+20, 130, 20);
    self.lbl_uploadState.text = @"数据上传中...";
    [self.view addSubview:self.lbl_uploadState];
}

-(void)uploadDataFrom:(NSString*)fromFilePath toUrl:(NSString*)toUrl
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:toUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePath = [NSURL fileURLWithPath:fromFilePath];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    //重新开始上传
    [uploadTask resume];
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
