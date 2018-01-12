//
//  WebViewModel.m
//  Kindergarten
//
//  Created by junfeng on 2018/1/11.
//  Copyright © 2018年 Huayang inc. All rights reserved.
//

#import "WebViewModel.h"

@implementation WebViewModel


#pragma mark - jsCallOC

- (void)jsCallOC {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"jsCallOC"
                                                       delegate:nil
                                              cancelButtonTitle:@"I konw"
                                              otherButtonTitles:nil, nil];
        [alert show];
    });
}


- (void)jsCallOCWithString:(NSString *)string {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:string
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"I konw"
                                              otherButtonTitles:nil, nil];
        [alert show];
    });
}
- (void)jsCallOCWithTitle:(NSString *)title message:(NSString *)msg {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"I konw"
                                              otherButtonTitles:nil, nil];
        [alert show];
    });
}



- (void)jsCallOCWithDictionary:(NSDictionary *)dictionary {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:dictionary[@"title"]
                                                        message:dictionary[@"message"]
                                                       delegate:nil
                                              cancelButtonTitle:@"I konw"
                                              otherButtonTitles:nil, nil];
        [alert show];
    });
    
    NSLog(@"===== %@",dictionary);
}

- (void)jsCallOCWithArray:(NSArray *)array {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:array[0]
                                                        message:array[1]
                                                       delegate:nil
                                              cancelButtonTitle:@"I konw"
                                              otherButtonTitles:nil, nil];
        [alert show];
    });
    
    NSLog(@"===== %@",array);
}




#pragma mark - OCCallJS
- (void)ocCallJS {
    JSValue *jsFunc = self.jsContext[@"func1"];
    [jsFunc callWithArguments:nil];
}

- (void)ocCallJS:(NSString*)functionname withString:(NSString *)string {
    JSValue *jsFunc = self.jsContext[functionname];
    [jsFunc callWithArguments:@[string]];
}

- (void)ocCallJSWithTitle:(NSString *)title message:(NSString *)message {
    
}

- (void)ocCallJSWithDictionary:(NSDictionary *)dictionary {
    
}
- (void)ocCallJSWithArray:(NSArray *)array {
    
}

@end
