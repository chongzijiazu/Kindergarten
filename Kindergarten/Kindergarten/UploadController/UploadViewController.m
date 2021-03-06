//
//  UploadViewController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/12.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "UploadViewController.h"
#import "AFNetworking.h"
#import "EnProcessInfo.h"
#import "JFKGRootViewController.h"

@interface UploadViewController ()

@end

@implementation UploadViewController

@synthesize uploadProgress=_uploadProgress;
@synthesize lbl_uploadState=_lbl_uploadState;

//测试用
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self zipUploadFile];
    //[self dismissViewControllerAnimated:NO completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    //self.uploadProgress.progress=0.5;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self uploadEvaluateData];//开始上传数据
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
    self.lbl_uploadState.frame = CGRectMake(self.view.frame.size.width/2-55, self.view.frame.size.height/2+20, 130, 20);
    self.lbl_uploadState.text = @"数据上传中...";
    [self.view addSubview:self.lbl_uploadState];
}

-(void)uploadEvaluateData
{
    //先清空上传的压缩数据
    NSString* uploadPath = [GlobalUtil getUploadPath];
    [[NSFileManager defaultManager] removeItemAtPath:uploadPath error:nil];
    
    BOOL isgood = [self zipUploadFile];
    if (isgood) {
        NSString* uploadPath = [GlobalUtil getUploadPath];
        NSString* uploadFilepath = [uploadPath stringByAppendingPathComponent:@"content.zip"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:uploadFilepath]) {
            //[self uploadDataFrom:uploadFilepath toUrl:[HTTPInterface uploadevaluatedata]];
            [self uploadFile:uploadFilepath toUrl:[HTTPInterface uploadevaluatedata]];
        }
    }
    
}

-(BOOL)zipUploadFile
{
    //生成答案文件
    NSString* uploadZipPath = [GlobalUtil getUploadZipPath];
    NSString* strAnswer = [EnProcessInfo toJsonProcessInfo];
    if (strAnswer!=nil && strAnswer.length>0) {
        //NSLog(@"%@",strAnswer);
        //将答案文件写到上传所在路径
        NSString* answerFilepath = [uploadZipPath stringByAppendingPathComponent:@"answer.txt"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:answerFilepath]){
            [[NSFileManager defaultManager] removeItemAtPath:answerFilepath error:nil];//存在则先删除
        }
        BOOL isgood = [strAnswer writeToFile:answerFilepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        if (isgood) {
            NSString* proveitempath = [GlobalUtil getAproveItemPath];
            BOOL isok = [ZipUtil ZipArchiveWithFolder:proveitempath toPath:uploadZipPath];
            if (isok) {
                return [ZipUtil ZipArchiveWithFolder:uploadZipPath toPath:[GlobalUtil getUploadPath]];
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }
    else //无评估答案不能上传数据，提示其请先作答试题在提交数据
    {
        [self showNoAnswerAlertView:@"请先作答试题再上传数据!"];
        //return false;
    }
    return true;
}

//上传文件
- (void)uploadFile:(NSString*)fromFilePath toUrl:(NSString*)toUrl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/plain", nil];
    
    NSDictionary *dict = @{@"ticketid":TICKETID};
    [manager POST:toUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:fromFilePath] name:@"file" error:nil];
        
    }progress:^(NSProgress * _Nonnull uploadProgress) {
             //NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.uploadProgress.progress =1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        });
         }
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         NSDictionary* dicResponse = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:nil];
         //NSLog(@"上传成功.%@",dicResponse);
         if ([dicResponse[@"success"] isEqualToString:@"1"]) {
             //上传成功则清理数据，退出到登录页面
             [self showSucessAlertView:@"数据上传成功!"];
         }
         else
         {
             NSString* errmsg =dicResponse[@"message"];
             if (errmsg!=nil && errmsg.length>0) {
                 //errmsg = [NSString stringWithFormat:@"数据上传失败，请重试(%@)",errmsg];
                 [self showErrorAlertView:errmsg];
             }
             else
             {
                 [self showErrorAlertView:@"数据上传失败，请重试!"];
             }
         }
        }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"上传失败.%@",error);
        //NSString* strErr = [NSString stringWithFormat:@"%@",error];
        [self showErrorAlertView:@"数据上传失败，请重试!"];
          }];
}

-(void)uploadSuccess
{
    //清空ticketid
    [userDefault setObject:@"" forKey:@"ticketid"];
    //清空下载状态
    [userDefault setObject:@"" forKey:@"isDownloadSuccess"];
    //清空公式计算标志位
    [userDefault setObject:@"" forKey:@"isFormulaCalculated"];
    
    //清理本地数据（文件及数据库）
    [GlobalUtil deleteAllDocumentsFile];//
    
    
    //回到登录页面
    JFKGRootViewController* rooVC = (JFKGRootViewController*)self.currentVC;
    [rooVC toOnlineLogin];
    [self dismissViewControllerAnimated:NO completion:nil];
}

//上传失败弹出页面
- (void)showErrorAlertView:(NSString *)message
{
    NSString *title = @"提示";
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //从新上传数据
        [self uploadEvaluateData];
        
    }];
    [alertController addAction:OKAction];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//上传成功弹出页面
- (void)showSucessAlertView:(NSString *)message
{
    NSString *title = @"提示";
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self uploadSuccess];
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//无答案（无作答试题）弹出页面
- (void)showNoAnswerAlertView:(NSString *)message
{
    NSString *title = @"提示";
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    [alertController addAction:OKAction];
    
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
