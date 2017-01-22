//
//  AhResult.h
//  AhNetManagerDemo
//
//  Created by ah on 2017/1/13.
//  Copyright © 2017年 ah. All rights reserved.
//

#import "BaseObject.h"

@interface AhResult : BaseObject

/**状态码  服务器自定义*/
@property (nonatomic,copy) NSString *status;
/**状态码信息*/
@property (nonatomic,copy) NSString *msg;

@end
