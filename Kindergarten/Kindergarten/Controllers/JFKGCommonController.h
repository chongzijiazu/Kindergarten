//
//  JFKGCommonController.h
//  Kindergarten
//
//  Created by junfeng on 2018/1/14.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "EnPaper.h"

@interface JFKGCommonController : NSObject<UIDocumentInteractionControllerDelegate>
@property(nonatomic,retain)UIDocumentInteractionController *docController;
@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, weak) UIViewController *currentVC;

-(void)logout;
-(BOOL)processFormulaInfo;
+(BOOL)saveFormulaValue:(NSDictionary*)dicFormula;
+(NSString*)getBaseInfo;
+(BOOL)SavePaperToDB;
+(EnPaper*)getPaperFromXMLPaper;
-(void)showHelpFile:(NSString*)helpfilepath;
+(void)copyFileToAppDesc;
-(NSString*)getFirsitNotFinishedQues:(NSString*)thirdLevelId;

@end
