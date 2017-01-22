//
//  SystemSet.m
//  Pods
//
//  Created by ah on 2017/1/10.
//
//

#import "SystemSet.h"

@implementation SystemSet

+ (instancetype)defaultSet{
    
    static SystemSet *set= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        set = [[SystemSet alloc]init];
        set.Result_Request = @"Res";
        set.DeBug = YES;
        set.maxConcurrentOperationCount = 4;
    });
    return set;
}

///**
// *  单例化 arc下的建立套路 非Arc下还需要考虑到copy retain autoreleass
// */
//+ (instancetype)defaultSet{
//    
//    static SystemSet *mt = nil;
//    // 线程锁
//    @synchronized (self){
//        
//        if (!mt) {
//            mt = [[self alloc]init];
//        }
//    }
//    return mt;
//}

@end
