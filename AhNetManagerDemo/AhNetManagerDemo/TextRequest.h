//
//  TextRequest.h
//  AhNetManagerDemo
//
//  Created by ah on 2017/1/13.
//  Copyright © 2017年 ah. All rights reserved.
//

#import "AhRequest.h"


/**post示例*/
static NSString * const Health004 = @"Login/Login";
/**上传图片示例*/
static NSString *const  Breach011 = @"Login/SaveImg";

@interface TextRequest : AhRequest

//  这里可以放置一些公共请求参数 ,每个接口都会发送的参数

//@property (nonatomic,copy)NSString *grkthTenk;

@end

@interface Hea004 : TextRequest

/**用户*/
@property (copy,nonatomic) NSString *username;
/**密码*/
@property (copy,nonatomic) NSString *userpwd;
@end

/**上传图片*/
@interface Bre011 : TextRequest
@property (nonatomic,copy) NSString *action;
@end
