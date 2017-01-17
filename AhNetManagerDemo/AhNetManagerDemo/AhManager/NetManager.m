//
//  NetManager.m
//  BreachApp
//
//  Created by ah on 16/4/11.
//  Copyright © 2016年 ah. All rights reserved.
//

// 项目打包上线都不会打印日志，因此可放心。
#ifdef DEBUG
#define BreachLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define HYBAppLog(s, ... )
#endif

#import "NetManager.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "MJExtension.h"
#import "AFNetworkReachabilityManager.h"
#import "SystemSet.h"
#import "AhResult.h"
#import "AhRequest.h"
#import "AFNetworkReachabilityManager.h"
#import "SystemSet.h"

/**接受SessionTask的数组*/
static NSMutableArray *TaskArr;

@implementation NetManager

/**网络连接状态-->实时监控网络状态的变化*/
+ (void)NetStatusNotiStart{
    
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
        switch  (status)  {
                
            case   AFNetworkReachabilityStatusReachableViaWWAN:
                
                [[NSNotificationCenter defaultCenter]postNotificationName:NET_CHANGE_WWAN object:nil];
            break;
                
            case   AFNetworkReachabilityStatusReachableViaWiFi:
                 [[NSNotificationCenter defaultCenter]postNotificationName:NET_CHANGE_WiFi object:nil];
            break;
                
            case   AFNetworkReachabilityStatusNotReachable:
                
                [[NSNotificationCenter defaultCenter]postNotificationName:NET_CHANGE_NotReachable object:nil];

                break;
            default:
                
                break;
                
        }
    }];
}

