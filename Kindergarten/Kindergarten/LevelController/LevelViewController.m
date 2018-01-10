//
//  LevelViewController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "LevelViewController.h"
#import "XMLDictionary.h"

@interface LevelViewController ()

@end

@implementation LevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSString* levelXMLPath = [[NSBundle mainBundle] pathForResource:@"level" ofType:@"xml"];
    //NSDictionary* dicLevel = [self getDictionaryFromXML:levelXMLPath];
    
    //NSLog(@"%@",dicLevel);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

//根据xml文件的路径，将xml文件转化成dictionary
-(NSDictionary*)getDictionaryFromXML:(NSString*)filePath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData* data = [NSData dataWithContentsOfFile:filePath];
        XMLDictionaryParser* parser = [[XMLDictionaryParser alloc] init];
        NSDictionary* dicXML = [parser dictionaryWithData:data];
        
        return dicXML;
    }
    else //文件不存在
    {
        return nil;
    }
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
