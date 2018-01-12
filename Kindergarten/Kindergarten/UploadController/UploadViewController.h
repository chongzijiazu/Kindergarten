//
//  UploadViewController.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/12.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadViewController : UIViewController
{
    UIProgressView* _uploadProgress; //上传进度
    UILabel* _lbl_uploadState;//上传状态
}

@property(nonatomic,retain)UIProgressView* uploadProgress;
@property(nonatomic,retain)UILabel* lbl_uploadState;

@end
