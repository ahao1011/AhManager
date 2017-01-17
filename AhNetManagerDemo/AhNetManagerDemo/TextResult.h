//
//  TextResult.h
//  AhNetManagerDemo
//
//  Created by ah on 2017/1/13.
//  Copyright © 2017年 ah. All rights reserved.
//

#import "AhResult.h"

@interface TextResult : AhResult

//  建立自己建立一个基于AhTesult的继承类, 这里边放置一些自己业务的公共返回参数, 当然Bre011Res 直接继承AhResult也是可以的
@end


/**上传图片*/
@interface Bre011Res : TextResult

@property (nonatomic,strong)NSArray *data;
@end

/**
 *  上传图片Item
 */
@interface Bre011ResItem : TextResult
/**图片名字*/
@property (nonatomic,copy)NSString *picname;
/**图片url*/
@property (nonatomic,copy)NSString *picurl;

@end

