//
//  NetManager.h
//  BreachApp
//
//  Created by ah on 16/4/11.
//  Copyright © 2016年 ah. All rights reserved.
//

//  网络变化的通知  注意对应通知的销毁

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 通知

/**更改为数据流量*/
static  NSString *NET_CHANGE_WWAN = @"NET_CHANGE_WWAN";
/**更改为无线*/
static  NSString *NET_CHANGE_WiFi = @"NET_CHANGE_WiFi";
/**更改为无网络*/
static  NSString *NET_CHANGE_NotReachable = @"NET_CHANGE_NotReachable";

@class AhRequest;

typedef enum {  // 网络状态
    
    /**不可用*/
    NetTypeDisAble,
    /**未知*/
    NetTypeUnknown,
    /**wifi*/
    NetTypeWifi,
    /**数据流量*/
    NetTypeWWAN
    
}NetType;

typedef NSURLSessionTask AhSessionTask;



@interface NetManager : NSObject


#pragma mark- 基本配置

//  配置转移到SystemSet类中去

#pragma mark- 功能区
/**
 *检查是否能联网
 */
+ (BOOL)isReachable;
/**
 *  开始网络监控
 */
+ (void)NetStatusNotiStart;
/**
 *  网络连接状态-->当前的网络状态
 *
 */
+ (NetType)CurrentNetstatus;
/**
 *  @author Ah, 16-04-15 11:04:22
 *
 *  get的异步请求
 */
+ (AhSessionTask*)GET:(NSString *)URLString
 parameters:(AhRequest*)Request
             progress:(void (^)(int64_t bytesRead,
                                int64_t totalBytesRead))Progress
    success:(void (^)(id responseObject,NSString*status))success
    failure:(void (^)(NSError *error))failure;

/**post的异步请求*/
+(AhSessionTask*)POST:(NSString *)URLString
           parameters:(AhRequest*)Request
             progress:(void (^)(int64_t bytesRead,
                                int64_t totalBytesRead))Progress
              success:(void (^)(id responseObject,NSString*status))success
              failure:(void (^)(NSError *error))failure ;
/**上传图片*/
+ (AhSessionTask*)POST:(NSString *)URLString
            parameters:(AhRequest*)Request
                 image:(UIImage *)image
              progress:(void (^)(int64_t bytesRead,
                                 int64_t totalBytesRead))Progress
               success:(void (^)(id responseObject,NSString*status))success
               failure:(void (^)(NSError *error))failure ;
/**
 *  下载文件
 *
 *  @param URLString  下载路径
 *  @param SaveToPath 保存路径
 *  @param Progress   进度描述
 *  @param success    成功句柄
 *  @param failure    失败句柄
 */
+ (AhSessionTask *)downloadWithUrl:(NSString *)URLString
                        saveToPath:(NSString *)SaveToPath
                          fileName:(NSString *)aFileName
                          progress:(void (^)(int64_t bytesRead,
                                             int64_t totalBytesRead))Progress
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

/**
 *  取消全部请求
 */
+ (void)cancelAllRequest;
/**
 *  取消特定请求
 *
 *  @param url url路径
 */
+ (void)cancelRequestWithURL:(NSString *)url ;




@end
