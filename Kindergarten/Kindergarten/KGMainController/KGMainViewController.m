//
//  KGMainViewController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/9.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "KGMainViewController.h"
#import "ZipUtil.h"

@interface KGMainViewController ()

@end

@implementation KGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton* btn_Test = [[UIButton alloc] init];
    btn_Test.frame = CGRectMake(100, 100, 100, 40);
    [btn_Test setTitle:@"Test" forState:UIControlStateNormal];
    [btn_Test setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_Test addTarget:self action:@selector(btn_Test_Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_Test];
    
}

-(void)btn_Test_Clicked
{
    //Document路径
    //NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    //NSString* newDirecPath = [documentPath stringByAppendingString:@"/001-001001-001001001-1"];
    //BOOL isgood = [[NSFileManager defaultManager] createDirectoryAtPath:newDirecPath withIntermediateDirectories:YES attributes:nil error:nil];
    //newDirecPath = [newDirecPath stringByAppendingPathComponent:@"001-001001-001001001-1.txt"];
    
    //BOOL isgood = [[NSFileManager defaultManager] createFileAtPath:newDirecPath contents:[@"hello" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    //BOOL isgood = [ZipUtil UZipArchive:@"001-001001-001001001-1.zip"];
    //NSLog(@"%@",documentPath);
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

@end