/**网络连接状态-->当前的网络状态*/
+ (NetType)CurrentNetstatus{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    
    if (status==AFNetworkReachabilityStatusNotReachable) {
        return NetTypeDisAble;
    }else if (status==AFNetworkReachabilityStatusReachableViaWWAN){
        return NetTypeWWAN;
    }else if (status==AFNetworkReachabilityStatusReachableViaWiFi){
        return NetTypeWifi;
    }
    return NetTypeUnknown;
}
/**检查是否能联网*/
+ (BOOL)isReachable{
    
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

#pragma mark- get
/**GEt*/
+ (AhSessionTask*)GET:(NSString *)URLString
 parameters:(AhResult*)Request
             progress:(void (^)(int64_t bytesRead,
                                int64_t totalBytesRead))Progress
    success:(void (^)(id responseObject,NSString*status))success
    failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *mgr = [self defautManager];
    
    URLString = [self absoluteUrlWithPath :URLString];
    
    NSDictionary *parameters = Request.mj_keyValues;
    if ([SystemSet defaultSet].DeBug) {  //  打开打印
        MJExtensionLog(@" 🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹 \n 请求模型:%@\n 参数为:\n %@ \n",[NSString stringWithUTF8String:class_getName(Request.class)],parameters);
    }
    AhSessionTask *task =  [mgr GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (Progress) {
            
            Progress(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       [self sucHandle:responseObject parameters:Request Url:URLString success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self failHandle:error parameters:Request Url:URLString failure:failure];
    }];
    if (task) {
        [[self allTasks]addObject:task];
    }
    return task;
}

#pragma mark- post
+(AhSessionTask*)POST:(NSString *)URLString
 parameters:(AhResult*)Request
             progress:(void (^)(int64_t bytesRead,
                                 int64_t totalBytesRead))Progress
    success:(void (^)(id responseObject,NSString*status))success
    failure:(void (^)(NSError *error))failure {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSDictionary *parameters = Request.mj_keyValues;
    AFHTTPSessionManager *mgr = [self defautManager];
    URLString = [self absoluteUrlWithPath:URLString];
    if ([SystemSet defaultSet].DeBug) {  //  打开打印
        MJExtensionLog(@" 🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹 \n 请求模型:%@\n 请求地址:%@ 请求参数为:\n %@ \n",[NSString stringWithUTF8String:class_getName(Request.class)],URLString,parameters);
    }
    AhSessionTask *task =  [mgr POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress ) {
        if (Progress) {
            Progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self sucHandle:responseObject parameters:Request Url:URLString success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        [self failHandle:error parameters:Request Url:URLString failure:failure];
    }];
    if (task) {
        [[self allTasks]addObject:task];
    }
    return task;
}
#pragma mark- 上传图片
/**上传图片*/
+ (AhSessionTask*)POST:(NSString *)URLString
            parameters:(AhResult*)Request
                 image:(UIImage *)image
              progress:(void (^)(int64_t bytesRead,
                                 int64_t totalBytesRead))Progress
               success:(void (^)(id responseObject,NSString*status))success
               failure:(void (^)(NSError *error))failure{
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSDictionary *parameters = Request.mj_keyValues;
    AFHTTPSessionManager *mgr = [self defautManager];
    URLString = [self absoluteUrlWithPath:URLString];
    if ([SystemSet defaultSet].DeBug) {  //  打开打印
        MJExtensionLog(@" 🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹 \n 请求模型:%@\n 请求地址:%@ 请求参数为:\n %@ \n",[NSString stringWithUTF8String:class_getName(Request.class)],URLString,parameters);
    }
    AhSessionTask *task =nil;
    
    task= [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *file = UIImagePNGRepresentation(image);
        //           NSData *data =  UIImageJPEGRepresentation(image, 0.001);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *name = [NSString stringWithFormat:@"%@.png", str];
        
        [formData appendPartWithFileData:file name:@"img" fileName:name mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (Progress) {
            Progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       [self sucHandle:responseObject parameters:Request Url:URLString success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self failHandle:error parameters:Request Url:URLString failure:failure];
    }];

    
    if (task) {
        [[self allTasks]addObject:task];
    }
    return task;
    
}

+ (NSString*)createCacheDirectory:(NSString*)path
{
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",path]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:fullPath]) {
        [fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return fullPath;
}
/**
 *  创建Document下的文件
 *
 *  @param path 路径描述
 *
 */
+ (NSString*)CreatDocumentDirectory:(NSString*)path fileName:(NSString*)fileName{
    
//    NSString *testPath3 = [testDirectory stringByAppendingPathComponent:@"test33.txt"]; 
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/%@", pathDocuments,path];
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *fullName = [createPath stringByAppendingPathComponent:fileName];
    return fullName;
    
    
}


#pragma mark- 下载文件

+ (AhSessionTask *)downloadWithUrl:(NSString *)URLString
                            saveToPath:(NSString *)SaveToPath
                          fileName:(NSString *)aFileName
                          progress:(void (^)(int64_t bytesRead,
                                             int64_t totalBytesRead))Progress
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure{
    
    //检查本地文件是否已存在
   
    NSString *fullPath = [self CreatDocumentDirectory:SaveToPath fileName:aFileName];
    
    AFHTTPSessionManager *mgr = [self defautManager];
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    
        if ([SystemSet defaultSet].DeBug) {  //  打开打印
            MJExtensionLog(@" 🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹 \n 下载地址:%@\n 保存路径为:\n %@ \n",URLString,SaveToPath);
        }
    AhSessionTask *task = nil;
    
    task = [mgr downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
            
            if (Progress) {
                Progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            return [NSURL URLWithString:fullPath];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            [[self allTasks] removeObject:task];
            
            if (error == nil) {
                if (success) {
                    
//                    success(filePath.absoluteString);
                }
                
                if ([SystemSet defaultSet].DeBug) {
                    NSLog(@"下载成功 路径 %@",fullPath);
                }
            } else {
                
                failure(error);
                
                if ([SystemSet defaultSet].DeBug) {
                    NSLog(@"下载失败 路径 %@, reason : %@",
                          fullPath,
                          [error description]);
                }
            }
        }];
        
        [task resume];  //  断点续传 校验
        
        //    [task suspend]; //  暂停下载
        
        if (task) {
            [[self allTasks]addObject:task];
        }
        return task;
}



#pragma mark- 默认管理者

+ (AFHTTPSessionManager *)defautManager{
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 设置请求时间
    manager.requestSerializer.timeoutInterval = 15;
    //  拿最原始的data数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    if ([SystemSet defaultSet].Header!=nil) {  //  使用者设置了公共请求头
        
        for (NSString *key in [SystemSet defaultSet].Header.allKeys) {
            if ([SystemSet defaultSet].Header[key]!=nil) {
                [manager.requestSerializer setValue:[SystemSet defaultSet].Header[key] forHTTPHeaderField:key];
            }
        }
        
    }
    
    //  设置可以接受的类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[
                                                                              @"application/json",
                                                                              @"text/html",
                                                                              @"text/xml",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*",
                                                                              @"image/png",
                                                                              ]];
    
    manager.operationQueue.maxConcurrentOperationCount = [SystemSet defaultSet].maxConcurrentOperationCount<9?[SystemSet defaultSet].maxConcurrentOperationCount:4;
   
    
    return manager;
}

#pragma mark- 合成URl
/**合成Url*/
+ (NSString*)MakeFullUrl:(NSString*)url{
    
    return [NSString stringWithFormat:@"%@%@%@",[SystemSet defaultSet].HOST,url,[SystemSet defaultSet].SUFFIX==nil?@"":[SystemSet defaultSet].SUFFIX];
}

#pragma mark- 由请求模型得到接受模型
/**由请求模型得到接受类模型的字符串*/
+ (NSString *)resultFromRequest:(AhResult*)request{
    
    NSString *requestClassName =  [NSString stringWithUTF8String:class_getName(request.class)];
    NSString *resultClassName = [NSString stringWithFormat:@"%@%@",requestClassName,[SystemSet defaultSet].Result_Request];
    return resultClassName;
}

