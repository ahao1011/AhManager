//
//  NetTool.m
//  AhNetManagerDemo
//
//  Created by ah on 2017/1/23.
//  Copyright © 2017年 ah. All rights reserved.
//




#import "NetTool.h"
#import "MBProgressHUD.h"

@implementation NetTool


+ (MBProgressHUD*)showWaitWithText:(NSString*)text  ToVc:(UIViewController*)vc{
    
    NSString *msg = text.length>0?text:@"加载中...";
    UIView *view = vc!=nil?vc.view:[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.mode = MBProgressHUDModeIndeterminate;
    hub.label.text = msg;
    hub.label.textAlignment = NSTextAlignmentCenter;
    hub.removeFromSuperViewOnHide = YES;
    
    return hub;
}
+ (MBProgressHUD*)showWaitViewToVc:(UIViewController*)vc{
    
    return [self showWaitWithText:nil ToVc:vc];
}
+ (MBProgressHUD*)showWaitview{
    
    return [self showWaitWithText:nil ToVc:nil];
}

+ (MBProgressHUD*)showmsg:(NSString*)msg Tovc:(UIViewController*)vc{
    
    UIView *view = vc!=nil?vc.view:[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.label.text = msg;
    hub.mode = MBProgressHUDModeText;
    hub.label.textAlignment = NSTextAlignmentCenter;
    hub.label.numberOfLines = 0;
    hub.margin = 10.f;
    hub.removeFromSuperViewOnHide = YES;
    [hub hideAnimated:YES afterDelay:1.5];
    return hub;
}
+ (MBProgressHUD*)showmsg:(NSString*)msg{
    
    return [self showmsg:msg Tovc:nil];
}
+ (void)hideHubFromVC:(UIViewController*)vc{
    
    UIView *view = vc!=nil?vc.view:[UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideHUDForView:view animated:YES];
}
+ (void)hideHub{
    
    [self hideHubFromVC:nil];
}
@end
