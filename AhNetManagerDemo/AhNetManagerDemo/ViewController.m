//
//  ViewController.m
//  AhNetManagerDemo
//
//  Created by ah on 2017/1/17.
//  Copyright © 2017年 ah. All rights reserved.
//

#import "ViewController.h"

#import "TextResult.h"
#import "TextRequest.h"
#import "AhManager.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  网络请求前的一些设置  只设置一遍即可 一般在appdelegate中设置
    [SystemSet defaultSet].HOST = @"http://182.92.203.58:8010/";
    [SystemSet defaultSet].SUFFIX = @".ashx";
    [SystemSet defaultSet].SucStatus = @"200";


}


- (IBAction)btn1:(id)sender {
    
    //  网络请求示例
    Hea004 *request = [[Hea004 alloc]init];
    request.username = @"17011111111";
    request.userpwd = @"200820E3227815ED1756A6B531E7E0D2";
    [NetManager POST:Health004 parameters:request progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
    } success:^(id responseObject, NSString *status) {
        
        //  登录成功
        NSLog(@"登录成功");
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (IBAction)btn2:(id)sender {
    
    Bre011 *request = [[Bre011 alloc]init];
    request.action = @"addImg";
    UIImage *img = [UIImage imageNamed:@"test.png"];
    [NetManager POST:Breach011 parameters:request image:img progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        NSLog(@"图片上传%zd==总共%zd",bytesRead,totalBytesRead);
        
    } success:^(id responseObject,NSString*status) {
        
        Bre011Res *result = (Bre011Res *)responseObject;
        Bre011ResItem *item = result.data.firstObject;
        NSLog(@"路径:%@",item.picurl);
        [NetTool showmsg:@"上传成功" Tovc:self];
        
    } failure:^(NSError *error) {
        
        
        
    }];
}


@end
