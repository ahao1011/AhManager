//
//  SystemSet.h
//  Pods
//
//  Created by ah on 2017/1/10.
//
//

#import <Foundation/Foundation.h>
@class UIViewController;
@interface SystemSet : NSObject

+ (instancetype)defaultSet;

/**公共请求头*/
@property (nonatomic,strong) NSDictionary *Header;

/**url公共头部分*/
@property (nonatomic,copy) NSString *HOST;

/**url公共尾部分*/
@property (nonatomic,copy) NSString *SUFFIX;

/**
 *AhResult 与 AhrRquest相比 多出的尾缀,
 *注意 若你只是一个项目适应NetManager,可以在pods中的AhRquest和AhResult实现根据业务应用编写数据模型, 切记,当执行pod install 或者pod update时我建议把这2个类先拷出来.等更新完成后再覆盖掉
 * 若你是若干个项目公用NetManger,你需要在自己的项目中建立AhRquest和AhResult的子类实现根据业务应用编写数据模型
 * 默认是"Res"
 */
@property (nonatomic,copy) NSString *Result_Request;

/**获取数据成功时服务器返回的状态码,默认不设置
 * 若不设置,服务器返回的所有类型状态码都会在对应Api接口的block块中输出
 * 若设置了数值,则只有当服务器返回正确状态码时对应Api接口的block块中输出responseObject才会有输出. 除非 该url在StatusResult中被设置了
 */
@property (nonatomic,copy) NSString *SucStatus;

/**登录超时状态码,若设置了 当超时时 会发出name=NOTI_LOGIN_OUT 的通知  为了方便 该属性生效的前提是SucStatus被赋值了
 */
@property (nonatomic,copy) NSString *LoginOutStatus;

/**单点登录, 本客户端被踢的状态码 若设置了 当被踢会发出name=NOTI_LOGIN_SINGLE的通知  为了方便 该属性生效的前提是SucStatus被赋值了
 */
@property (nonatomic,copy) NSString *LoginSiginleStatus;
/**暴露错误status的url集合*/
@property (nonatomic,copy) NSArray *StatusResult;
/**是否是要打印网络请求日志*/
@property (nonatomic,assign) BOOL DeBug;
/**设置最大并发数,设置过大容易出错 最大设置到9 默认4*/
@property (nonatomic,assign) NSInteger maxConcurrentOperationCount;
/**项目中当前图层的控制器,MBProgressHUD直接加载到keywindow貌似有些问题,这里留出了CurrentVc,供使用人自己选择,详细使用参加Demo*/
@property (nonatomic,strong) UIViewController *CurrentVc;



@end
