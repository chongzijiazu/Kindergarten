//
//  LoginViewController.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/10.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "LoginViewController.h"
#import "Encryption.h"
#import "DownloadManagerViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
    _textField_Username = [[UITextField alloc] init];
    _textField_Username.frame = CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100, 300, 40);
    _textField_Username.placeholder = @"用户名";
    _textField_Username.borderStyle = UITextBorderStyleRoundedRect;
    _textField_Username.text = @"";
    _textField_Username.textColor = [UIColor blackColor];
    _textField_Username.font = [UIFont systemFontOfSize:20];
    _textField_Username.backgroundColor = [UIColor whiteColor];
    _textField_Username.clearsOnBeginEditing = YES; //当重复开始编辑时候 清除文字
    _textField_Username.secureTextEntry = NO;//文字密文（暗文） 该属性通常用于设置密码输入框
    _textField_Username.textAlignment = NSTextAlignmentLeft;//文字输入时的对齐方式
    [_textField_Username setAutocorrectionType:UITextAutocorrectionTypeNo];//关闭自动纠错功能
    [_textField_Username setAutocapitalizationType:UITextAutocapitalizationTypeNone];//关闭首字母大写功能
    [self.view addSubview:_textField_Username];
    
    _textField_Password = [[UITextField alloc] init];
    _textField_Password.frame = CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100+60, 300, 40);
    _textField_Password.placeholder = @"密码";
    _textField_Password.borderStyle = UITextBorderStyleRoundedRect;
    _textField_Password.text = @"";
    _textField_Password.textColor = [UIColor blackColor];
    _textField_Password.font = [UIFont systemFontOfSize:20];
    _textField_Password.backgroundColor = [UIColor whiteColor];
    _textField_Password.clearsOnBeginEditing = YES; //当重复开始编辑时候 清除文字
    _textField_Password.secureTextEntry = NO;//文字密文（暗文） 该属性通常用于设置密码输入框
    _textField_Password.textAlignment = NSTextAlignmentLeft;//文字输入时的对齐方式
    [self.view addSubview:_textField_Password];
    
    UIButton* btn_login = [[UIButton alloc] init];
    btn_login.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-100+60+60, 100, 40);
    [btn_login setTitle:@"登录" forState:UIControlStateNormal];
    [btn_login addTarget:self action:@selector(btn_login_clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_login];
}

-(void)btn_login_clicked
{
    /*NSLog(@"login");
    NSString* username = _textField_Username.text;
    NSString* password = _textField_Password.text;
    
    NSData* usernameData = [username dataUsingEncoding:NSUTF8StringEncoding];
    username = [usernameData base64EncodedStringWithOptions:1];
    password = [Encryption md5:password];
    NSDictionary *dict = @{@"account": username, @"password": password};
    
    [HttpRequestModel httpRequest:[HTTPInterface login] withParamters:dict isPost:YES withDeletegte:self success:@selector(successLogin:) failure:@selector(failureLogin:)];*/
    
    DownloadManagerViewController* downloadManagerVC = [[DownloadManagerViewController alloc] init];
    [self.navigationController pushViewController:downloadManagerVC animated:NO];
}

- (void)successLogin:(NSDictionary *)responseData
{
    if ([responseData[@"message"] isEqualToString:@"登录成功"])
    {
        /*NSDictionary *entity = responseData[@"entity"];
        NSDictionary *tempDict = entity[@"user"];
        
        //用户Id
        NSString *userId = [NSString stringWithFormat:@"%@", tempDict[@"id"]];
        
        if ([userId length])
            [userDefault setObject:userId forKey:@"USERID"];
        
        NSString *casUserId = [NSString stringWithFormat:@"%@", tempDict[@"casUserId"]];
        if ([casUserId length])
            [userDefault setObject:casUserId forKey:@"casUserId"];
        
        if ([tempDict.allKeys containsObject:@"nickname"])
            [userDefault setObject:tempDict[@"nickname"] forKey:@"nickname"];
        
        if ([tempDict.allKeys containsObject:@"email"])
            [userDefault setObject:tempDict[@"email"] forKey:@"email"];
        
        if ([tempDict.allKeys containsObject:@"mobile"])
            [userDefault setObject:tempDict[@"mobile"] forKey:@"mobile"];
        
        if ([entity.allKeys containsObject:@"memTime"])
            [userDefault setObject:entity[@"memTime"] forKey:@"cookieTime"];
        
        BLLog(@"cookieTime----%@", [userDefault objectForKey:@"cookieTime"]);
        
        [userDefault synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:self userInfo:nil];
        
        
        [self showAlertView:responseData[@"message"]];*/
    }
    else
    {
        [self showAlertView:responseData[@"message"]];
    }
}

- (void)failureLogin:(NSDictionary *)responseData
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertView:(NSString *)message
{
    NSString *title = @"提示";
    UIAlertController *alertController;
    
    //取消
    if (![message isEqualToString:@"登录成功"])
    {
        alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                       {}];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        [MBProgressHUD showSuccess:@"登录成功"];
        [self.navigationController popViewControllerAnimated:YES];
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
