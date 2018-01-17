//
//  DownloadManagerViewController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "DownloadManagerViewController.h"
#import "AFNetworking.h"
#import "JFKGLoginContrller.h"
#import "JFKGLevelController.h"
#import "JFKGEvaluateController.h"
#import "JFKGProcessInfoController.h"
#import "SQLiteManager.h"

@interface DownloadManagerViewController ()

@end

@implementation DownloadManagerViewController

@synthesize downloadProgress=_downloadProgress;
@synthesize lbl_downloadState=_lbl_downloadState;
@synthesize currentDownloadCount=_currentDownloadCount;
@synthesize downloadArray=_downloadArray;

//测试用
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [GlobalUtil deleteAllDocumentsFile];//下载前清空数据（进入下载就代表重开始）
    if([self processDownloadData])//处理下载完的数据
    {
        //下载及加载数据完成，向页面发送成功消息
        if (self.delegate!=nil) {
            [self.delegate sendIsSuccess:YES];
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else
    {
        [self showAlertView:@"加载数据失败,是否从新下载评估数据"];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    //[GlobalUtil deleteAllDocumentsFile];//下载前清空数据（进入下载就代表重开始）
    //[self downloadEvalutionData]; //下载评估资源
    self.downloadProgress.progress=0.5;//测试用
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    self.currentDownloadCount = 1;//重置当前下载个数
    self.downloadArray = [[NSMutableArray alloc] initWithObjects:@"level.zip",@"paper.zip",@"formula.zip",@"processed.zip", nil];
    
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
    
    //self.downloadProgress.trackImage = [UIImage imageNamed:@""];//设置进度条的背景图片
    //self.downloadProgress.progressImage = [UIImage imageNamed:@""];//设置进度条上进度的背景图片
    [self.downloadProgress setProgress:0.0 animated:YES];//设置进度值并显示动画
    [self.view addSubview:self.downloadProgress];
    
    self.lbl_downloadState = [[UILabel alloc] init];
    self.lbl_downloadState.frame = CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2+20, 200, 20);
    self.lbl_downloadState.text = @"正在下载评估资源（1/4)";
    [self.view addSubview:self.lbl_downloadState];
}

//下载评估数据
-(void)downloadEvalutionData
{
    if (self.downloadArray!=nil && self.downloadArray.count>0)
    {
        NSString* tempStr = [self.downloadArray objectAtIndex:0];
        if ([tempStr isEqualToString:@"level.zip"])
        {
            //下载评估指标体系
            [self downloadDataFrom:[HTTPInterface downloadlevelcontent] toFilename:@"level.zip"];
        }
        else if ([tempStr isEqualToString:@"paper.zip"])
        {
            //下载评估试卷
            [self downloadDataFrom:[HTTPInterface downloadpapercontent] toFilename:@"paper.zip"];
        }
        else if([tempStr isEqualToString:@"formula.zip"])
        {
            //下载公式数据
            [self downloadDataFrom:[HTTPInterface downloadformulacontent] toFilename:@"formula.zip"];
        }
        else if([tempStr isEqualToString:@"processed.zip"])
        {
            //下载证据数据
            [self downloadDataFrom:[HTTPInterface downloadpapercontent] toFilename:@"processed.zip"];
        }
    }
    else
    {
        if(self.currentDownloadCount == 4)//下载完成
        {
            if([self processDownloadData])//处理下载完的数据
            {
                //下载及加载数据完成，向页面发送成功消息
                if (self.delegate!=nil) {
                    [self.delegate sendIsSuccess:YES];
                }
                [self dismissViewControllerAnimated:NO completion:nil];
            }
            else
            {
                [self showAlertView:@"加载数据失败,是否从新下载评估数据"];
            }
        }
        else
        {
            //正常情况下，不会出现此逻辑，在下载出错后会做处理
        }
    }
}

//处理下载好的数据
-(BOOL)processDownloadData
{
    self.lbl_downloadState.text = @"数据加载中...";
    //在处理数据的时候创建（打开）数据库(已在程序启动时做过此操作，但由于退出到登录界面时会删除数据库，所以在下载时重复做此操作，以保证数据库正常打开)
    if ([[SQLiteManager shareInstance] openDB]) {
        NSLog(@"打开/创建数据库成功!");
    }else{
        NSLog(@"数据库开启失败!");
    }
    //处理以评估数据，解压保存答案信息，解压保存证据信息
    
    //处理试卷数据，包括试卷包的解压和生成按三级指标分类的html
    JFKGEvaluateController* evaluateC = [[JFKGEvaluateController alloc] init];
    //生成按三级指标分类的html文件（调试，尚无解压过程）
    if(![evaluateC makeLevelHTMLByPaper])
    {
        return false;
    }
    
    //处理评估指标体系，解压评估指标压缩包，生成评估指标所需的html格式文件
    JFKGLevelController* levelC = [[JFKGLevelController alloc] init];
    //生成html格式文件（调试，没添加解压过程）
    if (![levelC makeAssLevelFile]) {
        return false;
    }
    
    //通过网络接口，获取评估过程信息（试题答案）
    JFKGProcessInfoController* processC = [[JFKGProcessInfoController alloc]init];
    if (![processC getProcessInfo]) {
        return false;
    }
    
    return true;
}

-(void)deleteExistDownloadFile
{
    self.currentDownloadCount = 1;//重置当前下载个数
    //Document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString* downloadPath = [documentPath stringByAppendingPathComponent:@"DownloadFiles"];
    if([[NSFileManager defaultManager] fileExistsAtPath:downloadPath])
     {
         [[NSFileManager defaultManager] removeItemAtPath:downloadPath error:nil];//删除原来
         
     }
    
    //重新创建目录
    [[NSFileManager defaultManager] createDirectoryAtPath:downloadPath withIntermediateDirectories:YES attributes:nil error:nil];
}


-(void)downloadDataFrom:(NSString*)fromUrl toFilename:(NSString*)toFilename
{
    NSString* downloadFilesDirect = [@"DownloadFiles" stringByAppendingPathComponent:toFilename];//将文件下载到沙盒Document/DownloadFiles下面
    //下载
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30; //设置请求超时时间
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
        return [documentsDirectoryURL URLByAppendingPathComponent:downloadFilesDirect];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error)
        {
            NSLog(@"Error:%@",error);
            [self showAlertView:@"下载失败,是否从新下载评估数据"];
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.lbl_downloadState.text =  [NSString  stringWithFormat:@"%@%d%@",@"正在下载评估资源(", ++self.currentDownloadCount,@"/4)"];
            });
            [self.downloadArray removeObject:toFilename]; //移除下载完成的文件
            [self downloadEvalutionData]; //下载下一个文件
            NSLog(@"File downloaded to: %@", filePath);
        }
    }];
    //重新开始下载
    [downloadTask resume];
}

- (void)showAlertView:(NSString *)message
{
    NSString *title = @"提示";
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //清空数据
        [GlobalUtil deleteAllDocumentsFile];
        //从新下载数据
        [self downloadEvalutionData];
        
                                       }];
    [alertController addAction:OKAction];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //下载失败，取消下载后，将清空个人登录信息数据(ticketid,院所信息等（待完善）)
        [userDefault setObject:@"" forKey:@"ticketid"];
        //清空数据
        [GlobalUtil deleteAllDocumentsFile];
        [self dismissViewControllerAnimated:NO completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
