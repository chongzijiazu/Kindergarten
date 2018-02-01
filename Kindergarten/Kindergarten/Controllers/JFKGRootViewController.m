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
#import "JFKGLevelController.h"
#import "JFKGCommonController.h"
#import "JFKFWeakScriptMessageDelegate.h"
#import "JFKGEvaluateController.h"
#import "JFKGAproveController.h"
#import "JFKGAproveViewController.h"
#import "JFKGProcessInfoController.h"
#import "SQLiteManager.h"


@interface JFKGRootViewController ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) JFKGLoginContrller *loginController;
@property (nonatomic, strong) JFKGLevelController *levelController;
@property (nonatomic, strong) JFKGEvaluateController* evaluateController;
@property (nonatomic, strong) JFKGCommonController *commonController;
@property (nonatomic, strong) JFKGAproveController *aproveController;

@end

@implementation JFKGRootViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

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
    
    //评估体系控制类
    self.levelController = [[JFKGLevelController alloc]init];
    self.levelController.webView = self.webView;
    self.levelController.currentVC=self;
    
    //评估答题控制类
    self.evaluateController = [[JFKGEvaluateController alloc]init];
    self.evaluateController.webView = self.webView;
    self.evaluateController.currentVC=self;
    
    //通用工具类
    self.commonController = [[JFKGCommonController alloc]init];
    self.commonController.webView = self.webView;
    self.commonController.currentVC=self;
    
    //获取证据类
    self.aproveController = [[JFKGAproveController alloc]init];
    self.aproveController.webView = self.webView;
    self.aproveController.currentVC=self;
}

//加载初始页面
-(void)loadStartView
{
    if (TICKETID!=nil && TICKETID.length!=0 && ISDOWNLOADSUCCESS!=nil && [ISDOWNLOADSUCCESS isEqualToString:@"1"]) //以登录用户(并且下载资源成功)直接进入，评估指标页面
    {
        [self loadLocalHtmlByFilename:@"asslevel.html"];
    }
    else //为登录用户进入登录页面
    {
        [self loadLocalHtmlByFilename:@"login.html"];
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backMain:)];
}

