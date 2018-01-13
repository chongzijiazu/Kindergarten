//
//  JFKGRootViewController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/13.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "JFKGRootViewController.h"
#import <WebKit/WebKit.h>
#import "JFKGLoginContrller.h"

@interface JFKGRootViewController ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) JFKGLoginContrller *loginController;

@end

@implementation JFKGRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;//隐藏导航栏
    [self initWKWebView];//初始化WKWebView
    [self loadStartView];//加载启动页面
    [self initControllers];//初始化控制类
}

//初始化控制类
-(void)initControllers
{
    //登录控制类
    self.loginController = [[JFKGLoginContrller alloc]init];
    self.loginController.webView = self.webView;
    self.loginController.currentVC=self;
}

//加载初始页面
-(void)loadStartView
{
    if (TICKETID!=nil && TICKETID.length!=0) //以登录用户直接进入，评估指标页面
    {
        [self loadLocalHtmlByFilename:@"asslevel.html"];
    }
    else //为登录用户进入登录页面
    {
        [self loadLocalHtmlByFilename:@"login.html"];
    }
}

//加载本地html页面，根据html文件名称
-(void)loadLocalHtmlByFilename:(NSString*)htmlFilename
{
    NSString* basePath = [[NSBundle mainBundle] bundlePath];
    basePath = [basePath stringByAppendingString:@"/app"];
    NSString* htmlPath =[NSString stringWithFormat:@"%@/%@",basePath,htmlFilename];
    NSURL *htmlUrl = [NSURL fileURLWithPath:htmlPath];
    NSURL *accessReadUrl = [NSURL fileURLWithPath:basePath];
    
    [self.webView loadFileURL:htmlUrl allowingReadAccessToURL:accessReadUrl];
}

//初始化wkWebView
-(void)initWKWebView
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    
    // 添加一个JS到HTML中，这样就可以直接在JS中调用我们添加的JS方法
    /*WKUserScript *script = [[WKUserScript alloc]initWithSource:@"function showAlert() { alert('在载入webview时通过Swift注入的JS方法');"
                                                 injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                              forMainFrameOnly:YES];
    [config.userContentController addUserScript:script];*/
    
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [self.view addSubview:self.webView];
    
    // 导航代理
    self.webView.navigationDelegate = self;
    // 与webview UI交互代理
    self.webView.UIDelegate = self;
}

- (void)goback {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (void)gofarward {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

#pragma mark - WKScriptMessageHandler【jsCallOC 交互的关键】
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"AppModel"])
    {
        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
        // NSDictionary, and NSNull类型
        NSLog(@"🍎didReceiveScriptMessage：%@", (NSString*)message.body);
        NSString* htmlname= [[self.webView.URL path] lastPathComponent];
        if ([htmlname isEqualToString:@"login.html"])
        {
            
            [self.loginController loginByUsername:@"yuanz" andPassword:@"111"];
        }
        else if ([htmlname isEqualToString:@"asslevel.html"])
        {
            NSLog(@"%@",[message.body class]);
            //NSString* msg = message.body;
            if ([@"logout" isEqualToString:@"logout"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"登出后将清空评估数据，请确保评估数据已上传" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"点击取消");
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    //清空ticketid
                    [userDefault setObject:@"" forKey:@"ticketid"];
                    
                    //清理本地数据（文件及数据库）
                    
                    //回到登录页面
                    [self loadLocalHtmlByFilename:@"login.html"];
                    
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
    }
    
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
        && ![hostname containsString:@".baidu.com"]) {
        // 对于跨域，需要手动跳转
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        
        // 不允许web内跳转
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - WKUIDelegate
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}

/** alert 面板 **/
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"%@", message);
}

/** confirm 面板 **/
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"confirm" message:@"JS调用confirm" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"%@", message);
}

/** input 面板 带prompt**/
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    
    NSLog(@"%@", prompt);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
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
