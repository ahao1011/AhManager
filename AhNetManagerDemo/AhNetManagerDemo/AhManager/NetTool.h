//
//  NetTool.h
//  AhNetManagerDemo
//
//  Created by ah on 2017/1/23.
//  Copyright © 2017年 ah. All rights reserved.
//

//  担任网络处理的一个工具类 处理一些边缘性功能

#import <Foundation/Foundation.h>
@class MBProgressHUD;
@class UIViewController;
@interface NetTool : NSObject

+ (MBProgressHUD*)showWaitWithText:(NSString*)text  ToVc:(UIViewController*)vc;
+ (MBProgressHUD*)showWaitViewToVc:(UIViewController*)vc;
+ (MBProgressHUD*)showWaitview;
+ (MBProgressHUD*)showmsg:(NSString*)msg Tovc:(UIViewController*)vc;
+ (MBProgressHUD*)showmsg:(NSString*)msg;
+ (void)hideHubFromVC:(UIViewController*)vc;
+ (void)hideHub;

@end
