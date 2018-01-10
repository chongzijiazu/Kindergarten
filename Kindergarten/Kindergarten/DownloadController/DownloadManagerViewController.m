//
//  DownloadManagerViewController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "DownloadManagerViewController.h"
#import "AFNetworking.h"

@interface DownloadManagerViewController ()

@end

@implementation DownloadManagerViewController

@synthesize downloadProgress=_downloadProgress;

-(void)viewDidLayoutSubviews
{
    //[self downloadLevelcontent:[HTTPInterface downloadlevelcontent]];
    [self downloadDataFrom:[HTTPInterface downloadlevelcontent] toFilename:@"level.zip"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.downloadProgress = [[UIProgressView alloc] init];
    self.downloadProgress.frame = CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2, 200, 40);
    [self.downloadProgress setProgressViewStyle:UIProgressViewStyleDefault];
    self.downloadProgress.progress=0.0;
    //self.downloadProgress.trackTintColor = [UIColor yellowColor];//设置进度条颜色
    self.downloadProgress.progressTintColor=[UIColor blackColor];//设置进度条上进度的颜色
    //手动设置圆角
    self.downloadProgress.layer.masksToBounds = YES;
    self.downloadProgress.layer.cornerRadius = 2.5;
    
    //设置进度条宽高
    CGAffineTransform transform1 = CGAffineTransformMakeScale(1.0f, 5.0f);
    self.downloadProgress.transform = transform1;
    
    self.downloadProgress.trackImage = [UIImage imageNamed:@""];//设置进度条的背景图片
    self.downloadProgress.progressImage = [UIImage imageNamed:@""];//设置进度条上进度的背景图片
    [self.downloadProgress setProgress:0.0 animated:YES];//设置进度值并显示动画
    
    [self.view addSubview:self.downloadProgress];
}

//下载评估指标数据
-(void)downloadLevelcontent:(NSString*)downloadUrl
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:downloadUrl]];
    
    NSURLSessionDownloadTask* download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        //NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.downloadProgress.progress =1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        });
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //保存的文件路径
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"level.zip"];
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"%@",filePath);
        
        if (error==nil) {
            self.downloadProgress.progress = 1;
        }
        else
        {
            NSLog(@"下载失败：%@",error);
        }
       
    }];
    //执行Task
    [download resume];
}

-(void)downloadDataFrom:(NSString*)fromUrl toFilename:(NSString*)toFilename
{
    //下载
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:fromUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        //NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.downloadProgress.progress =1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        });
        
    }  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:toFilename];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            NSLog(@"Error:%@",error);
        }
        else
        {
            NSLog(@"File downloaded to: %@", filePath);
        }
    }];
    //重新开始下载
    [downloadTask resume];
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
