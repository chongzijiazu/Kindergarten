//
//  LoginViewController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "LoginViewController.h"
#import "Encryption.h"
#import "DownloadManagerViewController.h"
#import "AppDelegate.h"
#import "LevelViewController.h"
#import "LoginWebViewModel.h"

@interface LoginViewController ()

@property (nonatomic, strong) LoginWebViewModel* model;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    // Do any additional setup after loading the view.
    /*self.view.backgroundColor = [UIColor lightGrayColor];
    _textField_Username = [[UITextField alloc] init];
    _textField_Username.frame = CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100, 300, 40);
    _textField_Username.placeholder = @"用户名";
    _textField_Username.borderStyle = UITextBorderStyleRoundedRect;
    _textField_Username.text = @"";
    _textField_Username.textColor = [UIColor blackColor];
    _textField_Username.font = [UIFont systemFontOfSize:20];
    _textField_Username.backgroundColor = [UIColor whiteColor];
    _textField_Username.clearsOnBeginEditing = NO; //当重复开始编辑时候 清除文字
    _textField_Username.secureTextEntry = NO;//文字密文（暗文） 该属性通常用于设置密码输入框
    _textField_Username.textAlignment = NSTextAlignmentLeft;//文字输入时的对齐方式
    [_textField_Username setAutocorrectionType:UITextAutocorrectionTypeNo];//关闭自动纠错功能
    [_textField_Username setAutocapitalizationType:UITextAutocapitalizationTypeNone];//关闭首字母大写功能
    [self.view addSubview:_textField_Username];
    
    _textField_Password = [[UITextField alloc] init];
    _textField_Password.frame = CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100+60, 300, 40);
    _textField_Password.placeholder = @"密码";
    _textField_Password.borderStyle = UITextBorderStyleRoundedRect;
    _textField_Password.text = @"";
    _textField_Password.textColor = [UIColor blackColor];
    _textField_Password.font = [UIFont systemFontOfSize:20];
    _textField_Password.backgroundColor = [UIColor whiteColor];
    _textField_Password.clearsOnBeginEditing = NO; //当重复开始编辑时候 清除文字
    _textField_Password.secureTextEntry = NO;//文字密文（暗文） 该属性通常用于设置密码输入框
    _textField_Password.textAlignment = NSTextAlignmentLeft;//文字输入时的对齐方式
    [self.view addSubview:_textField_Password];
    
    UIButton* btn_login = [[UIButton alloc] init];
    btn_login.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-100+60+60, 100, 40);
    [btn_login setTitle:@"登录" forState:UIControlStateNormal];
    [btn_login addTarget:self action:@selector(btn_login_clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_login];*/
    
    [self initView];
}

-(void)initView
{
    //加载页面
    NSString* basePath = [[NSBundle mainBundle] bundlePath];
    basePath = [basePath stringByAppendingString:@"/app"];
    NSURL* baseURL = [NSURL fileURLWithPath:basePath];
    NSLog(@"%@",basePath);
    

    NSString* htmlPath =[NSString stringWithFormat:@"%@/login.html",basePath];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
    [self.view addSubview:self.webView];
}

-(void)loginByUsername:(NSString*)username andPassword:(NSString*)password
{
    //添加用户名、密码验证（待完善）
    
    /*NSLog(@"login");
    NSData* usernameData = [username dataUsingEncoding:NSUTF8StringEncoding];
    username = [usernameData base64EncodedStringWithOptions:1];
    password = [Encryption md5:password];
    NSDictionary *dict = @{@"account": username, @"password": password};
    
    __weak typeof (self) weakSelf = self;
    
    [HttpRequestModel httpRequest:[HTTPInterface login] withParamters:dict isPost:NO success:^(id  _Nullable responseObject)
     {
         if ([responseObject isKindOfClass:[NSDictionary class]])
         {
             NSDictionary  *responseData = (NSDictionary *)responseObject;
             
             NSLog(@"%@",responseData);
             /*weakSelf.listDeatilArray = [NSMutableArray array];
             [weakSelf.listDeatilArray removeAllObjects];
             [weakSelf.firstArray removeAllObjects];
             [weakSelf.secondArray removeAllObjects];
             if ([responseData[@"success"] boolValue] && [responseData[@"entity"] isKindOfClass:[NSDictionary class]])
             {
                 NSDictionary *tempDict = responseData[@"entity"];
                 
                 
                 if ([tempDict[@"courseKpoints"] isKindOfClass:[NSArray class]])
                     weakSelf.listDeatilArray = tempDict[@"courseKpoints"];
                 if (weakSelf.listDeatilArray.count != 0)
                 {
                     
                     NSMutableArray *oneArray = [NSMutableArray array];
                     [oneArray removeAllObjects];
                     
                     NSMutableArray *twoArray = [NSMutableArray array];
                     [twoArray removeAllObjects];
                     
                     for (int i = 0; i < weakSelf.listDeatilArray.count; i++)
                     {
                         NSDictionary *oneDict = weakSelf.listDeatilArray[i];
                         //二级目录名
                         NSString *name = oneDict[@"name"];
                         [oneArray addObject:name];
                         NSMutableDictionary *isOpenDict = [NSMutableDictionary dictionary];
                         if ([oneDict[@"childKpoints"] isKindOfClass:[NSArray class]])
                         {
                             NSArray *childKpoints = oneDict[@"childKpoints"];
                             
                             [isOpenDict setObject:childKpoints forKey:@"array1"];
                             if (i == 0)
                             {
                                 [isOpenDict setObject:@(YES) forKey:@"isOpen" ];
                             }
                             else
                             {
                                 [isOpenDict setObject:@(NO) forKey:@"isOpen" ];
                             }
                             [twoArray addObject:isOpenDict];
                         }
                     }
                     weakSelf.firstArray = [oneArray mutableCopy];
                     
                     weakSelf.secondArray = [twoArray mutableCopy];
                     
                 }
             }
             
             [weakSelf.listTableView reloadData];*/
             
             
             
         /*}
         
     } failure:^(NSError * _Nonnull error) {
         
         //[self showAlertView:@"登录失败"];
     }];*/
    
    //模拟登录（应放倒登录成功操作）
    [userDefault setObject:@"111111" forKey:@"ticketid"];
    
    DownloadManagerViewController* downloadManagerVC = [[DownloadManagerViewController alloc] init];
    [self.navigationController pushViewController:downloadManagerVC animated:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scrollView.bounces = NO;
        self.webView.scrollView.showsHorizontalScrollIndicator = NO;
        //self.webView.scrollView.scrollEnabled = NO;
        [self.webView sizeToFit];
        //忽略web页面与_WebView组件的大小关系如果设置为YES可以执行缩放，但是web页面加载出来的时候，就会缩小到UIWebView组件的大小
        //_webView.scalesPageToFit = YES;
        _webView.delegate = self;
    }
    
    return _webView;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    LoginWebViewModel *model  = [[LoginWebViewModel alloc] init];
    self.jsContext[@"CallEachModel"] = model;
    model.jsContext = self.jsContext;
    model.webView = self.webView;
    model.currentVC = self;
    self.model = model;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)showAlertView:(NSString *)message
{
    NSString *title = @"提示";
    UIAlertController *alertController;
    
    //取消
    if (![message isEqualToString:@"登录成功"])
    {
        alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                       {}];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        [MBProgressHUD showSuccess:@"登录成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
