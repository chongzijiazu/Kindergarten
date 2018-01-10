//
//  DownloadManagerViewController.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadManagerViewController : UIViewController
{
    UIProgressView* _downloadProgress; //下载进度
}
@property(nonatomic,retain)UIProgressView* downloadProgress;
@end
