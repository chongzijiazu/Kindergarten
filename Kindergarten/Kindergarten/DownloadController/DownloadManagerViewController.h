//
//  DownloadManagerViewController.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol DownloadManagerDelegate<NSObject>

-(void)sendIsSuccess:(BOOL)isSuccess;

@end

@interface DownloadManagerViewController : UIViewController
{
    UIProgressView* _downloadProgress; //下载进度
    UILabel* _lbl_downloadState;//下载状态（示例：1/4）
    int _currentDownloadCount;//当前下载第几个
    NSMutableArray* _downloadArray;//需要下载的文件数组
}
@property(nonatomic,retain)UIProgressView* downloadProgress;
@property(nonatomic,retain)UILabel* lbl_downloadState;
@property(nonatomic,assign)int currentDownloadCount;
@property(nonatomic,retain)NSMutableArray* downloadArray;

@property(nonatomic,weak)id<DownloadManagerDelegate> delegate;

@property (nonatomic, weak) WKWebView *webView;

@end
