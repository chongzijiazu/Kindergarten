//
//  JFKGLevelController.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/13.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface JFKGLevelController : NSObject
{
    NSArray* _sortedThirdLevelArray;//生序排序的三级指标id数组
}
@property(nonatomic,strong)NSArray* sortedThirdLevelArray;
@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, weak) UIViewController *currentVC;

-(BOOL)makeAssLevelFile;
-(NSString*)readLevelData;
-(void)sendLevelTableToView;
-(void)uploadData;
-(NSString*)getPreThirdLevelIdByCurrentThirdLevelId:(NSString*)currentThirdLevelId;
-(NSString*)getNextThirdLevelIdByCurrentThirdLevelId:(NSString*)currentThirdLevelId;

@end
