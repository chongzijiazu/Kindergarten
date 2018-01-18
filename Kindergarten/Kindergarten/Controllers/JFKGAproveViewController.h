//
//  JFKGAproveViewController.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/18.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface JFKGAproveViewController : UIViewController
{
    NSString* _aproveItemId;//seqlevel_题号_序号，命名的证据
    NSString* _questionid;
    UIImageView* _aproveImageView;
}
@property(nonatomic,copy)NSString* aproveItemId;
@property(nonatomic,copy)NSString* questionid;
@property(nonatomic,strong)UIImageView* aproveImageView;

@property (nonatomic, weak) WKWebView *webView;

@end
