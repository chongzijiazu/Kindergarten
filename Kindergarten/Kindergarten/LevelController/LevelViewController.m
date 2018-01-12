//
//  LevelViewController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "LevelViewController.h"
#import "WebViewModel.h"
#import "LevelTableCreator.h"

@interface LevelViewController ()
{
    NSString* _levelTable;//评估指标数据表（页面需要格式）
}

@property (nonatomic, strong) WebViewModel* model;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation LevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    
    BOOL isgood = [self readViewNeededData];//读取页面所需数据
    if (isgood) {
        //加载页面
        NSString* basePath = [[NSBundle mainBundle] bundlePath];
        basePath = [basePath stringByAppendingString:@"/app"];
        NSURL* baseURL = [NSURL fileURLWithPath:basePath];
        NSLog(@"%@",basePath);
        
        //index.html path
        //NSString* htmlPath =[NSString stringWithFormat:@"%@/CallEach.html",basePath];
        NSString* htmlPath =[NSString stringWithFormat:@"%@/asslevel.html",basePath];
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:htmlString baseURL:baseURL];
        [self.view addSubview:self.webView];
        
        //页面加载完成后，向页面发送所需的数据（在页面加载完成事件中完成）
    }
    else//读取本地数据失败，可能数据已损坏，需重新登录系统下载数据
    {
        //清空本地数据，做等处操作(待完善)
        [userDefault setObject:@"" forKey:@"ticketid"];
        
        //回到登录页面
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

//读取页面所需数据
-(BOOL)readViewNeededData
{
    //读取院所信息数据
    //读取评估时间
    //读取个人信息
    
    //读取评估指标数据
    NSString* levelXMLPath = [[NSBundle mainBundle] pathForResource:@"level" ofType:@"xml"];
    _levelTable = [LevelTableCreator CreateTreeFromLevelXML:levelXMLPath];
    if (_levelTable==nil || [_levelTable isEqualToString:@""]) {
        //读取指标数据失败
        return false;
    }
    
    
    return true;
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
    
    WebViewModel *model  = [[WebViewModel alloc] init];
    self.jsContext[@"CallEachModel"] = model;
    model.jsContext = self.jsContext;
    model.webView = self.webView;
    model.currentVC = self;
    self.model = model;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    if (_levelTable!=nil && _levelTable.length>0) { //向页面发送评估指标数据
        [model ocCallJS:@"func2" withString:_levelTable];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
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