-(void)backMain:(id)sender{
    [self goback];
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
    //[config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    //使用JFKFWeakScriptMessageDelegate解决执行脚本内存无法释放问题
    [config.userContentController addScriptMessageHandler:[[JFKFWeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"AppModel"];
    
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

-(void)goback {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

-(void)gofarward {
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
        NSLog(@"didReceiveScriptMessage：%@", (NSString*)message.body);
        NSString* htmlname= [[self.webView.URL path] lastPathComponent];
        if ([htmlname isEqualToString:@"login.html"])
        {
            //NSDictionary* dicParams = message.body;
            NSDictionary* dicMsg = message.body;
            NSString* operation = [dicMsg objectForKey:@"operation"];
            if ([operation isEqualToString:@"login"])
            {
                NSDictionary* dicParams = [dicMsg objectForKey:@"param"];
                //NSLog(@"%@",[dicParams objectForKey:@"username"]);
                [self.loginController loginByUsername:[dicParams objectForKey:@"username"] andPassword:[dicParams objectForKey:@"password"]];
            }
            else if([operation isEqualToString:@"logonline"])
            {
                //NSLog(@"HELLO");
                NSURL* url = [NSURL URLWithString:OnlineUrlString];
                NSURLRequest* request = [NSURLRequest requestWithURL:url];
                [self.webView loadRequest:request];
                //self.navigationController.navigationBar.hidden = NO;
            }
            
            
        }
        else if ([htmlname isEqualToString:@"asslevel.html"])
        {
            NSDictionary* dicMsg = message.body;
            NSString* operation = [dicMsg objectForKey:@"operation"];
            if ([operation isEqualToString:@"logout"])
            {
                [self.commonController logout];
            }
            else if([operation isEqualToString:@"showQuestion"])
            {
                //NSLog(@"%@",[dicMsg objectForKey:@"param"]);
                NSDictionary* dicParam =[dicMsg objectForKey:@"param"];
                self.evaluateController.currentLevelQuestionID =[dicParam objectForKey:@"thirdlevelid"];//三级指标id传给页面
                //self.evaluateController.currentLevelQuestionName=[dicParam objectForKey:@"thirdlevelname"];
                self.evaluateController.currentLevelQuestionName = [self.levelController getThirdLevelNameByCurrentThirdLevelId:[dicParam objectForKey:@"thirdlevelid"]];
                [self loadLocalHtmlByFilename:@"evaluate.html"];
            }
            else if([operation isEqualToString:@"uploadData"])
            {
                //NSLog(@"%@",[dicMsg objectForKey:@"param"]);
                [self.levelController uploadData];
            }
            else if([operation isEqualToString:@"calculateFormula"])
            {
                NSDictionary* dicParam = [dicMsg objectForKey:@"param"];
                //NSLog(@"%@",dicParam);
                if([self.levelController saveFormulaValue:dicParam])
                {
                    //将公式计算标志改为，已计算（避免重复计算）
                    [userDefault setObject:@"1" forKey:@"isFormulaCalculated"];
                }
            }
            else if([operation isEqualToString:@"openHelpFile"])
            {
                NSString* hepfilePath = [GlobalUtil getHelpFilePath];
                [self.commonController showHelpFile:hepfilePath];
            }
        }
        else if ([htmlname isEqualToString:@"evaluate.html"])
        {
            NSDictionary* dicMsg = message.body;
            NSString* operation = [dicMsg objectForKey:@"operation"];
            if ([operation isEqualToString:@"logout"])
            {
                [self.commonController logout];
            }
            else if([operation isEqualToString:@"goback"])
            {
                //[self goback];
                [self loadLocalHtmlByFilename:@"asslevel.html"];
            }
            else if([operation isEqualToString:@"pageDown"])
            {
                BOOL isfinished = [self.levelController getFinishStateByThirdLevelID:self.evaluateController.currentLevelQuestionID];//判断当前页是否答题完成
                if (isfinished) {
                    [self pagedown];//下一页
                }
                else
                {
                    [self showAlertViewForPageDown:@"当前三级指标下还有评估试题尚未答完，确认离开本页？"];
                }
            }
            else if([operation isEqualToString:@"pageUp"])
            {
                BOOL isfinished = [self.levelController getFinishStateByThirdLevelID:self.evaluateController.currentLevelQuestionID];//判断当前页是否答题完成
                if (isfinished) {
                    [self pageup];//上一页
                }
                else
                {
                    [self showAlertViewForPageUp:@"当前三级指标下还有评估试题尚未答完，确认离开本页？"];
                }
                
            }
            else if([operation isEqualToString:@"clickaprove"])
            {
                NSDictionary* dicParams = [dicMsg objectForKey:@"param"];
                //NSLog(@"%@",[dicParams objectForKey:@"type"]);
                NSString* aproveitemtype =[dicParams objectForKey:@"type"];
                NSString* questionid =[dicParams objectForKey:@"questionid"];
                NSString* fklevel =[dicParams objectForKey:@"fklevel"];
                NSString* aproveitemid =[dicParams objectForKey:@"id"];
                if ([aproveitemtype isEqualToString:@"0"]) //添加证据
                {
                    if ([self.aproveController isMayAppend:questionid]) {
                        [self.aproveController getAproveByAproveItemId:aproveitemid andQuestionId:questionid andFKLevel:fklevel];//获取证据
                    }
                }
                else if([aproveitemtype isEqualToString:@"1"])//已有证据
                {
                    JFKGAproveViewController* aproveVC = [[JFKGAproveViewController alloc] init];
                    aproveVC.aproveItemId =aproveitemid;
                    aproveVC.questionid = questionid;
                    aproveVC.fklevel = fklevel;
                    aproveVC.webView = self.webView;
                    [self.navigationController pushViewController:aproveVC animated:NO                ];
                }
            }
            else if([operation isEqualToString:@"saveAnswer"])
            {
                NSDictionary* dicParams = [dicMsg objectForKey:@"param"];
                if (dicParams!=nil&&dicParams.count>0) {
                    [JFKGProcessInfoController saveQuestionAnswerToDB:dicParams];
                }
            }
            else if([operation isEqualToString:@"saveMemo"])
            {
                NSDictionary* dicParams = [dicMsg objectForKey:@"param"];
                if (dicParams!=nil&&dicParams.count>0) {
                    [JFKGProcessInfoController saveMemoToDocument:dicParams];
                }
            }
            else if([operation isEqualToString:@"openHelpFile"])
            {
                NSString* hepfilePath = [GlobalUtil getHelpFilePath];
                [self.commonController showHelpFile:hepfilePath];
            }
        }
    }
    
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    NSString* hosturl = [navigationAction.request.URL path];
    if (navigationAction.navigationType == WKNavigationTypeOther
        && [hosturl containsString:@"download.do"]) {
        // 对于跨域，需要手动跳转
        //[[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        
        // 取消下载请求
        decisionHandler(WKNavigationActionPolicyCancel);
        NSString* funMessage = @"alert('请到电脑端导出查看文件');";
        [self.webView evaluateJavaScript:funMessage completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
        }];
        
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
   /* NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    //NSLog(@"%@",response.URL);
    NSString* responseUrl = [response.URL path];
    if ([responseUrl containsString:@"main.do"]) {
        NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
        NSLog(@"%@",cookies);
        for (NSHTTPCookie *cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            NSLog(@"%@",cookie);
        }
    }*/
    
    
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
    NSString* htmlname= [[self.webView.URL path] lastPathComponent];
    if ([htmlname isEqualToString:@"asslevel.html"])
    {
        [self.levelController sendLevelTableToView];//向页面发送评估指标数据
        NSString* funMessage = @"scrollToLevel('%@');";
        funMessage = [NSString stringWithFormat:funMessage,self.evaluateController.currentLevelQuestionID];
        [self.webView evaluateJavaScript:funMessage completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
        }];
    }
    else if([htmlname isEqualToString:@"evaluate.html"])
    {
        [self.evaluateController sendLevelQuestionToView];
    }
    else if ([htmlname isEqualToString:@"login.html"])
    {
        [self.loginController sendAccountToView];//向页面发送记录的帐号信息
        //self.navigationController.navigationBar.hidden = YES;
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}



- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    NSLog(@"createWebViewWithConfiguration");
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
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

//下一页
-(void)pagedown
{
    NSString* nextThirdLevelId = [self.levelController getNextThirdLevelIdByCurrentThirdLevelId:self.evaluateController.currentLevelQuestionID];
    
    
    if (nextThirdLevelId!=nil && nextThirdLevelId.length==9)
    {
        //根据三级指标编码的前三位（一级指标编码）判断，是否进入下一个指标
        NSString* currentFirstLevel = [self.evaluateController.currentLevelQuestionID substringToIndex:3];
        NSString* nextFirstLevel = [nextThirdLevelId substringToIndex:3];
        if (![currentFirstLevel isEqualToString:nextFirstLevel]) {
            NSString* funMessage = @"alert('您即将离开当前一级指标，进入下一个一级指标评估答题页面');";
            [self.webView evaluateJavaScript:funMessage completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                NSLog(@"response: %@ error: %@", response, error);
            }];
        }
        
        
        NSString* nextThirdLevelName = [self.levelController getThirdLevelNameByCurrentThirdLevelId:nextThirdLevelId];
        self.evaluateController.currentLevelQuestionID =nextThirdLevelId;
        self.evaluateController.currentLevelQuestionName = nextThirdLevelName;
        [self.evaluateController sendLevelQuestionToView];
        [self scrollToFirstNotFinishedQuestion];
    }
    else
    {
        NSString* funMessage = @"alert('当前三级指标已是末页');";
        [self.webView evaluateJavaScript:funMessage completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
        }];
    }
}

//上一页
-(void)pageup
{
    NSString* preThirdLevelId = [self.levelController getPreThirdLevelIdByCurrentThirdLevelId:self.evaluateController.currentLevelQuestionID];
    
    if (preThirdLevelId!=nil && preThirdLevelId.length==9)
    {
        NSString* preThirdLevelName = [self.levelController getThirdLevelNameByCurrentThirdLevelId:preThirdLevelId];
        self.evaluateController.currentLevelQuestionID =preThirdLevelId;
        self.evaluateController.currentLevelQuestionName = preThirdLevelName;
        [self.evaluateController sendLevelQuestionToView];
        [self scrollToFirstNotFinishedQuestion];
    }
    else
    {
        NSString* funMessage = @"alert('当前三级指标已经是首页');";
        [self.webView evaluateJavaScript:funMessage completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
        }];
    }
}

//滚动到第一个未答试题(当前三级节点)
-(void)scrollToFirstNotFinishedQuestion
{
    NSString* questionid = [self.commonController getFirsitNotFinishedQues:self.evaluateController.currentLevelQuestionID];
    NSString* funMessage = @"scrollToQuestion('%@');";
    funMessage = [NSString stringWithFormat:funMessage,questionid];
    [self.webView evaluateJavaScript:funMessage completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"response: %@ error: %@", response, error);
    }];
}

- (void)showAlertViewForPageDown:(NSString *)message
{
    NSString *title = @"提示信息";
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //点击确定进入下一页
        [self pagedown];
        
    }];
    [alertController addAction:OKAction];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"继续答题" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self scrollToFirstNotFinishedQuestion];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showAlertViewForPageUp:(NSString *)message
{
    NSString *title = @"提示信息";
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //点击确定进入下一页
        [self pageup];
        
    }];
    [alertController addAction:OKAction];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"继续答题" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self scrollToFirstNotFinishedQuestion];
        
    }]];
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end

