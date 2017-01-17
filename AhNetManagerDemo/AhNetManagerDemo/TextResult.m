//
//  TextResult.m
//  AhNetManagerDemo
//
//  Created by ah on 2017/1/13.
//  Copyright © 2017年 ah. All rights reserved.
//

//  data  数组  Bre036ResItem 数组中的数据模型

//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{
//             @"data" : @"Bre036ResItem",
//             };
//}

//  参数变换  posterName 是服务器给的  username  你用来接受的参数

//+ (NSDictionary *)mj_replacedKeyFromPropertyName
//{
//    return @{@"QyId" : @"id",
//             @"posterPostImage":@"piclist",
//             @"posterImgstr":@"headimg",
//             @"posterName":@"username",
//             @"posterContent":@"contents",
//             @"posterReplies":@"commonlist",
//             @"isFavour":@"ispraise"
//             };
//}


#import "TextResult.h"

@implementation TextResult

@end

@implementation Bre011Res

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"data" : @"Bre011ResItem",
             };
}
@end

@implementation Bre011ResItem

@end