#pragma mark- 请求url含有中文的处理

/**url含有中文时的处理*/
+ (NSString *)AhURLEncode:(NSString *)url {
    NSString *newString =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    
    return url;
}
#pragma mark- 获取所有请求SessionTask的数组单例
+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (TaskArr == nil) {
            TaskArr = [[NSMutableArray alloc] init];
        }
    });
    
    return TaskArr;
}
#pragma mark- 完整路径描述
+ (NSString *)absoluteUrlWithPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        MJExtensionLog(@"传入的url为nil或者空");
        return @"";
    }
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {  //  猜测path是一个片段
        absoluteUrl = [self MakeFullUrl:path];
    }
    return absoluteUrl;
}
#pragma mark- 取消全部网络请求

+ (void)cancelAllRequest {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(AhSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[AhSessionTask class]]) {
                [task cancel];
            }
        }];
        
        [[self allTasks] removeAllObjects];
    };
}

#pragma mark- 取消特定Url的网络请求

+ (void)cancelRequestWithURL:(NSString *)url {
    if (url == nil) {
        return;
    }
    
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(AhSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[AhSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}

#pragma mark- 将返回状态全部在success中暴露的 使用于 tableVIew加载数据时,返回status不是成功时也需要结束刷新状态的场景

+ (NSArray*)StatusResult{
    NSMutableArray *NewStatusResult = @[].mutableCopy;
    for (NSString *UrlString in [SystemSet defaultSet].StatusResult) {
        
        NSString *NewUrl = [self absoluteUrlWithPath :UrlString];
        [NewStatusResult addObject:NewUrl];
    }
    
    return NewStatusResult;
}

#pragma mark- 转圈
+ (void)showWaitView:(BOOL)IsShow{
    
}
#pragma mark- 抛异常
+ (void)showMessage:(NSString *)message{
    
   
}

#pragma mark- 转圈+定制描述
+ (void)showWaitView:(BOOL)IsShow withTitle:(NSString*)title{
    
    
}

#pragma mark - 网络成功后的处理
/**网络请求成功后的处理*/
+ (void)sucHandle:(id)responseObject parameters:(AhResult*)Request Url:(NSString *)URLString  success:(void (^)(id responseObject,NSString*status))success
{
    
    if (success) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *resultClassName = [self resultFromRequest:Request];
        Class aclass = NSClassFromString(resultClassName);
        AhResult *result = [aclass mj_objectWithKeyValues:dict];
        if (result==nil) {
            
            result = [AhResult mj_objectWithKeyValues:dict];
            resultClassName = @"AhResult";
        }
        
        if ([SystemSet defaultSet].DeBug) {  //  打开打印
            MJExtensionLog(@" 🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹  🈹🈹🈹 \n 接受模型:%@\n状态码:%@\n状态msg:%@\n 接受数据为:\n %@ \n",resultClassName,result.status,result.msg,dict);
        }
        if ([SystemSet defaultSet].SucStatus.length>0) {  // 含有自定义的成功状态码
            
            if ([result.status isEqualToString:[SystemSet defaultSet].SucStatus]) {
                
                success(result,[SystemSet defaultSet].SucStatus);
                
            }else{
                
                // 抛错
                MJExtensionLog(@"否❌否❌否❌否❌否❌否❌否❌ 抛出异常:%@\n status:%@\n 接受数据为:\n msg:%@ \n ",resultClassName,result.status,result.msg);
                if (result.msg) {
                    
                    [self showMessage:result.msg];
                }
                if ([[self StatusResult]containsObject:URLString]) {  // 某些特定的接口异常要暴露出去,
                    
                    success(result,result.status);
                }
            }
            
        }else{  // 未设置SucStatus 则 所有的状态都会通过句柄传递出去, 需要在业务界面自己判断  成功则处理业务逻辑,不成功 抛错
            success(result,result.status);
        }
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
#pragma mark - 网络请求失败后的处理
/**网络请求失败后的处理*/
+ (void)failHandle:(id)error parameters:(AhResult*)Request Url:(NSString *)URLString  failure:(void (^)(NSError *error))failure{
    
    if ([SystemSet defaultSet].DeBug) {  //  打开打印
        MJExtensionLog(@"否❌否❌否❌否❌否❌否❌否❌否❌否❌ \n 数据请求失败 \n: 请求模型:%@\n 请求路径:%@\n error: %@ \n\n\n",[NSString stringWithUTF8String:class_getName(Request.class)],URLString,error);
    }
    if (failure) {
        
        failure(error);
    }
    [error localizedDescription];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}








@end
