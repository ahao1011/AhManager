//
//  BaseObject.h
//  BabyDemo
//
//  Created by ah on 15/10/16.
//  Copyright (c) 2015年 ah. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseObject : NSObject

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)modelWithDic:(NSDictionary *)dic;

@property (nonatomic,copy)NSString *name;

@property (nonatomic,copy)NSString *price;

@end
