//
//  RootViewController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/12.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "LevelViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

-(void)viewWillAppear:(BOOL)animated
{
    if (TICKETID!=nil && TICKETID.length!=0)
    {
        LevelViewController* levelVC = [[LevelViewController alloc] init];
        [self.navigationController pushViewController:levelVC animated:NO];
    }
    else
    {
        LoginViewController* loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:NO];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
