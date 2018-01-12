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
    NSString* _levelTable;
}

@property (nonatomic, strong) WebViewModel* model;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation LevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString* levelXMLPath = [[NSBundle mainBundle] pathForResource:@"level" ofType:@"xml"];
    _levelTable = [LevelTableCreator CreateTreeFromLevelXML:levelXMLPath];
    //NSLog(@"%@",levelTable);
    
    NSString* basePath = [[NSBundle mainBundle] bundlePath];//mainBundle path
    NSURL* baseURL = [NSURL fileURLWithPath:basePath];
    NSLog(@"%@",basePath);
    
    //index.html path
    //NSString* htmlPath =[NSString stringWithFormat:@"%@/CallEach.html",basePath];
    NSString* htmlPath =[NSString stringWithFormat:@"%@/index.html",basePath];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    //loading local content
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
    
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scrollView.bounces = NO;
        //self.webView.scrollView.showsHorizontalScrollIndicator = NO;
        //self.webView.scrollView.scrollEnabled = NO;
        [self.webView sizeToFit];
        //忽略web页面与_WebView组件的大小关系如果设置为YES可以执行缩放，但是web页面加载出来的时候，就会缩小到UIWebView组件的大小
        //_webView.scalesPageToFit = NO;
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
    
    if (_levelTable!=nil && _levelTable.length>0) {
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
